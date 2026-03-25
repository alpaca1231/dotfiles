# Cursor extensions

Cursor の拡張機能を管理しています。

## 前提

- `cursor` コマンドが PATH で使えること
- 拡張機能リストは `publisher.extensionname` 形式で記載すること

## 運用

1. Cursor で拡張を追加・削除したあと、`export.sh` を実行して `extensions.txt` を更新する
2. 変更を chezmoi で反映する
3. 別マシンでは、リポジトリを更新したうえで `import.sh` を実行する

`import.sh` は既に入っている拡張に対しても `cursor --install-extension` を呼びます（失敗してもスクリプトは続行します）

### Export

```zsh
# エクスポート（現在の拡張一覧を extensions.txt に書き出す）
zsh "$(chezmoi source-path)/scripts/cursor-extensions/export.sh"
```

### Import

```zsh
# インポート（extensions.txt の拡張を一括インストール）
zsh "$(chezmoi source-path)/scripts/cursor-extensions/import.sh"
```
