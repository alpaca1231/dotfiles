# dotfiles
新しいMacでの環境構築を自動化するための`dotfiles`

Provisioned by [chezmoi](https://www.chezmoi.io/)


## Bootstrap

- Xcode Command Line Tools
- Homebrew
- 1Password(App)
- 1Password-CLI
- chezmoi

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alpaca1231/dotfiles/main/bootstrap.sh)"
```

## Installation
```bash
chezmoi init --apply alpaca1231
```

## Update
```bash
chezmoi update
```
