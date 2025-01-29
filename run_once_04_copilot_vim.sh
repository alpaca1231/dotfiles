#!/usr/bin/env zsh

# neovimがインストールされてない場合はインストール
if ! command -v nvim &> /dev/null; then
    echo "neovimをインストールします"
    brew install neovim
fi

# neovimの設定ディレクトリを作成
mkdir -p "$HOME/.config/nvim"

# copilot.vimをインストール
COPILOT_DIR="$HOME/.config/nvim/pack/github/start/copilot.vim"

if [ ! -d "$COPILOT_DIR" ]; then
    echo "copilot.vimをインストールします"
    git clone https://github.com/github/copilot.vim.git "$COPILOT_DIR"
    echo "copilot.vimをインストール完了しました"
else
    echo "copilot.vimは既にインストールされています"
fi

echo "Copilotを有効にするため、nvimを起動してCopilotを認証してください"
echo
echo "    nvim -c 'Copilot setup'"
echo
echo "    :Copilot status"
