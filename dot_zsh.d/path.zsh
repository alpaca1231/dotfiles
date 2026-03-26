# mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# GitHub CLI
if command -v gh &>/dev/null; then
  eval "$(gh completion -s zsh)"
fi

# starship
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
