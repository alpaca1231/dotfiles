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

## Edgeブックマーク

Edgeのブックマークは `edge_bookmarks.html` で管理しています。

### エクスポート（現在のブックマークを保存）
1. Edgeで `edge://settings/importexport` を開く
2. 「お気に入りをエクスポートする」でHTMLファイルをダウンロード
3. ダウンロードしたファイルを `~/.local/share/chezmoi/edge_bookmarks.html` に上書き

### インポート（ブックマークを復元）
1. `chezmoi apply` でファイルを展開
2. Edgeで `edge://settings/importexport` を開く
3. 「インポート」→「お気に入りまたはブックマークのHTMLファイル」を選択
4. `~/edge_bookmarks.html` をインポート

---

## dotfilesで管理されていないツール

- [kensingtonWorks](https://www.kensington.com/ja-jp/software/kensingtonworks/)
  - 設定ファイルはGoogleDrive経由で取得
- [HHKB キーマップ変更ツール](https://happyhackingkb.com/jp/download/)
  - 設定は本体に記録されている
- [HHKB Studio キーマップ変更ツール](https://happyhackingkb.com/jp/download/)
  - 設定は本体に記録されている
