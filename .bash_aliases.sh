#!/bin/bash

printf "\t Installing alias definitions ......${CYAN}~/bash-stuff/.bash_aliases${NC}\n"

# ----------------------
# My aliases
# ----------------------
alias c='run clear::Some description'
alias bash_='run bash --version'
alias hist='run history'
# alias hist_='hist'
alias env_='while IFS="=" read -r key value; do printf "%-40s>_%s\n" "${key// /_}_" "$value" | sed "s/ /─/g" | sed "s/_/ /g"; done < <(env | sort)'
alias hint='run hints'

# ---- Bash related: ----
#alias ls='ls -F'
alias lsa='ls -F -a'
alias ll='run ls -lh::List in long format'
alias lla='run ls -lh -a::List in long format including all'
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
alias os-ver='run cmd //c ver'
alias os_='os-ver'
alias bup='run source ~/.bashrc::\"bash update\" ... Re-execute the .bashrc file'
#
alias hist='cat ~/.bash_history'
alias rmhist='rm ~/.bash_history; history -c;'

# alias wip-tag='printf "All wip tagged scenarios :\n" && run find_scenarios_with_tags wip'
alias ok-tag='tag ok'
alias wip-tag='tag wip'
alias cwip='clear && wip'
alias bddf='pyt_f' #TODO create function to find context ('pyt_f' or 'cucumber_f')
alias bdds='printf "Run scenario "name of scenario"\n" && run pytest -r fxs --scenario='

# __npm_block__
alias npmi='npm install'
alias ni='npmi'
## ncu = npm-check-updates
# __Docker_block
alias dup='run docker-compose up pg'
# __Python_block__
alias py_='python --version'
alias java_='run java --version'
alias _='os_ && java_ && git-ver && py_ && printf "\n"'
