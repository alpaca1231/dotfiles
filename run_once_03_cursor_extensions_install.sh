#!/usr/bin/env zsh

if command -v cursor &> /dev/null; then
    echo "Installing Cursor extensions"
    xargs -L 1 cursor --install-extension < ~/.config/chezmoi/.cursor/extensions.txt
else
  echo "Cursorコマンドがインストールされていません"
fi
