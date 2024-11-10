# voltaで.node-versionや.nvmrcを読み取ってそのNodeバージョンをインストールする
autoload -Uz add-zsh-hook
function chpwd_volta_install() {
  local version
  # .node-version または .nvmrc を読み取る
  if [[ -e ".node-version" ]]; then
    version=$(<.node-version)
  elif [[ -e ".nvmrc" ]]; then
    version=$(<.nvmrc)
  else
    return
  fi

  # Volta でインストール
  volta install node@$version --quiet
}
add-zsh-hook chpwd chpwd_volta_install
