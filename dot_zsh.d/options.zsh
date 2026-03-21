# colorsを使用
autoload -Uz colors && colors

# cdの後にlsを実行
chpwd() { ls -G --color=auto }

# ディレクトリ名を入力したら自動でcdする
setopt auto_cd
setopt auto_pushd

# Space キーで alias をフルコマンドに展開する
function my-expand-alias() {
  zle _expand_alias
  zle self-insert
}
zle -N my-expand-alias
bindkey ' ' my-expand-alias
