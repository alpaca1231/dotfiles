#!/usr/bin/env zsh

if command -v cursor &> /dev/null; then
    echo "Installing Cursor extensions"
    xargs -L 1 cursor --install-extension < ~/.cursor/extensions.txt
else
  echo "Cursorコマンドがインストールされていません"
fi
