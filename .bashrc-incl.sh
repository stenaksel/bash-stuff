# In your ~/.bashrc you should use this include:
#Information about bash-stuff location (eg. $HOME/bash-stuff)
# export BASH_STUFF_PATH="$HOME/bash-stuff"
# if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
#     source $HOME/bash-stuff/.bashrc-incl.sh
# fi

printf "\n Installing \"bash-stuff\" (in .bashrc-incl.sh)\n"
if [ -e $BASH_STUFF_PATH/.bash_aliases.sh ]; then
    source $BASH_STUFF_PATH/.bash_aliases.sh
fi
if [ -e $BASH_STUFF_PATH/.bash_functions.sh ]; then
    source $BASH_STUFF_PATH/.bash_functions.sh
fi
