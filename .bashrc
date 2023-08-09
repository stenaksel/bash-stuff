# .bashrc: example:
# =================

# virtualenvwrapper.sh config
export PIP_REQUIRE_VIRTUALENV=true    # Don't allow pip installs without a virtual environment
export WORKON_HOME=$HOME/.virtualenvs # Needed by virtualenvwrapper.sh
source $HOME/AppData/Local/Programs/Python/Python311/Scripts/virtualenvwrapper.sh
printf "Adding some nice aliases and functions from 'bash-stuff'\n"
# Add "bash-stuff"
if [ -e $HOME/bash-stuff/.bashrc-incl.sh ]; then
    source $HOME/bash-stuff/.bashrc-incl.sh
fi
# virtualenvwrapper.sh "in action"
echo ".bashrc: setting up virtualenvwrapper\n"
. virtualenvwrapper.sh

# "bash-stuff" fix:
maybe-call-workon
