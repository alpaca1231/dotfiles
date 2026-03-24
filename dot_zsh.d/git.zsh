# =============================================================================
# ghq / peco 連携
# =============================================================================
alias clone='ghq get -p'
alias br='git switch $(git branch | peco --prompt "BRANCH >" | head -n 1 | sed -e "s/^\*\s*//g")'
alias repo='cd $(ghq root)/$(ghq list | peco --prompt="REPO >")'

function ghq-create-remote-repo-clone() {
  local user_name=$(git config --get user.name)
  gh repo create $argv
  ghq get -p git@github.com:$(user_name)/$(argv[1]).git
  cd $(ghq root)/github.com/$(user_name)/$(argv[1])
}
alias ghcr='ghq-create-remote-repo-clone'

# =============================================================================
# git（g prefix）
# =============================================================================
alias g='git'

# --- add ---
alias gad='git add'
alias gada='git add .'

# --- commit ---
alias gcm='git commit -v'
alias gcmn='git commit -vn'
alias gcmm='git commit -m'
alias gcmmn='git commit -nm'
alias gcma='git commit --amend'
alias gae='git commit --allow-empty -m'
alias gfc='git commit --allow-empty -m "first commit"'

# --- diff / status / show ---
alias gdf='git diff'
alias gst='git status'
alias gsh='git show'

# --- restore / reset ---
alias grst='git restore'
alias grs='git reset'

# --- branch ---
alias gbr='git branch'
alias gbra='git branch -a'
alias gbrd='git branch -d'
alias gbrdd='git branch -D'
alias gbrc='git branch --merged | egrep -v "\\*|develop|main" | xargs git branch -d'

# --- checkout / switch ---
alias gco='git checkout'
alias gcob='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch main'
alias gswd='git switch develop'

# --- remote / push / pull / fetch ---
alias grmt='git remote -v'
alias gps='git push'
alias gpo='git push -u origin HEAD'
alias gf='git fetch -p'
alias gpl='git pull -p'
alias gpld='git pull origin develop'
alias gplm='git pull origin main'

# --- log ---
alias lg='git log --oneline'
alias lg3='git log --oneline -3'
alias lg5='git log --oneline -5'
alias lg10='git log --oneline -10'
alias lg20='git log --oneline -20'
alias lgg='git log --oneline --graph'

# --- rebase ---
alias grb='git rebase --keep-empty'
alias grbi='git rebase -i --keep-empty'
alias grbo='git rebase --onto'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# --- stash ---
alias gss='git stash push'
alias gssu='git stash push -u'
alias gssl='git stash list'
alias gssa='git stash apply'
alias gssp='git stash pop'
alias gssd='git stash drop'
alias gssc='git stash clear'

# --- merge ---
alias gmg='git merge'
alias gms='git merge --squash'
alias gmgc='git merge --continue'
alias gmga='git merge --abort'

# --- cherry-pick ---
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'

# --- revert ---
alias grv='git revert'

# --- worktree / submodule ---
alias gwt='git worktree'
alias gsub='git submodule'

# =============================================================================
# GitHub CLI
# =============================================================================
alias gho='gh browse'
alias ghpr='gh pr view -w'
alias ghprc='gh pr create -w -a @me'
