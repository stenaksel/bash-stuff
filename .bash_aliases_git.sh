#!/bin/bash

printf "\t Installing alias definitions ......${CYAN}~/bash-stuff/.bash_aliases${NC}\n"

# ----------------------
# Git Aliases
# ----------------------
## Git aliases for bash (based on Oh My Zsh Git plugin)
#source ~/.git-plugin-bash.sh
alias ga='run git add'
alias gaa='run git add .' # Adds all files in the current directory to the index
alias gaaa='run git add --all'
alias gau='run git add --update'
alias gb='run git branch -a' # show branches (local and remote)
alias gbd='run git branch -d' # add <name> what branch to delete
alias 'gbD'='run git branch -D' # add <name> what branch to force delete
#alias gbda='git branch --merged | egrep -v "(^\*|main|master|dev)" | xargs git branch -d'
alias gbda='gb && confirm_action "git branch --merged | egrep -v \"(^\*|main|master|dev)\" | xargs git branch -d"'
alias 'pom?'='check_pom'

# ---- Bash related: ----
#alias ls='ls -F'
alias lsa='ls -F -a'
alias code-i='run_where idea'
alias code-iz='run_where idea -disableNonBundledPlugins' # Starts IDEA with non-bundled plugins disabled
alias code-f='run_where fleet'
alias code='code-i'
alias idea='code-i'
alias fleet='code-f'
#alias code=~'/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe'
#alias zero=~'/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe --disable-extensions'
# ---- Windows related: ----
alias exp='explorer.exe .'
#alias edit='notepad.exe'
# ---- bash on Windows related: ----
#alias type='echo ------ Running cat for you ------ && cat'

# ----------------------
# Git Aliases
# ----------------------
alias a4g='run a4 git::Show git related aliases (in bash-stuff)'

## Git aliases for bash (based on Oh My Zsh Git plugin)
#source ~/.git-plugin-bash.sh
alias ga='run git add::Add file contents to the index (by <pathspec> parameter)'
alias ga?='run git --help add::Show help for git add'
alias gan='run git add -n::Don’t actually add the file(s), just show if they exist and/or will be ignored'
alias gaa='run git add . ::Add file contents to the index Use <param>  files in the current directory to the index '
alias gaaa='run git add --all'
alias gau='run git add --update'
alias gb='run git branch -a' # show branches (local and remote)
alias gbd='run git branch -d' # add <name> what branch to delete
alias 'gbD'='run git branch -D' # add <name> what branch to force delete
#alias gbda='git branch --merged | egrep -v "(^\*|main|master|dev)" | xargs git branch -d'
alias gbda='gb && confirm_action "git branch --merged | egrep -v \"(^\*|main|master|dev)\" | xargs git branch -d"'
alias gc='run git commit --verbose'
# %ligatures off
alias gc!='run git commit --verbose --amend'
# %ligatures oN
alias gcm='run git commit --message' # Git commit message
alias gcf='run git commit --fixup'
alias gco='run git checkout'          # Change to branch <name>
alias gcob='run git checkout -b'      # Creates a new branch and checks out the new branch
alias gcom='run git checkout master'  # Change to branch: master
#alias gcom='run git checkout main'    # Change to branch: main
alias gcos='run git checkout staging' # Change to branch: staging
alias gcod='run git checkout develop' # Change to branch: develop
alias gd='run git diff'               # Files differences in staging
alias gda='run git diff HEAD'
#alias gi='run git init'
alias gl='run git log && printf "${CYAN}Hint: You can also use ${NC}glg${CYAN} or ${NC}gld${CYAN} to do ${NC}git log${CYAN} (with \"options\")${NC}\n"'
alias glg='run git log --graph --oneline --decorate'
alias gld='run git log --pretty=format:"%h %ad %s" --date=short'
alias gld_='git log --pretty=format:"%h %ad %s" --date=short'
#alias gm='run git merge --no-ff'
alias gma='run git merge --abort'
alias gmc='run git merge --continue'
alias gp='run git pull'
alias gpr='run git pull --rebase'
#alias git-persons='run git log --format='%aN <%aE>' | sort -u'
alias gr='run git rebase'
alias gs='run git status'
alias gss='run git status --short'
alias gst='run git stash'
alias gsta='run git stash apply'
alias gstd='run git stash drop'
alias gstl='run git stash list'
alias gstp='run git stash pop'
alias gsts='run git stash save'
# My own (git-aliases not based on Oh-My-Zsh Git plugin):
#alias gitauthors="git log --format="%aN <%aE>" | sort -u"
alias gca='run git commit --amend'
alias gdfh='run git diff --summary FETCH_HEAD'
alias gfo='run git fetch origin' # add <name> what branch to fetch (eg. git fetch origin main)
alias gnew='run git log $1@{1}..$1@{0} "$@"'
alias git_='run git --version'

# My own nice aliases for working with Kotlin development (and Maven)
alias ktlc='run mvn ktlint:check'     # format your Kotlin sources
alias ktlc-e='run mvn -e ktlint:check'     # format your Kotlin sources
alias ktlc-X='run mvn -X ktlint:check'     # format your Kotlin sources
alias ktlf='run mvn ktlint:format'    # heck your Kotlin sources for code style violations
alias ktlr='run mvn ktlint:ktlint'    # generate project report of code style violations
alias kt_='run_where kotlinc -version'
# My own nice aliases for working with Maven
alias 'pom?'='check_pom'
alias mvn-h='run "mvn help:effective-pom"'
alias mvn-hs0='run "mvn help:effective-pom -Doutput=./temp/effective-pom.xml" && printf "\n ....  saved ${CYAN}temp/effective-pom.xml${NC}\n"'
alias mvn-hs1='run "mvn help:effective-pom -Doutput=\"./temp/effective-pom.xml\"" && printf "\n ....  saved ${CYAN}temp/effective-pom.xml${NC}\n"'
alias mvn-hs2='run "mvn help:effective-pom -Doutput=\"./temp/effective-pom.xml\"" && printf "\n ....  saved ${CYAN}temp/effective-pom.xml${NC}\n"'

alias hist='cat ~/.bash_history'
