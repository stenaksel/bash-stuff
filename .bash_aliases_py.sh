#!/bin/bash

printf "\t Installing Python related alias definitions ......${CYAN}~/bash-stuff/.bash_aliases_py${NC}\n"

# ----------------------
# py => Python aliases
# ----------------------
alias 'blue?'='run blue --check SRC'
alias blue_='run blue --version::Show the version of blue'
alias blueall='find . -name "*.py" -print0 | xargs -0 blue ::Running blue on all python files ...'
alias blueit='find . -type d -name migrations -prune -o -type f -name "*.py" -print0 | xargs -0 blue::Running blue on all python files, EXCEPT those in migrations folder...'

# ---- Python related: ----
alias 'pt'='clear && run pytest -rA'
alias py-ver='run python --version'
alias 'py-ver@'='printf "\n==%s --\n%s" "$(run py_)" "$(run which python)"'
#alias py-ver2='printf "%s \n(%s)\n" "$(python --version 2>&1)" "$(which python)"'
# 2>&1: This redirects the standard error (file descriptor 2) to standard output (file descriptor 1).
# This is necessary because older versions of Python used to print the version to standard error.
alias pip-ver='run pip --version'
alias pip_='pip-ver'
alias pip-dep-info='run pipdeptree -p '                   # add <name> of package to inform about
alias pip-dep-info-reverse='run pipdeptree --reverse -p ' # add <name> of package to inform about
alias pytest-ver='pytest --version && printf "\n"'
alias pytest_='pytest-ver'
alias pyt='run pytest -r fxs'
alias pyt_f='printf "Run feature <filename>\n" && run pytest -r fxs --feature='
alias pyt_s='printf "Run scenario \"scenario name\"\n" && run pytest -r fxs --feature='
alias py_='printf "\n" && py-ver@ && printf "\n" && pip_ && printf "\n" && pytest_ '
#alias py2_='printf "%s \n%s" "$(run python --version)" "$(run which python)"'
alias py2_='printf "\n%s \n%s" "$(py-ver)" "$(pip-ver)"'
alias py2_2='printf "\n__%s \n__%s" "$(py-ver@)" "$(pip-ver)"'

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
alias bddf='pyt_f'
alias bdds='pyt_s'

# ---- Coding/BDD related: ----
alias 'bdd'='clear && run pytest -rA -m "not todo"::Run all finished tests (all not tagged \"TODO\")'
alias 'bdd-ok'='clear && run pytest -rA -m ok::Run only tests tagged \"ok\"'
alias 'bdd-nok'='clear && run pytest -rA -m "not ok"::Run only tests tagged \"not ok\"'

alias no_tags='run find_scenarios_without_tags -::All untagged scenarios:'
alias tag='find_tags::Find all tests with tag given (as parameter)'
alias bdd-node='run npm run test:parallel::Run tests using npm'
alias bdd-n='bdd-node'
alias bdd-behave='run behave --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter::Run tests using Behave'
alias bdd-b='bdd-behave'
alias bdd-behave-ver='run behave --version && printf "\n"'
alias bdd-behave_='bdd-behave-ver'
alias bdd-b_='bdd-behave_'
alias bdd-pytest='pyt::Run tests using PyTest'
alias bdd-pt='bdd-pytest'
alias bdd-pt-ver='bdd-pytest --version && printf "\n"'
alias bdd-pt_='bdd-pt-ver'
alias bdd-pytest-lf='run pytest -r pfexs --lf'
