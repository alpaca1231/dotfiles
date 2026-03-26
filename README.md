# dotfiles

新しい Mac での環境構築を自動化するための dotfiles

Provisioned by [chezmoi](https://www.chezmoi.io/)

## セットアップ

### 1. Bootstrap

以下のコマンドで前提ツールをまとめてインストールします。

```zsh
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/alpaca1231/dotfiles/main/bootstrap.sh)"
```

スクリプトが自動的にインストール・設定するもの:

- Xcode Command Line Tools
- Rosetta 2（Apple Silicon の場合）
- Homebrew
- 1Password & 1Password CLI（SSH エージェント・GitHub 接続確認を含む）
- chezmoi

### 2. dotfiles の適用

```zsh
chezmoi init --apply alpaca1231
```

初回実行時に名前とメールアドレスを聞かれます（`.gitconfig` で使用）。

### 3. 更新

```zsh
chezmoi update
```

## Edgeブックマーク

Edgeのブックマークは `edge_bookmarks.html` で管理しています。

### エクスポート（現在のブックマークを保存）

1. Edgeで `edge://favorites/` を開く
2. 「お気に入りをエクスポートする」でHTMLファイルをダウンロード
3. ダウンロードしたファイルを `~/.local/share/chezmoi/edge-bookmarks.html` に上書き

### インポート（ブックマークを復元）

1. `chezmoi apply` でファイルを展開
2. Edgeで `edge://favorites/` を開く
3. 「インポート」→「お気に入りまたはブックマークのHTMLファイル」を選択
4. `~/edge-bookmarks.html` をインポート

---

## リポジトリ構成

| パス                                       | 内容                                                                                                           |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| `.chezmoi.toml.tmpl`                       | chezmoi テンプレート変数（name / email）と `chezmoi edit` の設定                                               |
| `dot_gitconfig.tmpl`                       | Git グローバル設定（1Password SSH 署名）                                                                       |
| `dot_Brewfile`                             | Homebrew Bundle（brew / cask / mas）                                                                           |
| `dot_zprofile`                             | Zsh ログイン時の初期化                                                                                         |
| `dot_zshrc` / `dot_zsh.d/`                 | Zsh 設定（alias, git, completions, history, options, path）                                                    |
| `dot_config/`                              | starship, mise, gh, karabiner, nvim, raycast                                                                   |
| `Library/Application Support/Cursor/User/` | Cursor の settings / keybindings / snippets                                                                    |
| `scripts/cursor-extensions/`               | Cursor 拡張機能の手動エクスポート・インポート（[詳細](scripts/cursor-extensions/README.md)）                   |
| `scripts/browser-extensions/`              | ブラウザ拡張機能のエクスポート・ストアからの再インストール補助（[詳細](scripts/browser-extensions/README.md)） |
| `run_once_*.sh`                            | chezmoi apply 時に一度だけ実行されるスクリプト                                                                 |
| `bootstrap.sh`                             | 初回セットアップ用スクリプト                                                                                   |

## dotfiles で管理されていないツール

- [KensingtonWorks](https://www.kensington.com/ja-jp/software/kensingtonworks/) — 設定ファイルは Google Drive 経由で取得
- [HHKB キーマップ変更ツール](https://happyhackingkb.com/jp/download/) — 設定は本体に記録
- [HHKB Studio キーマップ変更ツール](https://happyhackingkb.com/jp/download/) — 設定は本体に記録
