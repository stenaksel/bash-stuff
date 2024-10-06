#!/bin/bash

printf "\t Installing function definitions ...${CYAN}~/bash-stuff/.bash_functions${NC}\n"
printf "\t  ( ${CYAN}hint${NC} -> show more info )\n\n"

# ----------------------
# My functions
# ----------------------

function venv() {
    local venv=$(printenv | grep VIRTUAL_ENV)
    if [ ! -z "$venv" ]; then
        printf "$venv\n"
        printf "\n==> Inside virtualenv: $VIRTUAL_ENV ... $VIRTUAL_ENV_PROMPT"
    else
        printf "\n==> Outside a virtualenv..."
    fi
}

function hints() {
# TODO Modify how hints are generated and shown based on comments in each alias and function
    printf "\nhints()\t( <p> means param(s) )\n-------\n"
    printf "alias-match <p>\t = \"Alias matching\" <p> ( Calls grep with param(s) )\n"
    printf "alias-match -<p>\t = \"Alias not matching\" <p>\n"
    printf "a4 <p>\t = \"Alias for\" matching -> 'alias-match' <p>\n"
    printf "a4 -<p>\t = \"Alias not\" matching -> 'alias-match' -<p>\n"
    printf "a4g\t = Showing all git aliases -> 'a4 git'\n"
    printf "a4g-\t = Showing all non-git aliases (-> 'a4 -git' => 'a4 --invert-match git')\n"
    # printf "a4g-\t = --''--\n"
    printf "bdd-init = Setup for running BDD ('features' + subfolder 'steps')\n"
    printf "bdd\t = Run BDD test - running tests (in features)\n"
    printf "no_tags = \t show all untagged BDD scenarios\n"
    printf "find_tags <p> <p> (aka just "tag") show all BDD scenarios tagged with the tag(s)\n"
    printf "dup\t = Run the database in docker ('docker-compose up pg')\n"
    printf "iop\t = info-on-project (in folder)\n"
    printf "wip\t = Run wip BDD tests\n"
    printf "venv\t = Show info about configured virtual environment (in shell)\n"
    printf "blue?\t = Check if some python files needs Blue formatting\n"
    printf "blueit\t = Run Blue formatter on all python files, EXCEPT those in migrations folder\n"
    printf "blueall\t = Run Blue formatter on all python files\n"
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

function give_warning_and_info() {
    # Checking the number of parameters passed
    # Ensure that the function is called with at least one parameter.
    # Param 1 = theWarning
    # Param 2 = hint(s)
    # If no parameters, print a usage message and return with an error code 1.
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: give_warning_and_info <first string> [second string]"
        return 1
    fi

    # Assigning the first parameter to a local variable
    local theWarning="$1"

    # Assigning the second parameter to a local variable, if provided
    local hints=""
    if [ "$#" -eq 2 ]; then
        hints="$2"
    fi

    # Printing the values for demonstration
    echo "First String: $theWarning"
    if [ -n "$hints" ]; then
        echo "Second String: $hints"
    else
        echo "Second String is not provided."
    fi

    # Your warning and information logic goes here
    # For example, you could print a warning message based on the given strings
    echo "Warning: Something might need attention related to '$theWarning'!"
    if [ -n "$hints" ]; then
        echo "Info: Additional context related to '$hints'."
    fi
}

function alias-match() {
    # Check if any parameters are passed
    if [ "$#" -eq 0 ]; then
        printf "${ALERT}No parameter(s) supplied!${NC}${CYAN}\nUsage: alias-match <pattern>${NC}"
        give_warning_and_info "No parameter(s) supplied!" "Usage: alias-match <pattern>"
        return 1
    fi
    local _num_params=$#
    # Concatenate all parameters into a single pattern
    local _pattern="$*"

    # Get the list of all aliases
    local all_aliases
    all_aliases=$(alias)

    # Filter aliases based on the combined pattern
    local filtered_aliases
    filtered_aliases=$(echo "$all_aliases" | grep --ignore-case "$_pattern")

    # Print the filtered aliases
    if [ -n "$filtered_aliases" ]; then
        echo "Aliases containing pattern '$_pattern':"
        echo "$filtered_aliases"
    else
        echo "No aliases found containing the pattern '$_pattern'"
    fi

#    # Get the list of all aliases
#    local all_aliases
#    all_aliases=$(alias)
#    echo "Before for loop! ${pattern}"
#
#    # Filter aliases based on all provided patterns
#    filtered_aliases="$all_aliases"
#    for pattern in "$@"; do
#        filtered_aliases=$(echo "$filtered_aliases" | grep --ignore-case "$pattern")
#    done
#
#    # Print the filtered aliases
#    if [ -n "$filtered_aliases" ]; then
#        echo "Aliases containing all patterns '$*':"
#        echo "$filtered_aliases"
#    else
#        echo "No aliases found containing all patterns '$*'"
#    fi


#    # Loop through each parameter
#    for pattern in "$@"; do
#        # Filter and print aliases that contain the pattern
#        echo "Aliases containing pattern '$pattern':"
#        echo "$all_aliases" | grep --ignore-case --color=always "$pattern"
#        echo ""
#    done
    echo "After for loop!"
}
#
#    local _pattern="$@" # grep option(s) to use
#    local _options=""   # for building the grep option(s) to use
#    printf "alias-match: \n\tGot $_num_params param(s): ($_pattern)\n"
#    if [ $_num_params -eq 0 ]; then
#        printf "\n(No paramer(s) supplied! Needs at least a pattern to match -> Exiting function!)\n"
#        return
#    fi
#    if [[ ${_pattern:0:2} == "- " ]]; then
#        _options="--invert-match "
#        printf "=> Starts with '- ' => $_options\n"
#        _pattern="${_pattern:2}"
#        printf "=> (_pattern: '$_pattern')\n"
#    fi
#    printf "=> (_pattern: '$_pattern')\n"
#
#    printf "alias-match()\n _num_params=$_num_params (_pattern: '$_pattern') -> grep option(s): '$_options'\n"
#    printf "\nalias-match : \n-------------\n"
#    echo '1=>' "('$_options' == '$*') $1"
#
#    printf "Will try grepping: alias | grep $_options '$_pattern' \n"
#    # alias | grep $_options $_pattern
#    alias | grep $_options '${_pattern}' #| awk -F'=' '{gsub(/^alias /, "", $1); printf "%-5s: %-20s\n", $1, $2}'
#}

function am() {
    printf "\nam => \"alias-match\"\n"
    alias-match git log
#    alias-match "$@"
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

function xrun() {
    if [ -n "$*" ]; then
        echo '=>' "$@"
        "$@"
        return
    fi
    echo "no param for run command!"
}

function run() {
    local full_cmd="$*"
    local cmd_desc
    local org_cmd
#    printf "full_cmd: %s\n" "$full_cmd"

    # Split full_cmd into command and description based on double colons
    if [[ "$full_cmd" == *"::"* ]]; then
        cmd_desc="${full_cmd##*::}"
        org_cmd="${full_cmd%%::*}"
    else
        org_cmd="$full_cmd"
    fi
#    printf "cmd_desc: %s\n" "$cmd_desc"
#    printf "org_cmd: %s\n" "$org_cmd"

    local org_cmd_arr=($org_cmd)
    local args=()

    # Iterate through each argument and escape % characters
    for arg in "${org_cmd_arr[@]}"; do
        args+=("$(echo "$arg" | sed 's/%/%%/g')")
    done

    # Join the escaped arguments back into a single string
    local the_cmd="${args[*]}"
#    printf "the_cmd: %s\n" "$the_cmd"

    # Revert the expansion of ~ to the literal ~
    local display_cmd_desc=$(echo "$the_cmd" | sed "s|$HOME|~|g")
#    printf "display_cmd_desc: %s\n" "$display_cmd_desc"

    if [[ -n "$cmd_desc" && "$cmd_desc" != "$full_cmd" ]]; then
        printf "${CYAN} => %s\n" "$display_cmd_desc  <-- $cmd_desc"
    else
        printf "${CYAN} => %s\n" "$the_cmd"
    fi
    printf "|==============================================================================${NC}\n"
    # If Maven involved we need a pom.xml file.
    # If not found just alert and quit!
    if [[ "$the_cmd" == *"mvn"* ]]; then
        check_pom
        local status=$?
        if [ $status -ne 0 ]; then
            return $status
        fi
    fi

    eval "$the_cmd"
}
function alias_info() {
    # Example aliases
    #alias c='run clear::Clear the terminal screen'
    #alias l='run ls -l::List in long format'
    # Get the list of aliases and sort them by name
    local aliases
    aliases=$(alias | sort)

    # Header for the output
    printf "| Name  | Description             |\n"
    printf "|-------|--------------------------|\n"

    # Iterate over each alias
    while IFS= read -r line; do
        # Extract alias name and command content
        local name="${line%%=*}"
        local full_cmd="${line#*=}"

        # Remove leading/trailing single quotes from full_cmd
        full_cmd="${full_cmd#\'*}"
        full_cmd="${full_cmd%\'}"

        # Extract description if present
        local desc
        if [[ "$full_cmd" == *"::"* ]]; then
            desc="${full_cmd##*::}"
            desc="${desc%\'*}"  # Remove any trailing quote if present
        else
            desc="$full_cmd"
        fi

        # Output alias name and description
        printf "| %-5s | %-24s |\n" "$name" "$desc"
    done <<< "$aliases"
}


function xrun() {
    local org_cmd=("$@")
    # Iterate through each argument and escape % characters
    local args=()
    for arg in "$@"; do
        args+=("$(echo "$arg" | sed 's/%/%%/g')")
    done
    # Join the escaped arguments back into a single string
    local the_cmd="${args[*]}"
    printf " ${CYAN} => $the_cmd\n"
    printf "|==============================================================================${NC}\n"
    # If Maven involved we need a pom.xml file.
    # If not found just alert and quit!
    if [[ "$the_cmd" == *"mvn"* ]]; then
        check_pom
        local status=$?
        if [ $status -ne 0 ]; then
            return $status
        fi
    fi
    eval "$the_cmd"
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
    clear
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
    after="${1//\\//}" # Replace backslashes with forward slashes
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

function find_scenarios_without_tags() {
    directory='.'
    scenarios_without_tags=()

    shopt -s globstar
    for feature_file in $directory/**/*.feature; do
        while IFS= read -r line; do
            if [[ $line =~ ^[[:space:]]*(Scenario|Scenario Outline): && ! $prev_line =~ ^[[:space:]]*@ ]]; then
                scenarios_without_tags+=("$feature_file¤$line")
            fi
            prev_line=$line
        done <"$feature_file"
    done

    # printf "%s\n" "${scenarios_without_tags[@]}"
    # printf "%s\n" "${scenarios_without_tags[@]}" | awk -F: '{printf "%s\t%s\n", $1, $2}' | column -t -s $'\t'
    printf "%s\n" "${scenarios_without_tags[@]}" | awk -F'¤' '{printf "%s\t%s\n", $1, $2}' | column -t -s $'\t'
}

# Example usage
# directory="path/to/your/directory"
# find_scenarios_without_tags "$directory"

function find_scenarios_with_tag() {
    directory='.'
    tag=$2
    scenarios_with_tag=()

    shopt -s globstar
    for feature_file in $directory/**/*.feature; do
        while IFS= read -r line; do
            echo "x $prev_line"
            echo "> $line"
            if [[ $line =~ ^[[:space:]]*(Scenario|Scenario Outline): ]]; then
                prev_line=$line
            elif [[ $line =~ ^[[:space:]]*@$tag ]]; then
                scenarios_with_tag+=("$feature_file¤$prev_line")
                echo " [$line]"
            fi


        done <"$feature_file"
    done

    printf "%s\n" "${scenarios_with_tag[@]}" | awk -F'¤' '{printf "%s\t%s\n", $1, $2}' | column -t -s $'\t'
}

function xxxfind_tags() {
    # Initialize the "found" list
    found=()

    # Search for *.feature files in the current directory and its subdirectories
    while IFS= read -r -d '' file; do
        echo "Searching in file: $file"

        # Read each line in the file
        while IFS= read -r line; do
            # Check if the line contains all the tags prefixed by '@' in any order
            if [[ $line =~ $(printf "(?=.*@%s)" "$@" | sort -u) ]]; then
                # Add the next line to the "found" list
                read -r next_line
                found+=("$next_line")
            fi
        done <"$file"
    done < <(find . -type f -name "*.feature" -print0)

    # Print the "found" list
    echo "Found lines:"
    for line in "${found[@]}"; do
        echo "$line"
    done
}

function xxfind_tags() {
    # Initialize the "found" list
    found=()

    # Iterate over each argument passed to the function
    for tag in "$@"; do
        echo "Searching for tag: $tag"
    done

    # Search for *.feature files in the current directory and its subdirectories
    while IFS= read -r -d '' file; do
        echo "Searching in file: $file"

        # Read each line in the file
        while IFS= read -r line; do
            # Check if the line contains all the tags prefixed by '@' in any order
            if [[ $line == *@($(echo "$@" | tr ' ' '|'))* ]]; then
                # Add the next line to the "found" list
                read -r next_line
                found+=("$next_line")
            fi
        done <"$file"
    done < <(find . -type f -name "*.feature" -print0)

    # Print the "found" list
    echo "Found lines:"
    for line in "${found[@]}"; do
        echo "$line"
    done
}

function xfind_tags() {
    # Initialize the "found" list
    found=()

    # Iterate over each argument passed to the function
    for tag in "$@"; do
        if [[ $tag == "-" ]]; then
            echo "Searching for Scenario without tags"
        else
            echo "Searching for tag: $tag"
        fi
    done

    # Search for *.feature files in the current directory
    for file in ./**/*.feature; do
        # for file in ./*.feature; do
        echo "Searching in file: $file"

        # Read each line in the file
        while IFS= read -r line; do
            # Check if the line contains all the tags prefixed by '@' in any order
            if [[ $line == *@($(echo "$@" | tr ' ' '|'))* ]]; then
                # Add the next line to the "found" list
                read -r next_line
                found+=("$next_line")
            fi
            prev_line=$line
        done <"$file"
    done

    # Print the "found" list
    echo "Found lines:"
    for line in "${found[@]}"; do
        echo "$line"
    done
}

# find_scenarios_with_tags() {
#     directory='.'
#     tags=("$@")
#     # tags=("wip")
#     feature=""
#     scenarios=()

#     shopt -s globstar # allows for recursive globbing using the ** pattern
#     if [[ -z $tags ]]; then
#         # no params given to function
#         printf "\nExpected param(s) to find Scenarios!\n"
#         printf "\nParams can be one or more tags, or just '-' to find Scenarioes without tags!\n"
#         return
#     else
#         printf "\e[30m params: $tags \e[0m\n"
#         # if [[ $tags == ("-")]]; then
#         # printf "\n'-' => find all Scenarioes without tags!\n"
#     fi

#     # Iterate over each .feature file in the specified directory and its subdirectories
#     for feature_file in $directory/**/*.feature; do
#         while IFS= read -r line; do
#             printf "\e[30mLine: %s \e[0m\n" "$line"
#             # printf "\e[31m %s \e[0m\n" "$line"

#             # if [[ $line =~ ^(Feature:|\s+Scenario|\s+Scenario Outline) ]]; then
#             if [[ $line =~ ^(Feature): ]]; then
#                 printf "\e[30mFeature:-> \e[31m %s \e[0m \n" "$line"
#                 feature=$line
#             elif [[ $line =~ ^[[:space:]]*(Scenario|Scenario Outline): ]]; then
#                 # => A scenario line
#                 printf "Scenario line-> \e[30m %s \e[0m %s\n" "$feature" "$line"
#                 prev_line=$line
#             else
#                 # => A step line ?
#                 printf "step? \e[32m %s \e[0m\n" "$line"
#             fi
#             if [[ -z $tags ]]; then
#                 # no tags given to function
#                 # if [[ $tags == ("-") && ! $prev_line =~ ^[[:space:]]*@ ]]; then
#                 #     # => Found no tags on the scenario, so add it
#                 #     printf "\e[31m(adding it)\e[0m"
#                 #     scenarios+=("$feature_file¤$prev_line")
#                 # fi
#             else
#                 printf "\e[31m Not [ -z $tags ]\e[0m\n"
#                 all_tags_found=true
#                 for tag in "${tags[@]}"; do
#                     if [[ ! $line =~ ^[[:space:]]*@$tag ]]; then
#                         all_tags_found=false
#                         break
#                     fi
#                 done
#                 if $all_tags_found; then
#                     scenarios+=("$feature_file¤$prev_line")
#                 fi
#             fi
#             #
#             prev_line=$line
#         done <"$feature_file"
#     done

#     # echo "Found ${#scenarios[@]} scenarios" | wc -l
#     echo "Found ${#scenarios[@]} lines"
#     printf "%s\n" "${scenarios[@]}" | awk -F'¤' '{printf "%s\t%s\n", $1, $2}' | column -t -s $'\t'

# }

# TODO: Remove check_string?
function check_string() {
    local str_par="$1" # Assign the first parameter to str_par
    shift              # Shift the parameters to the left, excluding str_par
    local tags=("$@")  # Store the remaining parameters in tags array

    printf "Checking string: '%s' for tags: '%s'\n" "$str_par" "${tags[@]}"
    # Add the '@' prefix to each string in tags
    local prefixed_list=()
    for str in "${tags[@]}"; do
        prefixed_list+=("@$str")
    done

    # Check if all strings in prefixed_list are present in str_par
    for str in "${prefixed_list[@]}"; do
        if [[ ! $str_par =~ "$str" ]]; then
            return # Exit the function if any string is not present
        fi
    done

    # If all strings in prefixed_list are present in str_par, print str_par
    echo "$str_par"
}

function find_tags() {
    # Initialize the "found" list
    local found_tags=()
    local found_lines=()
    local found_scenarioes=()
    local looking_for=()
    local tags=()
    for param in "$@"; do
        tags+=("@$param")
    done
    local found_all=false
    local line_no=0

    # # Add the _@_ prefix to each string in tags
    # local prefixed_list=()
    # for str in "${tags[@]}"; do
    #     prefixed_list+=("@$str")
    # done

    printf "\nLooking for tag(s): '${tags[*]}' (in all feature files)\n"

    # Search for *.feature files in the current directory and its subdirectories
    while IFS= read -r -d '' file; do
        found_lines=()
        # printf "Trying to find tags: \t${tags[*]}, \n\t    in file:\t$file\n\n"
        # echo "Searching in file: $file for tags: ${tags[@]}"

        # Read each line in the file
        while IFS= read -r line; do
            if $found_all; then # all tags found in previous line
                # echo "Prevous line ($line_no) contained all tags! Adding this line to found_scenarioes"
                ((line_no++))
                found_scenarioes+=("$line_no: $line")
            else
                ((line_no++))
            fi
            found_tags=()
            found_all=false

            # Check if all strings in prefixed_list are present in line
            looking_for=("${tags[@]}")
            # printf "\e[30mLine %s: %s \e[0m <- trying to find: %s\n" "$line_no" "$line" "[${tags[*]}]"
            # While looking_for is not empty

            found_tags=()
            for tag in "${tags[@]}"; do
                # echo "  Now looking for tag: '$tag' (in [$line])"
                if [[ ! $line =~ .*\<$tag\>.* ]]; then
                    # code to execute if $tag is not a whole word in $line
                    printf "$line_no  '$tag' not in [$line]\n"
                else
                    # code to execute if $tag is a whole word in $line
                    printf "$line_no  '$tag' was in [$line]\n"
                fi


                if [[ $line =~ .*\<$tag\>.* ]]; then
                    printf "  Found tag: '$tag' (in [$line])\n"
                fi
                # if [[ $line != *"$tag"* ]]; then
                #     if [[ $line =~ .*\<$tag\>.* ]]; then
                #         found_all=false
                #         # No need to find any more tags
                #         # echo "  The string '${tag}' is not in the line (breaking out of for loop)"
                #         break

                # else
                #     looking_for=("${looking_for[@]/$tag/}")
                #     found_tags+=("$tag")
                # fi

                # echo "  end of: for tag: '$tag'"
            done # for tag in "${tags[@]}"; do
            # echo "   (Finished: for tag in "${tags[@]}"; do) | still looking for: '${looking_for[*]}'"
            if [ "${#found_tags[@]}" -eq "${#tags[@]}" ]; then
                found_all=true
            fi

            # printf "   Found tags = ${found_tags[*]}\t|found_all = $found_all\n"

            if $found_all; then
                # found_all=true
                # echo "found_all = $found_all ==> line: [$line]"
                found_lines+=("$line_no: $line")
            else
                looking_for=("${tags[@]}")
                for tag in "${found_tags[@]}"; do
                    looking_for=("${looking_for[@]/$tag/}")
                done
                # echo "   found_all = $found_all. Still looking for: ${looking_for[*]} "
                # echo "   Did not find all tags ==> {$tags}\n"
            fi
            # echo " while IFS= read -r line; do"
        done <"$file" # while IFS= read -r line; do

        # read -r next_line
        # printf "\e[30mWill add the next line to the "found" list: %s \e[0m\n" "$next_line"
        # found_scenarioes+=("$next_line")

        # # # Break the while loop
    done < <(find . -type f -name "*.feature" -print0) # while IFS= read -r -d '' file; do
    # Print the "found_tags" list
    # echo "found_lines:"
    # for line in "${found_lines[@]}"; do
    #     echo "$line"
    # done
    echo "_@____ Scenario____________________________________________________________________________"
    for line in "${found_scenarioes[@]}"; do
        echo "$line"
    done

}

# TODO: if tags start with 'pytest.mark.' then search in py files
function find_py_tags() {
    # Initialize the "found" list
    local found_tags=()
    local found_lines=()
    local found_tests=()
    local looking_for=()
    local tags=()
    for param in "$@"; do
        tags+=("pytest.mark.$param")
    done
    local found_all=false
    local line_no=0

    printf "\nLooking for tag(s): '${tags[*]}' (in all python test files)\n"

    # Search for *.feature files in the current directory and its subdirectories
    while IFS= read -r -d '' file; do
        found_lines=()
        printf "Trying to find tags: \t${tags[*]}, \n\t    in file:\t$file\n\n"
        # echo "Searching in file: $file for tags: ${tags[@]}"

        # Read each line in the file
        while IFS= read -r line; do
            if $found_all; then # all tags found in previous line
                # echo "Prevous line ($line_no) contained all tags! Adding this line to found_tests"
                ((line_no++))
                found_tests+=("$line_no: $line")
            else
                ((line_no++))
            fi
            found_tags=()
            found_all=false

            # Check if all strings in prefixed_list are present in line
            looking_for=("${tags[@]}")
            # printf "\e[30mLine %s: %s \e[0m <- trying to find: %s\n" "$line_no" "$line" "[${tags[*]}]"
            # While looking_for is not empty

            found_tags=()
            for tag in "${tags[@]}"; do
                # echo "  Now looking for tag: '$tag' (in [$line])"
                if [[ $line != *"$tag"* ]]; then
                    found_all=false
                    # No need to find any more tags
                    # echo "  The string '${tag}' is not in the line (breaking out of for loop)"
                    break
                else
                    looking_for=("${looking_for[@]/$tag/}")
                    found_tags+=("$tag")
                fi

                # echo "  end of: for tag: '$tag'"
            done # for tag in "${tags[@]}"; do
            # echo "   (Finished: for tag in "${tags[@]}"; do) | still looking for: '${looking_for[*]}'"
            if [ "${#found_tags[@]}" -eq "${#tags[@]}" ]; then
                found_all=true
            fi

            # printf "   Found tags = ${found_tags[*]}\t|found_all = $found_all\n"

            if $found_all; then
                # found_all=true
                # echo "found_all = $found_all ==> line: [$line]"
                found_lines+=("$line_no: $line")
            else
                looking_for=("${tags[@]}")
                for tag in "${found_tags[@]}"; do
                    looking_for=("${looking_for[@]/$tag/}")
                done
                # echo "   found_all = $found_all. Still looking for: ${looking_for[*]} "
                # echo "   Did not find all tags ==> {$tags}\n"
            fi
            # echo " while IFS= read -r line; do"
        done <"$file" # while IFS= read -r line; do

        # read -r next_line
        # printf "\e[30mWill add the next line to the "found" list: %s \e[0m\n" "$next_line"
        # found_tests+=("$next_line")

        # # # Break the while loop
    done < <(find . -type f -name "test_before_feature_2.py" -print0) # while IFS= read -r -d '' file; do
    # Print the "found_tags" list
    # echo "found_lines:"
    # for line in "${found_lines[@]}"; do
    #     echo "$line"
    # done
    echo "_@____ Test____________________________________________________________________________"
    for line in "${found_tests[@]}"; do
        echo "$line"
    done
}

function run_where() {
  local cmd_path
  cmd_path=$(which "$1" 2>/dev/null || where "$1" 2>/dev/null | head -n 1)
  if [ -n "$cmd_path" ]; then
    echo "Starting: $1 from ${cmd_path}"
    "$cmd_path" "${@:2}"
  else
    echo "Command not found: $1"
  fi
}

function check_pom() {
  if [ ! -f "pom.xml" ]; then
    printf "\n${ALERT} No pom.xml file found in this folder! ${NC}\n"
    return 1
  fi
}

function confirm_action() {
    # Capture the command to be executed.
    local command="$1"

    # Inform the user about the command to be executed.
    printf "\n ${ALERT} You are about to run: ${NC}${CYAN} $command ${NC}\n"
#    echo "You are about to run: $command"
        # Prompt the user for confirmation.
    echo "  Are you sure?"

    # Read the user's input.
    read -r -s -n 1 -p "  Press Y key to continue or any other key to cancel!" confirmation
    echo # To add a new line after user input

    # Check if the input is 'Y' or 'y'.
    if [[ $confirmation =~ ^[Yy]$ ]]; then
        # Execute the provided command.
        eval "$1"
    else
        printf "\n  ${CYAN}Operation cancelled!${NC}"
    fi
}
