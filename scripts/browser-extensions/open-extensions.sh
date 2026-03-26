#!/usr/bin/env zsh

# 拡張 ID リストの各 ID に対応する Chrome Web Store ページをブラウザで開く
# 使い方: zsh "$(chezmoi source-path)/scripts/browser-extensions/open-extensions.sh" [-b BROWSER] [ファイル名 or プロファイル名]
#   -b arc | chrome | "アプリ名"  開くブラウザを指定可能
#   ファイル名を省略すると対話式で選択可能

set -euo pipefail

SCRIPT_DIR="${0:a:h}"
BROWSER=""

# ---------------------------------------------------------------------------
# オプション解析
# ---------------------------------------------------------------------------
while [[ "${1:-}" == -* ]]; do
  case "$1" in
    -b|--browser)
      shift
      case "${1:-}" in
        arc)     BROWSER="Arc" ;;
        dia)     BROWSER="Dia" ;;
        chrome)  BROWSER="Google Chrome" ;;
        edge)    BROWSER="Microsoft Edge" ;;
        firefox) BROWSER="Firefox" ;;
        safari)  BROWSER="Safari" ;;
        "")      echo "-b にはブラウザ名を指定してください ( chrome / edge / firefox / safari 等)" >&2; exit 1 ;;
        *)       BROWSER="$1" ;;
      esac
      shift
      ;;
    *)
      echo "不明なオプション: $1" >&2; exit 1 ;;
  esac
done

# ---------------------------------------------------------------------------
# ファイル決定
# ---------------------------------------------------------------------------
if [[ -n "${1:-}" ]]; then
  arg="$1"
  if [[ -f "$arg" ]]; then
    LIST="$arg"
  else
    LIST="$SCRIPT_DIR/$arg"
  fi
else
  candidates=( "$SCRIPT_DIR"/extensions-*.txt(N) )

  if (( ${#candidates} == 0 )); then
    echo "extensions-*.txt が見つかりません。先に export-extensions.sh を実行してください。" >&2
    exit 1
  fi

  if ! command -v fzf &>/dev/null; then
    echo "fzf が見つかりません。引数でファイル名を指定するか、fzf をインストールしてください。" >&2
    echo "  利用可能:" >&2
    for f in "${candidates[@]}"; do echo "    ${f:t}" >&2; done
    exit 1
  fi

  LIST=$(printf '%s\n' "${candidates[@]}" | fzf \
    --prompt="開くファイルを選択: " \
    --header="↑↓ で移動、Enter で決定" \
    --height=~40% \
    --no-info \
    --reverse \
    --with-nth=-1 \
    --delimiter='/' \
  ) || {
    echo "キャンセルされました。" >&2
    exit 1
  }
fi

if [[ ! -f "$LIST" ]]; then
  echo "見つかりません: $LIST" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# ストアページを開く
# ---------------------------------------------------------------------------
count=0
while IFS= read -r line || [[ -n "$line" ]]; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  line="${line%%#*}"
  line="${line//[[:space:]]/}"
  [[ -z "$line" ]] && continue

  url="https://chromewebstore.google.com/detail/${line}"
  if [[ -n "$BROWSER" ]]; then
    open -a "$BROWSER" "$url"
  else
    open "$url"
  fi
  (( ++count ))
  sleep 0.45
done < "$LIST"

cat <<EOF

  ✔ ${count} 件のストアページを開きました

    ソース    ${LIST:t}
    ブラウザ  ${BROWSER:-デフォルト}

EOF
