# 重複したコマンドは保存しない
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt pushd_ignore_dups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
