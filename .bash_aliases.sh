#!/bin/bash
ESC='\033'
FG_RED=31
BG_RED=41
FG_CYAN=36
CYAN="${ESC}[${FG_CYAN}m"
RED="${ESC}[${FG_RED}m"
ALERT="${ESC}[${BG_RED}m"
NC="${ESC}[0m" # No Color
printf "\t Installing alias definitions ......${CYAN}~/bash-stuff/.bash_aliases${NC}\n"

#TODO: Split file, use includes... create one file for each language (& OS?)
# ----------------------
# My aliases
# ----------------------
alias 'blue?'='run blue --check SRC'
alias blue_='run blue --version'
alias blueall='printf "Running blue on all python files ...\n> " && find . -name "*.py" -print0 | xargs -0 blue'
alias blueit='printf "Running blue on all python files, EXCEPT those in migrations folder...\n> " && find . -type d -name migrations -prune -o -type f -name "*.py" -print0 | xargs -0 blue'
alias c='clear'
alias bash_='run bash --version'
alias hist='history'
# alias hist_='hist'
alias env_='while IFS="=" read -r key value; do printf "%-40s>_%s\n" "${key// /_}_" "$value" | sed "s/ /─/g" | sed "s/_/ /g"; done < <(env | sort)'

alias hint='run hints'
alias ls='ls -F'
alias ll='ls -lh'
#alias code=~'/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe'
#alias zero=~'/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe --disable-extensions'
# ---- Windows related: ----
alias exp='explorer.exe .'
#alias edit='notepad.exe'
# ---- bash on Windows related: ----
#alias type='echo ------ Running cat for you ------ && cat'
alias os-ver='run cmd //c ver'
alias os_='os-ver'
alias bup='printf "Doing \"bash update\"" && run source ~/.bashrc'
# ---- Python related: ----
alias py-ver='run python --version && printf "@: " && which python'
alias pip_='run pip --version'
alias pip-dep-info='run pipdeptree -p '                   # add <name> of package to inform about
alias pip-dep-info-reverse='run pipdeptree --reverse -p ' # add <name> of package to inform about
alias pytest-ver='pytest --version && printf "\n"'
alias pytest_='pytest-ver'
alias pyt='run pytest -r fxs'
alias pyt_f='printf "Run feature <filename>\n" && run pytest -r fxs --feature='
alias pyt_s='printf "Run scenario \"scenario name\"\n" && run pytest -r fxs --feature='
alias py_='printf "\n" && py-ver && printf "\n" && pip_ && printf "\n" && pytest_'
alias bddf='pyt_f' #TODO create function to find context ('pyt_f' or 'cucumber_f')
alias bdds='printf "Run scenario "name of scenario"\n" && run pytest -r fxs --scenario='
alias bdds='printf "Run scenario "name of scenario"\n" && run pytest -r fxs --scenario='
alias hist='cat ~/.bash_history'
alias rmhist='rm ~/.bash_history; history -c;'
# ---- Coding/BDD related: ----
alias no_tags='printf "All untagged scenarios:\n" && run find_scenarios_without_tags -'
alias tag='find_tags'
alias bdd-node='run npm run test:parallel'
alias bdd-n='bdd-node'
alias bdd-behave='run behave --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias bdd-b='bdd-behave'
alias bdd-behave_='run behave --version && printf "\n"'
alias bdd-b_='bdd-behave_'
alias bdd-pytest='pyt'
alias bdd-pt='bdd-pytest'
alias bdd-pt_='bdd-pytest --version && printf "\n"'
alias bdd-pytest-lf='run pytest -r pfexs --lf'
#
# alias wip-tag='printf "All wip tagged scenarios :\n" && run find_scenarios_with_tags wip'
alias 'pt'='clear && run pytest -rA'
alias 'bdd'='clear && run pytest -rA -m "not todo"'
alias 'bdd-ok'='clear && run pytest -rA -m ok'
alias 'bdd-nok'='clear && run pytest -rA -m "not ok"'
alias 'ok'='bdd-ok'
alias 'nok'='bdd-nok'
alias 'ok?'='bdd-ok'
alias 'wip?'='run wip'
alias ok-tag='tag ok'
alias wip-tag='tag wip'
alias wip-node='npm run wip'
alias wip-n='wip-node'
alias wip-behave='run behave --tags=wip --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias wip-b='wip-behave'
alias wip-pytest='run pytest -rA -m wip'
alias wip-pt='wip-pytest'
alias cwip='clear && wip'
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
alias py-workon-venv='printf "Activating Python Virtual Environment (using virtualenvwrapper)\n=> workon .\n\n" && workon .'
alias ave=py-workon-venv     # Activates the virtual environment (using virtualenvwrapper: workon .)
alias avenv=py-activate-venv # Activates the virtual environment (using .venv/Scripts/activate)
alias venvs='venv && printf "\nAvailable virtual environments in $WORKON_HOME (workon): \n\n" && run workon'
alias py_='python --version && pip --version && pytest --version && bdd-pt_ && venvs && printf "\n"'
alias java_='run java --version'
alias _='os_ && java_ && git_ && py_ && printf "\n"'

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
# My own (git-aliases not based on Oh-My-Zsh Git plugin):
alias gca='run git commit --amend'
alias gdfh='run git diff --summary FETCH_HEAD'
alias gfo='run git fetch origin' # add <name> what branch to fetch (eg. git fetch origin main)
alias gnew='run git log $1@{1}..$1@{0} "$@"'
alias git_='git --version'
alias gv='run git --version'
# My own nice aliases for working with Kotlin development (and Maven)
alias ktlc='run mvn ktlint:check'     # format your Kotlin sources
alias ktlf='run mvn ktlint:format'    # heck your Kotlin sources for code style violations
alias ktlr='run mvn ktlint:ktlint'    # generate project report of code style violations

# My own nice aliases for working with Maven
alias 'pom?'='if [ ! -e pom.xml ]; then printf "\n${ALERT} --> No pom.xml file found in this folder!${NC}\n"; fi'
alias mvn_='run mvn --version && pom?'
# alias mvn_='pom? && run mvn --version'
alias mvn-h='pom? && run mvn help:effective-pom'
alias mep='mvn-h'
alias mcu-deps='pom? && run mvn versions:display-dependency-updates'
alias mcu-props='pom? && run mvn versions:display-property-updates'
alias mcu-d='printf "\"Maven Check Updates - Dependencies\" \n> " && mcu-deps'
alias mcu-p='printf "\"Maven Check Updates - Properties\" \n> " && mcu-props'
alias mcu1='printf "\"Maven Check Updates\" \n> " && mcu-props && mcu-deps'
alias mcu2='printf "\"Maven Check Updates\" \n> " && mvn? && mcu-props && mcu-deps'
alias mcu2='printf "\"Maven Check Updates\" \n> " && mvn? && mcu-props && mcu-deps'
alias mcu5='printf "\"Maven Check Updates\" \n> (Use alias \"mcu-up\" to update outdated) \n> " && mcu-deps && mcu-props'

#alias mcu-up (or mvn-up ?) TODO: IF POSSIBLE
alias mvn_dt='run mvn dependency:tree'   # Displays the dependency tree for this project.
alias mci='pom? && run mvn clean install'