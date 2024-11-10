# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$PATH:$VOLTA_HOME/bin"

# Github CLI
eval "$(gh completion -s zsh)"

# starship
eval "$(starship init zsh)"
