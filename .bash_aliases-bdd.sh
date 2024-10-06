#!/bin/bash

printf "\t Installing alias definitions ......${CYAN}~/bash-stuff/.bash_aliases${NC}\n"

# --------------------------------------------------
# bdd => BDD (Behaviour Driven Development) Aliases
# --------------------------------------------------

# alias wip-tag='printf "All wip tagged scenarios :\n" && run find_scenarios_with_tags wip'
alias 'ok'='bdd-ok'
alias 'nok'='bdd-nok'
alias 'ok?'='bdd-ok'
alias 'wip?'='run wip'
alias ok-tag='tag ok'

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
alias bdd-pt-ver='bdd-pytest --version && printf "\n"'
alias bdd-pt_='run bdd-pytest --version && printf "\n"'
alias bdd-pytest-lf='run pytest -r pfexs --lf'
