# In your ~/.bashrc you should use this include:
# if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
#     source $HOME/bash-stuff/.bashrc-incl.sh
# fi

# export PIP_REQUIRE_VIRTUALENV=true # Don't allow pip installs without a virtual environment
# echo ".bashrc: calling virtualenvwrapper.sh "
# . virtualenvwrapper.sh
printf ".bashrc-incl.sh  ... (Installing \"bash-stuff\")\n"
if [ -e $HOME/bash-stuff/.bash_aliases ]; then
    # echo ".bashrc: source bash-stuff/.bash_aliases "
    source $HOME/bash-stuff/.bash_aliases
fi
if [ -e $HOME/bash-stuff/.bash_functions ]; then
    # echo ".bashrc: source bash-stuff/.bash_functions "
    source $HOME/bash-stuff/.bash_functions
fi

# echo "Got $# param(s)"
# if [ "true" == "true" ]; then
#     printf "\nCalling workon .\n"

#     local _lang='-?-'
#     _lang=$(detect_language | tail -1)
#     if [[ "$_lang" == *"Python"* ]]; then
#         # if [[ "$_lang" != *"Sorry"* ]]; then
#         echo "Found language is probably: $_lang"
#         printf "\n> workon .\n"
#         workon .
#     fi

# fi
# venv
