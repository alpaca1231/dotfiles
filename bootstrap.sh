#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log() {
  echo -e "\n${CYAN}[INFO] $1${NC}\n"
}

log_skip() {
  echo -e "\n${CYAN}[SKIP] $1${NC}\n"
}

log_warning() {
  echo -e "\n${YELLOW}[WARNING] $1${NC}\n"
}

log_success() {
  echo -e "\n${GREEN}[SUCCESS] $1${NC}\n"
}

log_error() {
  echo -e "\n${RED}[ERROR] $1${NC}\n"
}

log "事前準備を開始します"

# Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
  log "Xcode Command Line Toolsをインストールします"
  xcode-select --install

  # ユーザーの確認が必要なため、インストールが完了するまで待機
  log_warning "インストールが完了するまで待機しています..."
  until xcode-select -p &> /dev/null; do
    sleep 10
  done
  log_success "Xcode Command Line Toolsのインストールが完了しました"
else
  log_skip "Xcode Command Line Toolsは既にインストールされています"
fi

# Homebrew
if ! command -v brew &> /dev/null; then
  log "Homebrewをインストールします"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrewを最新にアップデートします"
  brew update
fi

# 1Password
if [ ! -d "/Applications/1Password.app" ]; then
  log "1Passwordをインストールします"
  brew install --cask 1password

  # 1Passwordの設定
  log_warning "1PasswordにログインしてSSHエージェントを有効にしてください"
  open -a "1Password"

  # ユーザーの確認が必要なため、設定が完了するまで待機
  log_warning "設定が完了するまで待機しています..."
  until [ -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ]; do
    sleep 10
  done
  log_success "1Passwordの設定が完了しました"
else
  log_skip "1Passwordは既にインストールされています"
fi

# 1Password SSH エージェントの設定
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# GitHub との接続確認
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  log_success "GitHub との SSH 接続が成功しました"
else
  log "GitHub との接続に失敗しました"

  if ssh-add -l | grep -q "No such file or dirctory"; then
    log_error "1Password の設定から Use the SSH agent を有効にしてください"
  fi

  if ssh-add -l | grep -q "no identities"; then
    log_error "1Password に SSH キーが登録されていません"
  fi

  exit 1
fi

# chezmoi
if ! command -v chezmoi &> /dev/null; then
  log "chezmoiをインストールします"
  brew install chezmoi
else
  log_skip "chezmoiは既にインストールされています"
fi

log "セットアップの準備が完了しました 🎉"
