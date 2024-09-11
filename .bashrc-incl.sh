# In your ~/.bashrc you should use this include:
#Information about bash-stuff location (eg. $HOME/bash-stuff)
# export BASH_STUFF_PATH="$HOME/bash-stuff"
# if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
#     source $HOME/bash-stuff/.bashrc-incl.sh
# fi
ESC='\033'
FG_RED=31
BG_RED=41
FG_CYAN=36
CYAN="${ESC}[${FG_CYAN}m"
RED="${ESC}[${FG_RED}m"
ALERT="${ESC}[${BG_RED}m"
NC="${ESC}[0m" # No Color

printf "\n Installing \"bash-stuff\" (in .bashrc-incl.sh)\n"
if [ -e $BASH_STUFF_PATH/.bash_aliases.sh ]; then
    source $BASH_STUFF_PATH/.bash_aliases.sh
fi
if [ -e $BASH_STUFF_PATH/.bash_functions.sh ]; then
    source $BASH_STUFF_PATH/.bash_functions.sh
fi
# Add aliases and functions we would like to have
#TODO: Split file, use includes... create one file for each language (& OS?)
if [ -e $BASH_STUFF_PATH/.bash_win.sh ]; then
    source $BASH_STUFF_PATH/.bash_win.sh
fi
if [ -e $BASH_STUFF_PATH/.bash_linux.sh ]; then
    source $BASH_STUFF_PATH/.bash_linux.sh
fi
if [ -e $BASH_STUFF_PATH/.bash_mvn.sh ]; then
    source $BASH_STUFF_PATH/.bash_mvn.sh
fi
if [ -e $BASH_STUFF_PATH/.bash_kt.sh ]; then
    source $BASH_STUFF_PATH/.bash_kt.sh
fi
if [ -e $BASH_STUFF_PATH/.bash_py.sh ]; then
    source $BASH_STUFF_PATH/.bash_py.sh
fi