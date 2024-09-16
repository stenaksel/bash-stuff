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
    printf "a4 <p>\t = \"Alias for\" matching -> 'alias-match' <p>\n"
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

function xrun() {
    if [ -n "$*" ]; then
        echo '=>' "$@"
        "$@"
        return
    fi
    echo "no param for run command!"
}

function run() {
    local all_params="$*"
    shopt -s expand_aliases

    if [ -n "$*" ]; then
#        printf "0%s " "$@"

        # Split the command while preserving quotes
        IFS=' ' read -r -a args <<< "$*"

        echo "=>" "$@"
        echo "->" "$*"
        # If Maven involved we need a pom.xml file. If not found just alert and quit!
        if [[ "$all_params" == *"mvn"* ]]; then
          if [ ! -f "pom.xml" ]; then
            printf "\n${RED}=> ${all_params}${NC}\t${ALERT} No pom.xml file found in this folder! ${NC}\n"
            return 1
          fi
        fi
        # Check if the first argument is an alias
        alias_name=$(echo "${args[0]}" | awk '{print $1}')

        if alias | grep -q "alias $alias_name="; then
            # Expand alias by executing it in a safe way to get its expanded form
            expanded_command=$(alias $alias_name | awk -F= '{print $2}' | sed "s/^'//;s/'$//")
            echo "=1>" "$expanded_command ${args[@]:1}"
            eval "$expanded_command" "${args[@]:1}"
        else
#            echo "=2>" "$@"
            printf "=> ${CYAN} ${all_params} ${NC}\n"
            "$@"
        fi
    else
        echo "no param for run command!"
    fi
}

# Test cases
# run gss
# run "gss > gss.txt"

#function run2() {
#    args="$*" # Concatenate all arguments into a single string with spaces
#    if [ -n "$*" ]; then
#        echo '=>' "$@"
#        echo 'a>' "[$args]"
#        local str="$1"
#        #if [[ "$str" == "mvn" ]]; then
#        #if [[ "$1" == "mvn" ]]; then
#        #if [[ " $args " == *" mvn "* && (" $args " == *" -v "*)]]; then
#        echo "Check mvn"
#        ###
#        is_maven ?
#        if [[ "$1" == "mvn" ]]; then
#        pom_needed=false
#          cmd="$1"
#          arg="$2"
#
#          case "$cmd $arg" in
#            "mvn -v" | "mvn --version" | "mvn --help")
#              pom_needed=true
#              ;;
#          esac
#
#          echo "pom_needed: pom_needed"
#
#
#        ###
#        if [[ "$1" == "mvn" && !(" $args " == *" -v "*) || (" $args " == *" --version "*) ]]; then
#
#            echo "Maven!"
#            if [ ! -e pom.xml ]; then
#                echo "pom.xml finnes IKKE!"
#                echo "Not running: $@"
#                return 1
#            fi
#        fi
#        "$@"
#        return
#    fi
#    echo "no param for run command!"
#}


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

find_scenarios_without_tags() {
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

find_scenarios_with_tag() {
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

xxxfind_tags() {
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

xxfind_tags() {
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

xfind_tags() {
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
check_string() {
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

find_tags() {
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
find_py_tags() {
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

run_where() {
  local cmd_path
  cmd_path=$(which "$1" 2>/dev/null || where "$1" 2>/dev/null | head -n 1)
  if [ -n "$cmd_path" ]; then
    echo "Starting: $1 from ${cmd_path}"
    "$cmd_path" "${@:2}"
  else
    echo "Command not found: $1"
  fi
}

check_pom() {
  if [ ! -f "pom.xml" ]; then
    printf "\n${ALERT} No pom.xml file found in this folder! ${NC}\n"
    return 1
  fi
}
