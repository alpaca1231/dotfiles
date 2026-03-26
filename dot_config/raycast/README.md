# Raycast config

---

## Export

### コマンド（推奨）

1. Raycast を開く
2. 検索で **`Export Settings & Data`** と入力し、コマンドを実行する
3. 保存ダイアログで保存先フォルダを選ぶ
   chezmoi で管理する場合は **`~/.config/raycast/`** を指定する
4. 必要ならパスフレーズを入力してエクスポートする

### 設定画面

1. Raycast を開き、**⌘ ,** で **Preferences** を開く
2. **Advanced** タブを開く
3. **Export** を実行し、保存先を選ぶ

---

## import

### コマンド（推奨）

1. Raycast を開く
2. 検索で **`Import Settings & Data`** と入力し、コマンドを実行する
3. インポートする **`.rayconfig` ファイル** を選択する（例: `~/.config/raycast/Raycast yyyy-mm-dd hh.mm.ss.rayconfig`）
4. 求められたらパスフレーズを入力する
5. 内容を確認するダイアログが出たら、表示に従って **Import** / **Continue** などで完了する

### 設定画面

1. **⌘ ,** で **Preferences** を開く
2. **Advanced** タブを開く
3. **Import** を実行し、`.rayconfig` ファイルを選ぶ

---

## chezmoi で取り込むとき

1. 上記の手順で **~/.config/raycast/** に `.rayconfig` を保存する
2. ソースに反映する:
   `chezmoi add ~/.config/raycast/`
