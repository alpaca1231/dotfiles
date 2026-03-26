#!/usr/bin/env zsh

# ブラウザにインストールされている Chrome 拡張の ID をプロファイル別にエクスポートする
# 使い方: zsh "$(chezmoi source-path)/scripts/browser-extensions/export-extensions.sh" [-b BROWSER] [PROFILE]
#   -b arc | dia | chrome | edge  エクスポートするブラウザを指定可能
#   PROFILE             エクスポートするプロファイルを指定可能

set -euo pipefail

SCRIPT_DIR="${0:a:h}"
BROWSER_KEY=""

# ---------------------------------------------------------------------------
# ブラウザ定義（既知の Chromium 系ブラウザとデータディレクトリ）
# ---------------------------------------------------------------------------
typeset -A BROWSER_PATHS
BROWSER_PATHS=(
  arc     "${HOME}/Library/Application Support/Arc/User Data"
  brave   "${HOME}/Library/Application Support/BraveSoftware/Brave-Browser"
  chrome  "${HOME}/Library/Application Support/Google/Chrome"
  dia     "${HOME}/Library/Application Support/Dia/User Data"
  edge    "${HOME}/Library/Application Support/Microsoft Edge"
  vivaldi "${HOME}/Library/Application Support/Vivaldi"
)

# インストール済みブラウザのみ抽出（Local State の存在で判定）
typeset -A INSTALLED_BROWSERS
for key in ${(ko)BROWSER_PATHS}; do
  [[ -f "${BROWSER_PATHS[$key]}/Local State" ]] && INSTALLED_BROWSERS[$key]="${BROWSER_PATHS[$key]}"
done

if (( ${#INSTALLED_BROWSERS} == 0 )); then
  echo "対応する Chromium 系ブラウザが見つかりません。" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# オプション解析
# ---------------------------------------------------------------------------
while [[ "${1:-}" == -* ]]; do
  case "$1" in
    -b|--browser)
      shift
      BROWSER_KEY="${1:-}"
      if [[ -z "$BROWSER_KEY" ]]; then
        echo "-b にはブラウザ名を指定してください (${(kj: / :)INSTALLED_BROWSERS})" >&2
        exit 1
      fi
      if [[ -z "${INSTALLED_BROWSERS[$BROWSER_KEY]:-}" ]]; then
        echo "未対応またはインストールされていないブラウザ: $BROWSER_KEY" >&2
        echo "  利用可能: ${(kj:, :)INSTALLED_BROWSERS}" >&2
        exit 1
      fi
      shift
      ;;
    *)
      echo "不明なオプション: $1" >&2; exit 1 ;;
  esac
done

# ---------------------------------------------------------------------------
# ブラウザ決定（-b 未指定の場合は fzf で選択）
# ---------------------------------------------------------------------------
if [[ -z "$BROWSER_KEY" ]]; then
  installed_keys=( ${(ko)INSTALLED_BROWSERS} )

  if ! command -v fzf &>/dev/null; then
    echo "fzf が見つかりません。-b でブラウザを指定するか、fzf をインストールしてください。" >&2
    echo "  例: $0 -b arc" >&2
    echo "  利用可能: ${(j:, :)installed_keys}" >&2
    exit 1
  fi

  BROWSER_KEY=$(printf '%s\n' "${installed_keys[@]}" | fzf \
    --prompt="ブラウザを選択: " \
    --header="↑↓ で移動、Enter で決定" \
    --height=~40% \
    --no-info \
    --reverse \
  ) || {
    echo "キャンセルされました。" >&2
    exit 1
  }
fi

BROWSER_DATA="${INSTALLED_BROWSERS[$BROWSER_KEY]}"

# ---------------------------------------------------------------------------
# プロファイル決定
# ---------------------------------------------------------------------------
if [[ -n "${1:-}" ]]; then
  PROFILE="$1"
else
  # Local State からプロファイル表示名を一括取得（Chrome / Arc 共通）
  LOCAL_STATE="$BROWSER_DATA/Local State"
  typeset -A local_state_names
  if [[ -f "$LOCAL_STATE" ]]; then
    while IFS=$'\t' read -r dir_name display_name; do
      local_state_names[$dir_name]="$display_name"
    done < <(python3 -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
cache = data.get('profile', {}).get('info_cache', {})
for d, info in cache.items():
    name = info.get('name', '')
    if name:
        print(f'{d}\t{name}')
" "$LOCAL_STATE" 2>/dev/null)
  fi

  typeset -A name_to_dir
  display_names=()
  for d in "$BROWSER_DATA"/*(N); do
    [[ -d "$d/Extensions" ]] || continue
    dir_name="${d:t}"

    if [[ "$dir_name" == "Default" ]]; then
      display="${local_state_names[Default]:-Default}"
    elif [[ -n "${local_state_names[$dir_name]:-}" ]]; then
      display="${local_state_names[$dir_name]}"
    else
      prefs="$d/Preferences"
      if [[ -f "$prefs" ]]; then
        display=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['profile']['name'])" "$prefs" 2>/dev/null || echo "$dir_name")
      else
        display="$dir_name"
      fi
    fi
    name_to_dir[$display]="$dir_name"
    display_names+=("$display")
  done

  if (( ${#display_names} == 0 )); then
    echo "プロファイルが見つかりません: $BROWSER_DATA" >&2
    exit 1
  fi

  if ! command -v fzf &>/dev/null; then
    echo "fzf が見つかりません。引数でプロファイルを指定するか、fzf をインストールしてください。" >&2
    echo "  例: $0 -b $BROWSER_KEY Default" >&2
    echo "  利用可能:" >&2
    for n in "${display_names[@]}"; do echo "    $n" >&2; done
    exit 1
  fi

  selected=$(printf '%s\n' "${display_names[@]}" | fzf \
    --prompt="${BROWSER_KEY} プロファイルを選択: " \
    --header="↑↓ で移動、Enter で決定" \
    --height=~40% \
    --no-info \
    --reverse \
  ) || {
    echo "キャンセルされました。" >&2
    exit 1
  }
  PROFILE="${name_to_dir[$selected]}"
fi

# ---------------------------------------------------------------------------
# Extensions ディレクトリの確認
# ---------------------------------------------------------------------------
EXT_ROOT="${BROWSER_DATA}/${PROFILE}/Extensions"

if [[ ! -d "$EXT_ROOT" ]]; then
  echo "ディレクトリが見つかりません: $EXT_ROOT" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# エクスポート
# ---------------------------------------------------------------------------
SAFE_PROFILE="${PROFILE// /_}"
LIST="$SCRIPT_DIR/extensions-${BROWSER_KEY}-${SAFE_PROFILE}.txt"

{
  echo "# ${BROWSER_KEY} 拡張 ID（プロファイル: ${PROFILE}）"
  echo "# open-extensions.sh でストアページを順に開く"
  echo ""
  for dir in "$EXT_ROOT"/*(N); do
    [[ -d "$dir" ]] || continue
    manifests=( "$dir"/*/manifest.json(N) )
    (( ${#manifests} )) || continue
    print -r -- "${dir:t}"
  done | sort -u
} > "$LIST"

ext_count=$(grep -cv '^#\|^$' "$LIST" || true)
cat <<EOF

  ✔ エクスポート完了

    ファイル      ${LIST:t}
    ブラウザ      ${BROWSER_KEY}
    プロファイル  ${PROFILE}
    拡張数        ${ext_count} 件

EOF
