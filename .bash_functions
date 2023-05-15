
#!/bin/bash
echo "Reading ~/bash-stuff/.bash_functions: Function definitions (read by .bashrc) "
# ----------------------
# My functions
# ----------------------

function show_functions() {
    printf "\nshow_functions()\n----------------\n"
    printf "a4g\t = Showing all aliases for git\n"
    printf "bdd-init = Setup for running BDD ('features' + subfolder 'steps')\n"
    printf "bdd\t = Run BDD test - running tests (in features)\n"
    printf "wip\t = Run wip BDD tests\n"
}

# function pass_back_a_string() {
#     local someStr='Python'
#     # eval "$1='Python'"
#     # eval "$1='$someStr'"
#     eval "$1=$someStr"
#     # eval "$1=detect_language"
# }

function detect_language() {
    # set -
    local _lang='?'
    local NUM_PY=$(find -name '*.py' | wc -l)
    local NUM_TS=$(find -name '*.ts' | wc -l)
    if [ -f "package.json" ]; then
        _lang='JavaScript'
        if [NUM_TS != 0]; then
            _lang='TypeScript'
        fi
        elif [ -f "requirements-test.txt" ] || [ -f "requirements.txt" ]; then
        _lang='Python'
    else
        # printf "Sorry! Unable fo find context for \"detect_language\"!\nLooking for files...\n"
        # echo "Found $NUM_PY python file(s)"
        # echo "Found $NUM_TS TypeScript file(s)"
        # find -name '*.py'
        if [[ $NUM_PY != 0 ]]; then
            _lang='Python'
            # printf"Found $NUM_PY Python files!\n"
            elif [[ $NUM_TS != 0 ]]; then
            _lang='TypeScript'
            # printf"Found $NUM_TS TypeScript files, BUT MISSING \"package.json\".  Run 'npm init'!\n"
        fi
        # printf "Beklager/Sorry! No context for \"detect_language\"!\n"
    fi
    
    # local _outvar=$_lang
    # local _result # Use sme naming convention to avoid OUTVARs to clash
    # # ... some processing ....
    # eval $_outvar=\$_result # Instead of just =$_result
    
    # eval "$1=$_lang"
    echo $_lang
}

function iop() {
    local _lang=''
    _lang=$(detect_language)
    echo "Found language now: '$_lang'"
}

function a4g() {
    printf "\na4g  =  alias for git\n---------------------\n"
    # alias | grep git
    alias | grep git | awk -F'=' '{gsub(/^alias /, "", $1); printf "%-5s: %-20s\n", $1, $2}'
}

function run() {
    local _cmd=$@
    # printf "\nrun('$_cmd')\n---------------------\n"
    if [ ${#_cmd} -ge 1 ]; then
        printf "\n=> $_cmd\n"
        # echo "--> $_cmd"
        shift
        $_cmd
    else
        echo "no param for run command!\n"
    fi
}

function finn_param() {
    local _cmd=$@
    if [ ${#_cmd} -ge 1 ]; then
        echo "\n--> $_cmd"
        printf "finn_param()\n Parameter #1 is '$1'\n"
        printf "finn_param()\n Parameters are '$_cmd'\n"
    else
        echo "no params\n"
    fi
}

function bdd-init() {
    printf "BDD-init\n"
    if [ -d "features" ]; then
        printf "FYI: bdd-init skipped, found existing \"features\" folder!"
    else
        printf "bdd-init: \nFirst adding folders for running BDD ('features' + subfolder 'steps')"
        mkdir features
        mkdir features/steps
        printf "\nMaking file for where to put step definitions, aka \"gluecode\": (steps.py)\n"
        echo "from behave import *" >> features/steps/steps.py
        printf "\nHappy BDD!\n\n"
    fi
}

function prj-info() {
    local _prj='-?-'
    _prj=$(detect_language)
    echo "Found language is probably: $_prj"
    
    case $_prj in
        Python)
            printf "We are in a Python project! \nWill try to run Behave:\n"
        ;;
        JavaScript)
            printf "We are in a JavaScript project!\nWill try to run Cucumber-JS:\n"
        ;;
        TypeScript)
            printf "We are in a TypeScript project!\nWill try to run Cucumber-JS:\n"
        ;;
    esac
    
    # if [ -f "package.json" ]; then
    #     printf "You are in a TypeScript project.\n(Found 'package.json')"
    # elif [ -f "requirements-test.txt" ] || [ -f "requirements.txt" ]; then
    #     printf "You are in a Python project \n(Found requirements.txt )"
    #     alias bdd-py
    #     bdd-py_ && bdd-py
    # else
    #     printf "Sorry! Unable to find context!\n"
    #     printf "To start coding for JavaScript/TypeScript use 'npm init'"
    # fi
    
}

function bdd() {
    prj-info
    local _lang='-?-'
    _lang=$(detect_language)
    echo "Found language: $_lang"
    
    if [ -d "features" ]; then
        printf "BDD!-130 (found a features folder)\n"
        printf "We are in a $_lang project!\n"
        case $_lang in
            Python)
                printf "Will try to run Behave:\n\n"
                # TODO Check if django involved? need to run "manage.py behave" (-> "manage.py ${bdd-py}")
                alias bdd-py
                bdd-py
            ;;
            JavaScript)
                ;&
                TypeScript)
                    printf "Will try to run Cucumber-JS:\n\n"
                    alias wip-n
                    wip-n
                ;;
                *)
                    printf "BDD!-146 \t( no packages.json, no requirements*.txt file )\n"
                    printf "Sorry! Unable to find \"bdd-context\" for $_lang!"
                ;;
        esac
    else
        printf "FYI: bdd skipped, missing \"features\" folder! Run bdd-init first!"
        # return 1
    fi
}

function wip() {
    local _lang='-?-'
    _lang=$(detect_language)
    echo "Found language: $_lang"
    #
    if [ ! -d "features" ]; then
        printf "FYI: wip skipped, missing \"features\" folder! Run bdd-init first!"
    fi
    
    printf "FYI: skipping running prj-info()\n"
    case $_lang in
        Python)
            printf "We are in a Python project! \nWill try to run Behave:\n\n"
            alias wip-py
            wip-py
            # alias wip-py='behave --tags=wip --tags=-skip --format behave_plain_color_formatter:PlainColorFormatter'
        ;;
        JavaScript)
            ;&
            TypeScript)
                printf "We are in a $_lang project!\nWill try to run Cucumber-JS:\n\n"
                alias wip-n
                wip-n
                # alias wip-n='npm run wip'
            ;;
            *)
                printf "Unknown context: $_lang \n\n"
            ;;
    esac
}

function prj-info() {
    local _prj='-?-'
    _prj=$(detect_language)
    echo "Found language is probably: $_prj"
    
    case $_prj in
        Python)
            printf "We are in a Python project! \nWill try to run Behave:\n"
        ;;
        JavaScript)
            printf "We are in a JavaScript project!\nWill try to run Cucumber-JS:\n"
        ;;
        TypeScript)
            printf "We are in a TypeScript project!\nWill try to run Cucumber-JS:\n"
        ;;
    esac
    
    # if [ -f "package.json" ]; then
    #     printf "You are in a TypeScript project.\n(Found 'package.json')"
    # elif [ -f "requirements-test.txt" ] || [ -f "requirements.txt" ]; then
    #     printf "You are in a Python project \n(Found requirements.txt )"
    #     alias bdd-py
    #     bdd-py_ && bdd-py
    # else
    #     printf "Sorry! Unable to find context!\n"
    #     printf "To start coding for JavaScript/TypeScript use 'npm init'"
    # fi
    
}
