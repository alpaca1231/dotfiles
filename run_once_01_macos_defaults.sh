#!/usr/bin/env zsh

# @see https://macos-defaults.com/

# システム環境設定を終了
osascript -e 'tell application "System Preferences" to quit'

# 管理者権限を事前に取得
sudo -v

# 実行中は定期的に sudo 認証を延長する
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


########## General ##########

# 起動時のサウンドをオフ
sudo nvram StartupMute=%01

# ダークモードをオン
defaults write -g AppleInterfaceStyle -string "Dark"

# アクセントカラーをGreenに設定
defaults write -g AppleAccentColor -int 3

# ハイライトカラーをGreenに設定
defaults write -g AppleHighlightColor -string "0.752941 0.964706 0.678431 Green"

# 自動大文字の設定をオフ
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# ウィンドウのリサイズと移動を高速化
defaults write -g NSWindowResizeTime -float 0.001


########## TrackPad ##########

# 軌跡の速さを最速
defaults write -g com.apple.trackpad.scaling -int 3

# クリックを最弱
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0

# サイレントクリックをオン
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 1

# 調べる&データ検出を3本指でタップ
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2

# 副ボタンのクリック
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0

# タップでクリックをオン
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -bool true

# ナチュラルスクロールをオン
defaults write -g com.apple.swipescrolldirection -bool true


########## Mouse ##########

# 軌跡の速さを最速
defaults write -g com.apple.mouse.scaling -int 3


########## Keyboard ##########

# キーリピートを最速
defaults write -g KeyRepeat -int 1

# リピート入力認識までの時間を最速
defaults write -g InitialKeyRepeat -int 10

# フルキーボードアクセスをオン
defaults write -g AppleKeyboardUIMode -int 2


########## Shortcut ##########

# Spotlight検索を表示をオフ
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters ( 65535, 49, 1048576 ); type = standard; }; };"

# Finderの検索ウインドウを表示をオフ
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; value = { parameters ( 65535, 49, 1048576 ); type = standard; }; };"

# 画面のピクチャをファイルとして保存をオフ
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 "{ enabled = 0; value { parameters ( 51, 20, 1441792 ); type = standard; }; };"

# 画面のピクチャをクリップボードにコピーをShift + command + 3に設定
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 "{ enabled = 1; value { parameters ( 51, 20, 1179648 ); type = standard; }; };"

# 選択部分のピクチャをファイルとして保存をオフ
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 "{ enabled = 0; value { parameters ( 52, 21, 1441792 ); type = standard; }; };"

# 選択部分のピクチャをクリップボードにコピーをShift + command + 4に設定
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 "{ enabled = 1; value { parameters ( 52, 21, 1179648 ); type = standard; }; };"

########## Dock ##########

# すべてのアプリを消す
defaults write com.apple.dock persistent-apps -array

# 自動的に隠すをオン
defaults write com.apple.dock autohide -bool true

# サイズを変更
defaults write com.apple.dock tilesize -int 60

# 拡大時のサイズを変更
defaults write com.apple.dock largesize -int 100

# アプリの提案と最近使用したアプリをDockに表示をオフ
defaults write com.apple.dock show-recents -bool false

# 最新の使用状況に基づいて操作スペースを自動的に並べ替えるをオフ
defaults write com.apple.dock mru-spaces -bool false

# ホットコーナー左上をディスプレイをスリープに設定
defaults write com.apple.dock wvous-tl-corner -int 10

# ホットコーナー右上を通知センターに設定
defaults write com.apple.dock wvous-tr-corner -int 12

# ホットコーナー左下をオフ
defaults write com.apple.dock wvous-bl-corner -int 1

# ホットコーナー右下をオフ
defaults write com.apple.dock wvous-br-corner -int 1

# 再起動
killall Dock


########## Finder ##########

# 隠しファイルを常に表示
defaults write com.apple.finder AppleShowAllFiles -bool true

# 全てのファイル拡張子を表示
defaults write -g AppleShowAllExtensions -bool true

# サイドバーのアイコンサイズを中サイズに設定
defaults write -g NSTableViewDefaultSizeMode -int 2

# ツールバーのタイトルのロールオーバー遅延をオフ
defaults write -g NSToolbarTitleViewRolloverDelay -float 0

# 再起動
killall Finder


########## 開発用ディレクトリ作成 ##########

mkdir ~/dev
