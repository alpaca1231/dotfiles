# Homebrew の補完定義を FPATH に追加
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# 補完システムの初期化
autoload -Uz compinit && compinit -C

# cdable_vars を無効にし、変数名だけで cd できる挙動を防ぐ
unsetopt cdable_vars

# コマンドミスを修正候補で提示する
setopt correct

# 補完メニューを矢印キーで選択できるようにする
zstyle ':completion:*:default' menu select=2

# 大文字小文字を区別しない補完（小文字入力で大文字もマッチ）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補をグループ表示する
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
