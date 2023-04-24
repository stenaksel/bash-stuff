# ~/.bashrc: executed by bash for non-login shells.
export PIP_REQUIRE_VIRTUALENV=true
if [ -e $HOME/bash-stuff/.bash_aliases ]; then
    source $HOME/bash-stuff/.bash_aliases
fi
if [ -e $HOME/bash-stuff/.bash_functions ]; then
    source $HOME/bash-stuff/.bash_functions
fi
echo "sah: .bashrc calling virtualenvwrapper.sh "
. virtualenvwrapper.sh
