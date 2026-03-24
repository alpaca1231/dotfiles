#!/usr/bin/env zsh

# Cursor 拡張を一括インストール（初回セットアップ用）
# リストはリポジトリ直下の cursor-extensions.txt（cursor --list-extensions の出力をベースに精査）

if ! command -v cursor &>/dev/null; then
  echo "cursor コマンドが見つかりません。Cursor をインストールしてから再実行してください。" >&2
  exit 0
fi

if ! command -v chezmoi &>/dev/null; then
  echo "chezmoi が見つかりません。" >&2
  exit 0
fi

src="$(chezmoi source-path)"
list="$src/cursor-extensions.txt"

if [[ ! -f "$list" ]]; then
  echo "拡張リストが見つかりません: $list" >&2
  exit 0
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "${line// }" ]] && continue
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  ext="${line//$'\r'/}"
  ext="${ext//[[:space:]]/}"
  [[ -z "$ext" ]] && continue
  cursor --install-extension "$ext" || true
done < "$list"
