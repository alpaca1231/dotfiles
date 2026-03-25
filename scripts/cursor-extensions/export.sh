#!/usr/bin/env zsh

# 現在 Cursor にインストールされている拡張の一覧を extensions.txt に書き出す

if ! command -v cursor &>/dev/null; then
  echo "cursor コマンドが見つかりません。" >&2
  exit 1
fi

SCRIPT_DIR="${0:a:h}"
LIST="$SCRIPT_DIR/extensions.txt"

{
  echo "# Cursor 拡張 ID の一覧（1行1件、# 行はコメント）"
  echo "# export.sh で自動生成、手動で編集しても OK"
  cursor --list-extensions 2>/dev/null | grep -v '^$' | sort
} > "$LIST"

echo "extensions.txt を更新しました: $LIST"
