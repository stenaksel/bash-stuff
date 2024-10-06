# bash-stuff

After working with bash for many years you get used to having aliases for different development stuff available.
The last years I have been programming on Windows and have used "Git Bash".
(I have also configured this to be default terminal in my IDE: IntelliJ IDEA)

These are a collection of my "bash-stuff", that can be useful to others.
I would love to get feedback ... or simply a 'Hi - I have tried / I am using - "bash-stuff". :-)' 

## How to install "bash_stuff"
Clone or download the zip file from GitHub 

Edit your .bashrc file in your home directory ($HOME = ~ in bash).
Include the configuration below, and change BASH_STUFF_PATH to where you put bash_stuff. 
(I have the code in ~/code/bash-stuff directory: $HOME/code/bash-stuff)
```
# Information about bash-stuff location must be set:
export BASH_STUFF_PATH="$HOME/code/bash-stuff"  # <-- where you have downloaded "bash-stuff"
export BASH_STUFF_INCL="git, mvn, py, kt"       # <-- what focus you have for aliases to use
if [ ! -e $BASH_STUFF_PATH ]; then
    printf " WARNING! BASH_STUFF_PATH DON'T EXIST ($BASH_STUFF_PATH)"
else
    # Show the configuration:
    printf "BASH_STUFF_PATH : $BASH_STUFF_PATH\t (configured in ~.bashrc)\n"
    printf "BASH_STUFF_INCL : $BASH_STUFF_INCL\t (configured in ~.bashrc)\n"
    if [ -e $BASH_STUFF_PATH/.bashrc-incl.sh ]; then
        printf " Found .bashrc-incl.sh in BASH_STUFF_PATH ($BASH_STUFF_PATH)\n"
        # Install all "bash-stuff" 
        # The context strings in BASH_STUFF_INCL specifies aliases to include.
        # For example if it is BASH_STUFF_INCL="git, mvn" 
        # Then the two files .bash_aliases_git.sh and .bash_aliases_mvn.sh
        # will be installed.
        source $BASH_STUFF_PATH/.bashrc-incl.sh
        # HINT:
        # If you have some personal aliases you could create a file e.g. ".bash_aliases_my.sh"
        # and add 'my' to the end of list in BASH_STUFF_INCL.

        # If you think your alias(es) should be part of "bash-stuff" so everybody can use,
        # then send me the suggested addition with a pull request (or in e-mail) 
    else
        printf " WARNING! Could not find .bashrc-incl.sh in $BASH_STUFF_PATH\n"
    fi
fi

```
# Some examples of useful bash aliases & functions (from "bash_stuff")


| Command          | Aka                  | Description                                                           |
|------------------|----------------------|-----------------------------------------------------------------------|
| `hint`           | hints                | shows hints for available commands (in "bash-stuff")                  |
| `a4 <par>`       | alias-for            | shows all aliases matching param (using grep)                         |
| `a4 - <par>`     | not alias-for        | shows all aliases not matching param (--invert-match)                 |
| --> `a4 git`     |                      | shows all aliases matching `git`                                      |
| --> `a4 mvn`     |                      | shows all aliases matching `mvn`                                      |
| --> `a4 - git`   |                      | shows all `non git` aliases (aliases not matching `git`)              |
| --> `a4 git log` |                      | shows all aliases matching `git log`                                  |
| --> `a4 commit`  |                      | shows all aliases matching `commit`                                   |
| `a4g`            | -> `a4 git`          | shows all `git` aliases (aliases matching `git`)                      |
| `a4g-`           | -> `a4 - git`        | shows all `non git` aliases (aliases not matching `git`)              |
| `a4m`            | -> `a4 mvn`          | shows all `mvn` aliases (aliases matching `mvn`)                      |
| `iop`            | -> `info-on-project` | shows information on project (in folder)                              |
| `bdd-init`       |                      | Setup for running **BDD** (ads `features` folder + subfolder `steps`) |
| `bdd`   	        |                      | Run **BDD** tests - running all tests (in `features`)                 |
| `wip`            |                      | Run **BDD** tests tagged with **@wip** _(work-in-progress)_           |
| `mvnc`           |                      | Open **Maven Central Repository** (in browser)                        |
| `mvn-h`          |                      | Maven Effective POM (mvn help:effective-pom)                          |
| `mvn-hs`         |                      | Maven Effective POM saved (to `./temp/effective-pom.xml`)             |
| `mcu-d`          |                      | Maven Check Updates - _Dependencies_                                  |
| `mcu-p`          |                      | Maven Check Updates - _Properties_                                    |
| `venv`           |                      | Show info about configured virtual environment _(in shell)_           |
| `bup`            |                      | Bash Update (`source ~/.bashrc`)                                      |
| `code`           |                      | Open your favourite editor                                            |
| `ll`             | ls -lh               | Show content of folder                                                |
| `lla`            | ls -lh -a            | Show content of folder _including hidden_                             |

# Other useful bash/linux commands

| Command                     | Description                                     |
|-----------------------------|-------------------------------------------------|
| `env`                       | Show all environment variables                  |
| `find`                      | Find files                                      |
| --> `find ~ -name "me.txt"` | Find the `me.txt` in or below "home" (~)        |
| `which`                     | Display the Path of Any Executable File         |
| -> `which py`               | Locate program `py`                             |
| -> `which -a py`            | Display Multiple Paths of Executable Files `py` |

## A nice git flow

When you have checked out a git repo and want to make some changes you can quickly come up to speed when using these aliases/functions:
(Here `feature/next` is just an example for a new branch name)
`gcob feature/next` (=> `git checkout -b feature/next`) - creates branch `feature/next` and switches to it.

Hint:
Don't reuse a already used branch (for example `next`).
Delete it or rename to e.g. `keep` (`git branch -m new-branch-name`) 
and then create a new one => `gcob next` for each "new/next development"

After working in another branch
`gcos` - switches to the prevoius branch\
`gco -`' - always switches back to your *previous branch*

## Starting with BDD

When you add BDD to your flow these steps can be useful:\
`bdd-init` will add things for running BDD \
It creates '**features**' folder + it's subfolder '**steps**' and also an initial file to implement the *glue-code* ie. step definitions). \
<!-- TODO: find correct file extension context based on project-type (or param to bdd-init) \ -->
<!-- TODO: If django involved in python project, put things under tests folder. run bbd with behave-django (manage.py behave) -->
Default glue-code file is `steps.py`. Just rename file to `steps.ts` if you are using TypeScript.

Happy BDD :smile: !
