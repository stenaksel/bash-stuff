#!/bin/bash
# ESC='\033'
# FG_CYAN=36
# CYAN="${ESC}[0;${FG_CYAN}m"
# NC="${ESC}[0m" # No Color

printf " Installing function definitions ...${CYAN}~/bash-stuff/.bash_functions${NC}\n"
printf "  ( ${CYAN}hint${NC} -> show more info )\n\n"

# ----------------------
# My functions
# ----------------------

function venv() {
    local venv=$(printenv | grep VIRTUAL_ENV)
    if [ ! -z "$venv" ]; then
        printf "$venv\n"
        printf "\n==> Inside virtualenv: $VIRTUAL_ENV ... $VIRTUAL_ENV_PROMPT"
    else
        printf "\n==> Outside a virtualenv"
    fi
}

function hints() {
    printf "\nhints()\t( <p> means param(s) )\n-------\n"
    printf "alias-match <p>\t = \"Alias matching\" <p> ( Calls grep with param(s) )\n"
    printf "a4 <p>\t = \"Alias for\" matching -> 'alias-match' <p>\n"
    printf "a4g\t = Showing all git aliases -> 'a4 git'\n"
    printf "a4g-\t = Showing all non-git aliases (-> 'a4 -git' => 'a4 --invert-match git')\n"
    # printf "a4g-\t = --''--\n"
    printf "bdd-init = Setup for running BDD ('features' + subfolder 'steps')\n"
    printf "bdd\t = Run BDD test - running tests (in features)\n"
    printf "dup\t = Run the database in docker ('docker-compose up pg')\n"
    printf "iop\t = info-on-project (in folder)\n"
    printf "wip\t = Run wip BDD tests\n"
    printf "venv\t = Show info about configured virtual environment (in shell)\n"
}

function detect-language() {
    # Use: local _lang=$(detect-language | tail -1)
    # set -
    local _lang='?'
    local NUM_PY=$(find -name '*.py' | wc -l)
    local NUM_TS=$(find -name '*.ts' | wc -l)
    local NUM_REQ=$(find . -maxdepth 1 -name 'requirements*.txt' | wc -l)
    printf "1: language: $_lang\n"
    printf "Found $NUM_REQ requirements*.txt file(s) ($NUM_PY *.py files, $NUM_TS *.ts files)\n"
    if ((NUM_REQ > 0)); then
        printf "Found $NUM_REQ requirements*.txt file(s) ($NUM_PY *.py files)\n"
        _lang='Python'
        printf "1.1: language: $_lang\n"
    elif [ -f "package.json" ]; then
        printf "Found package.json file ($NUM_TS *.ts files)\n"
        _lang='JavaScript'
        printf "1.2: language: $_lang\n"
        if ((NUM_TS > 0)); then
            _lang='TypeScript'
            printf "1.3: language: $_lang\n"
        fi
    else
        printf "Sorry! Unable fo find context for \"detect-language\"!\nLooking for files...\n"
        # echo "Found $NUM_PY python file(s)"
        # echo "Found $NUM_TS TypeScript file(s)"
        # find -name '*.py'
        printf "2.1: language: $_lang\n"
        if (($NUM_PY > 0)); then
            _lang='Python'
            printf "Found $NUM_PY Python files!\n"
            printf "2.2: language: $_lang\n"
        elif (($NUM_TS > 0)); then
            _lang='TypeScript'
            #TODO printf"Found $NUM_TS TypeScript files, BUT MISSING \"package.json\".  Run 'npm init'!\n"
            printf "2.3: language: $_lang\n"
        else
            printf "Sorry! No context for \"detect-language\"!\n"
            printf "2.4: language: $_lang\n"
        fi
    fi
    printf "3: language: $_lang\n"

    # local _outvar=$_lang
    # local _result # Use sme naming convention to avoid OUTVARs to clash
    # # ... some processing ....
    # eval $_outvar=\$_result # Instead of just =$_result

    # eval "$1=$_lang"
    printf "detect-language will return $_lang\n"
    printf "$_lang"
}

function iop() { # info-on-project (folder)
    printf "\niop  =  info-on-project (folder)\n------------------------\n"
    local _lang=$(detect-language | tail -1)
    printf " Found language: $_lang\n"
    local _tool=$(detect-bdd-tool | tail -1)
    printf " Found bdd_tool: $_tool\n\n"
    # venv
}

function detect-bdd-tool() {
    # Use: local _tool=$(detect-bdd-tool | tail -1)
    local _tool='?'
    local NUM_LINE_PYTEST_BDD=$(grep "pytest-bdd" requirements*.txt | wc -l)
    local NUM_LINE_BEHAVE=$(grep "behave" requirements*.txt | wc -l)
    printf "Found $NUM_LINE_PYTEST_BDD line(s) with pytest-bdd\n"
    printf "Found $NUM_LINE_BEHAVE line(s) with behave\n"
    if ((NUM_LINE_PYTEST_BDD > 0)); then
        _tool='pytest-bdd'
    elif [[ NUM_LINE_BEHAVE -ne 0 ]]; then
        _tool='behave'
    fi
    printf "$_tool"
}

function pip-info() {
    local _options=$@ # grep option(s) to use
    local _the_grep="grep git"
    # printf "a4g()\n grep option(s): '$_options'\n"
    echo 'param =>' "'$1'"
    if (($# == 0)); then
        echo "no dependency supplied for pip-info!"
        local venv=$(printenv | grep VIRTUAL_ENV)
        if [ ! -z "$venv" ]; then
            printf "Found VIRTUAL_ENV"
            pip install pipdeptree
            return
        else
            printf "Didn't find VIRTUAL_ENV"
        fi
    fi
    pip-dep-info-reverse $1
    pip-dep-info $1
}

function py_install_requirements() {
    echo "py_install_requirements()"
    if [ -f "requirements-test.txt" ]; then
        alias pyi-rt
        pyi-rt
    elif [ -f "requirements.txt" ]; then
        alias pyi-r
        pyi-r
    else
        echo "Found no requirement file(s). Unable to load requirements"
    fi
}

function alias-match() {
    local _num_params=$#
    local _pattern="$@" # grep option(s) to use
    local _options=""   # for building the grep option(s) to use
    printf "alias-match: \n\tGot $_num_params param(s): ($_pattern)\n"
    if [ $_num_params -eq 0 ]; then
        printf "\n(No paramer(s) supplied! Needs at least a pattern to match -> Exiting function!)\n"
        return
    elif [[ ${_pattern:0:2} == "- " ]]; then
        _options="--invert-match "
        printf "=> Starts with '- ' => $_options\n"
        _pattern="${_pattern:2}"
        printf "=> (_pattern: '$_pattern')\n"
    fi
    printf "=> (_pattern: '$_pattern')\n"

    printf "alias-match()\n _num_params=$_num_params (_pattern: '$_pattern') -> grep option(s): '$_options'\n"
    printf "\nalias-match : \n-------------\n"
    echo '1=>' "('$_options' == '$*') $1"
    # if [ "$_options" = "" ]; then

    # if (( $# > 1 ) && [ "$1" = "-" ]); then

    #     _options = "--invert-match"
    #     _the_grep="grep $_options git"
    #     printf "\n(Option '$1' ==> '$_the_grep')\na4g $1 :  non-git aliases\n------------------------ \n"
    # else
    #     # _options=""
    #     _the_grep="grep $_options git"
    #     printf "(Unknown alias-match option: '$_options' !!! Will try it)\n"
    # fi

    printf "Will try grepping: alias | grep [$_options] [$_pattern] \n"
    # alias | grep $_options $_pattern
    alias | grep $_options $_pattern | awk -F'=' '{gsub(/^alias /, "", $1); printf "%-5s: %-20s\n", $1, $2}'
}

function a4() {
    printf "\na4 => \"aliases-4\" aka \"alias-match\"\n"
    alias-match "$@"
}

function a4g() {
    printf "\na4g -> \"aliases-4-git\"\n----------------------\n"
    alias-match $_options git
}

function a4g-() {
    printf "\na4g- -> \"non-git aliases\"\n-------------------------\n"
    printf "\na4g- => a4 - git"
    alias-match - git
}

function run() {
    if [ -n "$*" ]; then
        echo '=>' "$@"
        "$@"
        return
    fi
    echo "no param for run command!"
}

# Example for getting params in bash:
# function bash_param() {
#     local _cmd=$@
#     if [ ${#_cmd} -ge 1 ]; then
#         echo "\n--> $_cmd"
#         printf "bash_param()\n Parameter #1 is '$1'\n"
#         printf "bash_param()\n Parameters are '$_cmd'\n"
#     else
#         echo "no params\n"
#     fi
# }

function bdd-init() {
    printf "BDD-init\n"
    if [ -d "features" ]; then
        printf "FYI: bdd-init skipped, found existing \"features\" folder!"
    else
        printf "bdd-init: \nFirst adding folders for running BDD ('features' + subfolder 'steps')"
        mkdir features
        mkdir features/steps
        printf "\nMaking file for where to put step definitions, aka \"gluecode\": (steps.py)\n"
        echo "from behave import *" >>features/steps/steps.py
        printf "\nHappy BDD!\n\n"
    fi
}

function prj-info() {
    local _lang='-?-'
    _lang=$(detect-language | tail -1)
    if [[ "$_lang" != *"?"* ]]; then
        echo "Found language is probably: $_lang"
    else
        echo "Unable to detect language!"
    fi
}

# function bdd() {
#     local _lang='-?-'
#     local _tool='-?-'
#     _lang=$(detect-language | tail -1)
#     echo "Found language: $_lang"
#     _tool=$(detect-bdd-tool | tail -1)
#     echo "Found bdd_tool: $_tool"

####  bdd_features_base_dir settings in toml file
#     if [ -d "tests/features" ] && [ _tool == "pytest-bdd"]; then
#         printf "Will try to run $_tool (-> bdd-pytest / bdd_pt):\n\n"
#         alias bdd-pytest
#         bdd-pytest
#     elif [ -d "features" ]; then
#         printf "BDD (found a features folder)\n"
#         printf "We are in a $_lang project!\n"
#         case $_lang in
#             Python)
#                 printf "Will try to run $_tool:\n\n"
#                 # TODO Check if django involved? need to run "manage.py behave" (-> "manage.py ${bdd-py}")
#                 case $_tool in
#                     pytest-bdd)
#                         alias bdd-pytest
#                         bdd-pytest
#                     ;;
#                     behave)
#                         alias bdd-behave
#                         bdd-behave

#             ;;
#             JavaScript)
#                 ;& # falltrough
#             TypeScript)
#                 printf "Will try to run Cucumber-JS:\n\n"
#                 alias wip-n
#                 wip-n
#             ;;
#                 *)
#                     printf "BDD! \t( no packages.json, no requirements*.txt file )\n"
#                     printf "Sorry! Unable to find \"bdd-context\" for $_lang / $_tool!"
#                 ;;
#         esac
#     else
#         printf "FYI: bdd skipped, missing \"features\" folder! Run bdd-init first!"
#         # return 1
#     fi
# }

function run_() {
    local _tags=''
    local _param=''
    local _prev=''
    local _default='or'
    local param_num=0
    local num_params=$#
    echo "Got $num_params param(s), default is '$_default'"
    for _param in "$@"; do
        echo ">param=$_param (_prev: $_prev)"
        if [$_prev == ""]; then
            echo "  '$_prev' == ''"
            _tags="$_param"
            _prev="$_param"
        else
            echo "  $_prev !== '' (:$_default:)"
            _tags="$_tags $_default $_param"
            echo "tags: $_tags"
            _prev="$_param"
        fi
        echo "<param=$_param (_prev: $_prev)"

        # #  && [[ "$_param" == "or" ] | [ "$_param" == "and" ]]; then
        #     _tags="$_tags $_default $_param"
        # fi
        # if [ "$_param" == "or" ] | [ "$_param" == "and" ] ; then
        #     _tags="$_tags $_param"
        #     _prev=$param
        #     echo "_tags=$_tags (_prev: $_prev)"
        # else
        #     _tags="$_tags or $_param"
        #     _prev=""
        # fi
        # _prev=_param
        echo "tags: $_tags"
    done

    echo "tags: $_tags"
    _tags="--tags=not skip and ($_tags)"
    echo "tags: $_tags"
}

function py-install-requirements() {
    echo "py-install-requirements()"
    if [ -f "requirements-test.txt" ]; then
        alias pyirt
        pyirt
    elif [ -f "requirements.txt" ]; then
        alias pyir
        pyir
    else
        echo "Found no requirement file(s). Unable to load requirements"
    fi
}

function wip() {
    prj-info
    local _lang='-?-'
    local _tool='-?-'
    local _tags='-?-'
        _lang=$(detect-language | tail -1)
    echo "Found language: $_lang"
    _tool=$(detect-bdd-tool | tail -1)
    echo "Found bdd_tool: $_tool"
    #
    # if [ "$1" !== "" ]; then
    if (($# > 0)); then
        echo "Got $# param(s)"
        _tags="--tags="
    fi
    if [ "$1" != "" ]; then
        _tags="--tags=$1"
        printf "\nrunning wip with tag '$1':\n--------------------------\n"
    fi
    case $_tool in
    behave)
        if [ -d "features" ]; then
            printf "Will try to run Behave (--> wip-behave / wip-b):\n\n"
            alias wip-behave
            wip-behave _tags
        else
            printf "FYI: wip skipped, missing 'features' folder! Run bdd-init first!"
        fi
        ;;
    pytest-bdd)
        if [ -d "tests/features" ]; then
            printf "Found 'tests/features' folder.\n"
        elif [ -d "features" ]; then
            printf "Found 'features' folder.\n"
        fi
        printf "Will try to run:\n"
        wip-pytest
        ;;
    *)
        # case $_lang in
        # JavaScript)
        #     ;&
        # TypeScript)
        #     printf "Will try to run Cucumber-JS:\n\n"
        #     alias wip-node
        #     wip-node
        #     ;;
        # *)
        printf "$_tool for language $_lang was not handled here!\n(function needs update!)\n\n"
        ;;
    esac
    echo "wip ended!"
}

function use-forward-slashes() {
    printf "\nRunning use-forward-slashes with param\n"
    # printf "-------------------------------------------------------------------------------------\n"
    printf "before:'$1'\n"
    after="${1//\\//}"  # Replace backslashes with forward slashes
    printf "after :'${after}'\n"
    "${after}"
}



function maybe-call-workon() {
    local _lang=$(detect-language | tail -1)

    # printf "\n(maybe-call-workon:)\nFound language is probably: '$_lang'\n"
    if [[ "$_lang" != *Python* ]]; then
        # printf "\n(Unsupported language in 'maybe-call-workon'! -> Exiting function!)\n"
        return
    fi

    if [ -e .venv ]; then
        printf "==> maybe-call-workon found .venv folder!\n"
        printf "==> .venv folder is NOT wanted virtual environment solution!\n"
        printf "==> Suggestion just delete ${CYAN}.venv${NC} folder.\n"
        printf "    Instead call ${CYAN}ave${NC} -> Activates the virtual environment (using virtualenvwrapper: workon .)\n"
        printf "... or don't comply and activate (.venv) anyway by calling ${CYAN}avenv${NC} -> Activates the virtual environment (using .venv/Scripts/activate)\n"
        printf "    No virtual environment have been activated! Exiting function!\n"
        return
    fi
    # Put virtualenvwrapper.sh "in action"
    ave
}
