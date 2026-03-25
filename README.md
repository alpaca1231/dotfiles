# dotfiles

新しいMacでの環境構築を自動化するための`dotfiles`

Provisioned by [chezmoi](https://www.chezmoi.io/)

## Bootstrap

- Xcode Command Line Tools
- Homebrew
- 1Password(App)
- 1Password-CLI
- chezmoi

```zsh
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/alpaca1231/dotfiles/main/bootstrap.sh)"
```

## Installation
```zsh
chezmoi init --apply alpaca1231
```

## Update
```zsh
chezmoi update
```

## Cursor 拡張（export / import）

`scripts/cursor-extensions/` で Cursor の拡張機能リストを管理しています。

```zsh
# エクスポート（現在の拡張一覧を extensions.txt に書き出す）
zsh "$(chezmoi source-path)/scripts/cursor-extensions/export.sh"

# インポート（extensions.txt の拡張を一括インストール）
zsh "$(chezmoi source-path)/scripts/cursor-extensions/import.sh"
```

拡張を追加・削除したあとは `export.sh` を実行してコミットしてください。

---

## dotfilesで管理されていないツール

- [kensingtonWorks](https://www.kensington.com/ja-jp/software/kensingtonworks/)
  - 設定ファイルはGoogleDrive経由で取得
- [HHKB キーマップ変更ツール](https://happyhackingkb.com/jp/download/)
  - 設定は本体に記録されている
- [HHKB Studio キーマップ変更ツール](https://happyhackingkb.com/jp/download/)
  - 設定は本体に記録されている
