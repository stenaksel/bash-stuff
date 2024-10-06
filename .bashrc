# .bashrc: example:
# =================
# ~/.bashrc: executed by bash for non-login shells.
export HISTCONTROL=ignorespace:ignoredups
export VENV_HOME=$HOME/AppData/Local/Programs/Python/Python311/Scripts # local machine related
# virtualenvwrapper.sh config
export PIP_REQUIRE_VIRTUALENV=true    # Don't allow pip installs without a virtual environment
export WORKON_HOME=$HOME/.virtualenvs # Needed by virtualenvwrapper.sh
printf "HOME         $HOME\n"
printf "VENV_HOME    $VENV_HOME\n"
printf "WORKON_HOME  $WORKON_HOME\n"

# "bash-stuff"
# check-venv-settings #
if [ ! -e $VENV_HOME/virtualenvwrapper.sh ]; then
    printf "\nUnable to find 'virtualenvwrapper.sh' needed for setting up a virtual environment!\n"
    printf "You need to install virtualenvwrapper with pip!\n"
else
    printf "Found virtualenvwrapper.sh!\n"
fi

# source $VENV_HOME/virtualenvwrapper.sh # set up for using virtualenvwrapper for virtual environments
echo 'HEI'

if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
    echo 'skipping .bashrc-incl.sh'
#     source $HOME/bash-stuff/.bashrc-incl.sh
fi

# "bash-stuff" for starting the virtual environment:
maybe-call-workon # (Maybe activate Python virtual environment)
