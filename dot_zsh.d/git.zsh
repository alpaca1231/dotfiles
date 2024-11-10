# ghqを使ってリモートリポジトリをクローンする
alias clone='ghq get -p'

# branch切り替え
alias br='git switch $(git branch | peco --prompt "BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g")'

# repository切り替え
alias repo='cd $(ghq root)/$(ghq list | peco --prompt="REPO >")'

# remote repositoryを作成してghqで取得する
function ghq-create-remote-repo-clone() {
  local user_name=$(git config --get user.name)
  gh repo create $argv
  ghq get -p git@github.com:$(user_name)/$(argv[1]).git
  cd $(ghq root)/github.com/$(user_name)/$(argv[1])
}
alias -g ghcr='ghq-create-remote-repo-clone'

alias g='git'

alias gst='git status'
alias gad='git add .'
alias gcm='git commit -v'
alias gcmn='git commit -v --no-verify'
alias fc='git commit --allow-empty -m "first commit"'
alias gcmm='git commit -m'
alias gcmmn='git commit -m --no-verify'
alias gcma='git commit --amend'
alias grs='git reset'

# branch
alias gbr='git branch'
alias gbrd='git branch -d'
alias gbrdd='git branch -D'
alias gbrm='git branch --merged | egrep -v "\\*|develop|main" | xargs git branch -d'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch main'
alias gswd='git switch develop'

# remote
alias gps='git push'
alias gpo='git push -u origin HEAD'
alias gf='git fetch --prune'
alias gpl='git pull --prune'
alias gpld='git pull origin develop'
alias gplm='git pull origin main'

# log
alias gdf='git diff'
alias glg='git log --oneline --graph'
alias lg='git log --oneline --graph -10'

# rebase
alias grb='git rebase --keep-empty'
alias grbi='git rebase -i --keep-empty'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# stash
alias gss='git stash save'
alias gssu='git stash save -u'
alias gssl='git stash list'
alias gssa='git stash apply'
alias gssp='git stash pop'
alias gssd='git stash drop'
alias gssc='git stash clear'

# merge
alias gmg='git merge'
alias gms='git merge --squash'
alias gmgc='git merge --continue'
alias gmga='git merge --abort'

# GitHub CLI
alias ghb='gh browse'
alias gho='gh repo view --web'
alias ghpr='gh pr view --web'
alias ghprc='gh pr create --web --assignee @me'
alias ghcp='gh copilot'
alias ghce='gh copilot explain'
alias ghcs='gh copilot suggest'
