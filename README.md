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

---

## dotfilesで管理されていないツール

- [kensingtonWorks](https://www.kensington.com/ja-jp/software/kensingtonworks/)
  - 設定ファイルはGoogleDrive経由で取得
- [HHKB キーマップ変更ツール](https://happyhackingkb.com/jp/download/)
  - 設定は本体に記録されている
