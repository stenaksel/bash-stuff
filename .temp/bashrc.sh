# .bashrc: example:
# =================
# ~/.bashrc: executed by bash for non-login shells.
# ==== Python focused "stuff" 1-start: ====

export VENV_HOME=$HOME/AppData/Local/Programs/Python/Python311/Scripts # local machine related
# virtualenvwrapper.sh config
export PIP_REQUIRE_VIRTUALENV=true # Don't allow pip installs without a virtual environment
export WORKON_HOME=$HOME/.virtualenvs # Needed by virtualenvwrapper.sh

printf "HOME         $HOME\n"
printf "VENV_HOME    $VENV_HOME\n"
printf "WORKON_HOME  $WORKON_HOME\n"

# "bash-stuff"
# if [ ! -e $VENV_HOME/virtualenvwrapper.sh ]; then
#     printf "\nUnable to find 'virtualenvwrapper.sh' needed for setting up a virtual environment!\n"
#     printf "You need to install virtualenvwrapper with pip!\n"
# else
#     printf "Found virtualenvwrapper.sh!\n"
# fi

# source $VENV_HOME/virtualenvwrapper.sh # set up for using virtualenvwrapper for virtual environments

# if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
#     source $HOME/bash-stuff/.bashrc-incl.sh
# fi

================

# ~/.bashrc: executed by bash for non-login shells.
export VENV_HOME=$HOME/AppData/Local/Programs/Python/Python311/Scripts # local machine related
# virtualenvwrapper.sh config
export PIP_REQUIRE_VIRTUALENV=true # Don't allow pip installs without a virtual environment
export WORKON_HOME=$HOME/.virtualenvs # Needed by virtualenvwrapper.sh

printf "HOME         $HOME\n"
printf "VENV_HOME    $VENV_HOME\n"
printf "WORKON_HOME  $WORKON_HOME\n"

# virtualenvwrapper.sh config
export PIP_REQUIRE_VIRTUALENV=true    # Don't allow pip installs without a virtual environment
export WORKON_HOME=$HOME/.virtualenvs # Needed by virtualenvwrapper.sh
source $HOME/AppData/Local/Programs/Python/Python311/Scripts/virtualenvwrapper.sh

# ==== Python focused "stuff" 1-end! ====

printf "Adding some nice aliases and functions from 'bash-stuff'\n"
# Add "bash-stuff": aliases and functions
if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
    source $HOME/bash-stuff/.bashrc-incl.sh
fi

# ==== Python focused "stuff" 2-start: ====
# check-venv-settings #

if [ ! -e $VENV_HOME/virtualenvwrapper.sh ]; then
    printf "\nUnable to find 'virtualenvwrapper.sh' needed for setting up a virtual environment!\n"
    printf "You need to install virtualenvwrapper with pip!\n"
else
    printf "\nFound virtualenvwrapper.sh!\n"
fi

# virtualenvwrapper.sh "in action"
echo ".bashrc: setting up virtualenvwrapper for virtual environments\n"
. virtualenvwrapper.sh

# "bash-stuff" for starting the virtual environment:
maybe-call-workon
# ==== Python focused "stuff" 2-end! ====

