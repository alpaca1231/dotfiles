# ブラウザ拡張

## 方針

ブラウザの同期機能に頼らず拡張機能を引き継げるように、移行元のブラウザから拡張機能のリストを出力してリポジトリで管理する。移行先の Mac では Chrome Web Store のページを順に開いて拡張を追加することで移行を補助する。

## 運用

1. ブラウザで拡張を追加・削除したら、`export-extensions.sh` を実行して拡張リストを更新する
2. 変更をコミットする
3. 新しい Mac で `chezmoi update` のあと `open-extensions.sh` を実行し、開いた Chrome Web Store の各ページでブラウザに追加する

拡張リストには ID ごとに拡張名をコメントで併記している。またブラウザ同梱の内部拡張と会社のポリシー配布の拡張はストアページから追加できないため除外している。`export-extensions.sh` はファイルを上書きしてこの 2 つを反映しないので、実行後に手で入れ直す。

### Export

```zsh
# fzf でブラウザ → プロファイルを対話選択
zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh"

# ブラウザを指定（プロファイルは fzf で選択）
zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh" -b chrome

# ブラウザとプロファイルを両方指定
zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh" -b chrome Default
```

出力: `extensions-chrome-Default.txt`（プロファイル名のスペースはアンダースコアに変換）

### Open（ストアページをブラウザで開く）

```zsh
# fzf で対象ファイルを対話選択（デフォルトブラウザで開く）
zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh"

# ファイル名を直接指定
zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh" extensions-chrome-Default.txt

# -b でブラウザを指定
zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh" -b chrome extensions-chrome-Default.txt
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
