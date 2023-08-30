# In your ~/.bashrc you should use this include:
# if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
#     source $HOME/bash-stuff/.bashrc-incl.sh
# fi

printf ".bashrc-incl.sh  ... (Installing \"bash-stuff\")\n"
if [ -e $HOME/bash-stuff/.bash_aliases ]; then
    # echo ".bashrc: source bash-stuff/.bash_aliases "
    source $HOME/bash-stuff/.bash_aliases
fi
if [ -e $HOME/bash-stuff/.bash_functions ]; then
    # echo ".bashrc: source bash-stuff/.bash_functions "
    source $HOME/bash-stuff/.bash_functions
fi
