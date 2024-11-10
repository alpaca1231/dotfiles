# colorsを使用
autoload -Uz colors && colors

# cdの後にlsを実行
chpwd() { ls -G --color=auto }

# ディレクトリ名を入力したら自動でcdする
setopt auto_cd
setopt auto_pushd
