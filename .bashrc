# ~/.bashrc: executed by bash for non-login shells.
export PIP_REQUIRE_VIRTUALENV=true
if [ -e $HOME/bash-stuff/.bash_aliases ]; then
    echo ".bashrc calling bash-stuff/.bash_aliases "
    source $HOME/bash-stuff/.bash_aliases
fi
if [ -e $HOME/bash-stuff/.bash_functions ]; then
    echo ".bashrc calling bash-stuff/.bash_functions "
    source $HOME/bash-stuff/.bash_functions
fi
echo ".bashrc calling virtualenvwrapper.sh "
. virtualenvwrapper.sh
