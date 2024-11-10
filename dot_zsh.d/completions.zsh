# 入力補完を有効にする
autoload -Uz compinit && compinit

# Homebrewの入力補完を有効にする
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# 不要なディレクトリ名が補完されるのを無効にする (@see https://senooken.jp/post/2014/05/11/2717/)
unsetopt cdable_vars

# コマンドミスを修正
setopt correct

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2
