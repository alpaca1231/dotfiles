#!/usr/bin/env zsh

# extensions.txt に記載された拡張を Cursor に一括インストールする

if ! command -v cursor &>/dev/null; then
  echo "cursor コマンドが見つかりません。Cursor をインストールしてから再実行してください。" >&2
  exit 1
fi

SCRIPT_DIR="${0:a:h}"
LIST="$SCRIPT_DIR/extensions.txt"

if [[ ! -f "$LIST" ]]; then
  echo "拡張リストが見つかりません: $LIST" >&2
  exit 1
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "${line// }" ]] && continue
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  ext="${line//$'\r'/}"
  ext="${ext//[[:space:]]/}"
  [[ -z "$ext" ]] && continue
  cursor --install-extension "$ext" || true
done < "$LIST"
