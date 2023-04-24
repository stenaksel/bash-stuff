
#!/bin/bash
echo "sah: Reading ~/.bash_aliases: Alias definitions (read by .bashrc) "
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
alias os-ver='cmd //c ver'
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
alias pyi='pip install -U -r requirements-test.txt'
alias pi='pyi'
alias wip-py='behave --tags=wip --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias bdd-py='behave --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
alias bdd-py_='behave --version && printf "\n"'
## pcu : python-check-updates :-)
alias pcu='printf "\"Python Check Updates\"\n> pip list --outdated\n" && pip list --outdated && printf "\n(Use alias \"pcu-up\" to update outdated)\n"'
alias pycu=pcu
alias pcu-up='printf "Upgrading outdated dependencies\n" && pip list --outdated | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U'
alias pycu-up=pcu-up
#alias ave='printf "Activating Virtual Environment\nsource .venv/Scripts/activate\n" && source .venv/Scripts/activate'
alias venvs='printf "\nAvailable virtual environments in $WORKON_HOME (LSVIRUALENV): \n\nlsvirtualenv -b : \n-----------------\n" && lsvirtualenv -b'
alias _='venvs && os_ && py_ && bdd-py_ && printf "\n"'
# alias alias4git='alias | awk -F'=' '{gsub(/^alias /, "", $1); printf "%-13s %-20s\n", $1, $2}''
# alias alias4git='alias | awk -F'=' '{gsub(/^alias /, '\'' , $1); printf "%-13s %-20s\n", $1, $2}'


# ----------------------
# Git Aliases
# ----------------------
## Git aliases for bash (based on Oh My Zsh Git plugin)
#source ~/.git-plugin-bash.sh

echo "sah: Adding zsh git aliases "
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
#alias gc='git commit'
#alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
#alias gi='git init'
alias glg='git log --graph --oneline --decorate'
alias gld='git log --pretty=format:"%h %ad %s" --date=short'
#alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
#alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
