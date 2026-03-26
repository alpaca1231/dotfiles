# ブラウザ拡張

## 方針

[Arc Sync は拡張機能を同期しない](https://resources.arc.net/hc/en-us/articles/20272860828823-Arc-Sync)ため、移行元のブラウザから拡張機能のリストを出力して移行先の Mac で Chrome Web Store のページを開いて拡張を追加することで移行を補助する。

## 運用

1. ブラウザで拡張を追加・削除したら、`export-extensions.sh` を実行して拡張リストを更新する
2. 変更をコミットする
3. 新しい Mac で `chezmoi update` のあと `open-extensions.sh` を実行し、開いた Chrome Web Store の各ページでブラウザに追加する

### Export

```zsh
# fzf でブラウザ → プロファイルを対話選択
zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh"

# ブラウザを指定（プロファイルは fzf で選択）
zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh" -b arc

# ブラウザとプロファイルを両方指定
zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh" -b arc Default
```

出力: `extensions-arc-Default.txt`（プロファイル名のスペースはアンダースコアに変換）

### Open（ストアページをブラウザで開く）

```zsh
# fzf で対象ファイルを対話選択（デフォルトブラウザで開く）
zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh"

# ファイル名を直接指定
zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh" extensions-arc-Default.txt

# -b でブラウザを指定
zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh" -b arc extensions-arc-Default.txt
```

### cocopy の復元

[cocopy](https://chromewebstore.google.com/detail/cocopy/ihnfodlbkhgjnbheemjhkjfkfglgbdgc) のカスタム関数は共有 URL で install できる。
`cocopy-functions.txt` に共有 URL を保存しておき、新しい Mac では URL を 1 つずつブラウザで開いて install する。

## ファイル

| ファイル                             | 説明                                                  |
| ------------------------------------ | ----------------------------------------------------- |
| `extensions-{BROWSER}-{PROFILE}.txt` | 拡張リスト                                            |
| `export-extensions.sh`               | 拡張リストをエクスポート（`-b` でブラウザ指定）       |
| `open-extensions.sh`                 | 拡張リストのストアページを開く（`-b` でブラウザ指定） |
| `cocopy-functions.txt`               | cocopy の関数 install URL                             |
