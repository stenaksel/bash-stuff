
#!/bin/bash
echo "  ~/bash-stuff/.bash_aliases: Installing alias definitions (read by .bashrc) "
# ----------------------
# My aliases
# ----------------------
alias c='clear'
#alias code=~'/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe'
#alias zero=~'/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe --disable-extensions'
# alias code=~/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/223.7401.13/bin/pycharm.sh
# alias pycharm=~/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/223.7401.13/bin/pycharm.sh
# alias fleet=~/.local/share/JetBrains/Toolbox/apps/Fleet/ch-0/1.9.237/bin/Fleet
# ---- Linux related: ----
#alias os-ver='lsb_release -a'
#alias toolbox='/mnt/c/Users/StenAkselHeien/AppData/Local/JetBrains/Toolbox/bin/jetbrains-toolbox.exe'
#alias tb='toolbox'
## alias tb='/opt/jetbrains/jetbrains-toolbox'
# ---- Windows related: ----
alias exp='explorer.exe .'
#alias edit='notepad.exe'
# ---- bash on Windows related: ----
#alias type='echo ------ Running cat for you ------ && cat'
alias os-ver='run cmd //c ver'
alias os_='os-ver'
# alias os-ver='cmd /k ver && exit'
# ---- Python related: ----
alias py-ver='python --version && pip --version'
alias py_='py-ver'
## alias mypy='venv/bin/mypy'
alias hist='cat ~/.bash_history'
alias hist-cc='rm ~/.bash_history; history -c;'
# ---- Coding/BDD related: ----
# __npm_block__
alias npmi='npm install'
alias ni='npmi'
alias wip-n='npm run wip'
alias bdd-n='npm run test:parallel'
alias bdd-n_='npm --version && printf "\n"'
## ncu = npm-check-updates
# __Python_block__
alias pyirt='run pip install -U -r requirements-test.txt'
alias pyir='run pip install -U -r requirements.txt'
alias pi='py_install_requirements'
alias wip-py='run behave --tags=wip --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias bdd-py='run behave --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias bdd-py_='run behave --version && printf "\n"'
## pcu : python-check-updates :-)
alias pcu='printf "\"Python Check Updates\"\n> pip list --outdated\n" && pip list --outdated && printf "\n(Use alias \"pcu-up\" to update outdated)\n"'
alias pycu=pcu
alias pcu-up='printf "Upgrading outdated dependencies\n" && pip list --outdated | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U'
alias pycu-up=pcu-up
#alias ave='printf "Activating Virtual Environment\nsource .venv/Scripts/activate\n" && source .venv/Scripts/activate'
alias venvs='printf "\nAvailable virtual environments in $WORKON_HOME (LSVIRUALENV): \n\n" && run lsvirtualenv -b'
alias _='venvs && os_ && py_ && bdd-py_ && printf "\n"'
# alias alias4git='alias | awk -F'=' '{gsub(/^alias /, "", $1); printf "%-13s %-20s\n", $1, $2}''
# alias alias4git='alias | awk -F'=' '{gsub(/^alias /, '\'' , $1); printf "%-13s %-20s\n", $1, $2}'


# ----------------------
# Git Aliases
# ----------------------
## Git aliases for bash (based on Oh My Zsh Git plugin)
#source ~/.git-plugin-bash.sh

echo "                              (includin some Oh-My-Zsh Git Aliases -> use a4g to show them)"
alias ga='run git add'
alias gaa='run git add .'
alias gaaa='run git add --all'
alias gau='run git add --update'
alias gb='run git branch -a'            # show branches (local and remote)
# alias gbd='run git branch --delete'
alias gc='run git commit'
alias gcm='run git commit --message'    # Git commit message
alias gcf='run git commit --fixup'
alias gco='run git checkout'            # Change to branch <name>
alias gcob='run git checkout -b'        # Creates a new branch and checks out the new branch
alias gcom='run git checkout main'      # Change to branch: main
alias gcos='run git checkout staging'   # Change to branch: staging
alias gcod='run git checkout develop'   # Change to branch: develop
alias gd='run git diff'                 # Files differences in staging
alias gda='run git diff HEAD'
#alias gi='run git init'
alias glg='run git log --graph --oneline --decorate'
alias glg2='run git log --graph --oneline --decorate'
alias gld='run git log --pretty=format:"%h %ad %s" --date=short'
#alias gm='run git merge --no-ff'
alias gma='run git merge --abort'
alias gmc='run git merge --continue'
alias gp='run git pull'
alias gpr='run git pull --rebase'
alias gr='run git rebase'
alias gs='run git status'
alias gss='run git status --short'
alias gst='run git stash'
alias gsta='run git stash apply'
alias gstd='run git stash drop'
alias gstl='run git stash list'
alias gstp='run git stash pop'
alias gsts='run git stash save'
# My own (git aliases not based on Oh-My-Zsh Git plugin)
alias gnew='git log $1@{1}..$1@{0} "$@"'
alias gv='run git --version'
