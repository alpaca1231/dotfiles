# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Github CLI
eval "$(gh completion -s zsh)"

# starship
eval "$(starship init zsh)"
