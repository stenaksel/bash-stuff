#!/bin/bash
ESC='\033'
FG_CYAN=36
CYAN="${ESC}[0;${FG_CYAN}m"
NC="${ESC}[0m" # No Color
printf " Installing alias definitions ......${CYAN}~/bash-stuff/.bash_aliases${NC}\n"

# ----------------------
# My aliases
# ----------------------
alias c='clear'
alias bash_='run bash --version'
alias hint='run hints'
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
# alias py-ver='python --version && pip --version && pytest --version'
alias py-ver='run python --version && printf "@: " && which python'
alias pip_='run pip --version'
alias pip-dep-info='run pipdeptree -p '                   # add <name> of package to inform about
alias pip-dep-info-reverse='run pipdeptree --reverse -p ' # add <name> of package to inform about
alias pytest-ver='pytest --version && printf "\n"'
alias pytest_='run pytest --version && printf "\n"'
alias py_='printf "\n" && py-ver && printf "\n" && pip_ && printf "\n" && pytest_'
## alias mypy='venv/bin/mypy'
alias hist='cat ~/.bash_history'
alias rmhist='rm ~/.bash_history; history -c;'
# ---- Coding/BDD related: ----
alias bdd-node='run npm run test:parallel'
alias bdd-n='bdd-node'
alias bdd-behave='run behave --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias bdd-b='bdd-behave'
alias bdd-behave_='run behave --version && printf "\n"'
alias bdd-b_='bdd-behave_'
alias bdd-pytest='run pytest -r fxs'
alias bdd-pt='bdd-pytest'
alias bdd-pt_='bdd-pytest --version && printf "\n"'
alias bdd-pytest-lf='run pytest -r pfexs --lf'
#
alias wip-node='npm run wip'
alias wip-n='wip-node'
alias wip-behave='run behave --tags=wip --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias wip-b='wip-behave'
alias wip-pytest='run pytest -rA -m wip'
alias wip-pt='wip-pytest'
# __npm_block__
alias npmi='npm install'
alias ni='npmi'
## ncu = npm-check-updates
# __Docker_block
alias dup='run docker-compose up pg'
# __Python_block__
alias pypi='python -m webbrowser https://pypi.org/' # Open pypi.org (Cross-platform)
# alias pypi-linux='xdg-open https://pypi.org'      # Open pypi.org (Linux)
# alias pypi-mac='open https://pypi.org'            # Open pypi.org (Mac)
# alias pypi-win='start "https://pypi.org/"'        # Open pypi.org (Windows)
alias pi=py_install_requirements
alias pyi=py_install_requirements                          # function checks available requirement files and runs one of the two next aliases
alias pyi-r='run pip install -U -r requirements.txt'       # Include regular requirements packages.
alias pyi-rt='run pip install -U -r requirements-test.txt' # Include requirements packages needed to run the test suite
alias pcu='printf "\"Python Check Updates\"\n> pip list --outdated\n" && pip list --outdated && printf "\n(Use alias \"pcu-up\" to update outdated)\n"'
alias pcu-up='printf "Upgrading outdated dependencies\n" && pip list --outdated | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U'
alias pip-up='run python.exe -m pip install --upgrade pip'
alias py-activate-venv='printf "Activating Python Virtual Environment (.venv)\n=> source .venv/Scripts/activate\n" && source .venv/Scripts/activate'
alias py-workon-venv='printf "Activating Python Virtual Environment (.venv)\n=> source .venv/Scripts/activate\n" && source .venv/Scripts/activate'
alias ave='workon .'         # Activates the virtual environment (using virtualenvwrapper: workon .)
alias avenv=py-activate-venv # Activates the virtual environment (using .venv/Scripts/activate)
alias venvs='venv && printf "\nAvailable virtual environments in $WORKON_HOME (workon): \n\n" && run workon'
alias _='os-ver && python --version && pip --version && pytest --version && bdd-pt_ && bdd-b_ && venvs && printf "\n"'

# ----------------------
# Git Aliases
# ----------------------
## Git aliases for bash (based on Oh My Zsh Git plugin)
#source ~/.git-plugin-bash.sh
alias ga='run git add'
alias gaa='run git add .'
alias gaaa='run git add --all'
alias gau='run git add --update'
alias gb='run git branch -a' # show branches (local and remote)
# alias gbd='run git branch --delete' # add <name> what branch to delete
# alias gbda='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias gc='run git commit --verbose'
# %ligatures off
alias gc!='run git commit --verbose --amend'
# %ligatures oN
alias gcm='run git commit --message' # Git commit message
alias gcf='run git commit --fixup'
alias gco='run git checkout'          # Change to branch <name>
alias gcob='run git checkout -b'      # Creates a new branch and checks out the new branch
alias gcom='run git checkout main'    # Change to branch: main
alias gcos='run git checkout staging' # Change to branch: staging
alias gcod='run git checkout develop' # Change to branch: develop
alias gd='run git diff'               # Files differences in staging
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
# My own (git-aliases not based on Oh-My-Zsh Git plugin)
alias gca='run git commit --amend'
alias gdfh='run git diff --summary FETCH_HEAD'
alias gfo='run git fetch origin' # add <name> what branch to fetch (eg. git fetch origin main)
alias gnew='run git log $1@{1}..$1@{0} "$@"'
alias git_='run git --version'
alias gv='run git --version'
