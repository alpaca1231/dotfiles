#!/usr/bin/env zsh

if ! command -v cursor &> /dev/null; then
  log_error "Cursorコマンドがインストールされていません"
  exit 1
fi

xargs -n 1 cursor --install-extension < ~/.config/chezmoi/cursor/extensions.txt
