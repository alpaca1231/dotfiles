HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# 連続する同一コマンドを履歴に入れない
setopt hist_ignore_dups
# 履歴全体で重複を除去（古い方を消す）
setopt hist_ignore_all_dups
# 余分な空白を詰めて保存する
setopt hist_reduce_blanks
# 行頭がスペースのコマンドを履歴に残さない（機密コマンド向け）
setopt hist_ignore_space
# 複数ターミナル間で履歴を共有する
setopt share_history

# pushd の重複を無視する
setopt pushd_ignore_dups
