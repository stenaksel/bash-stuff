# Useful bash aliases & functions (from "bash_stuff")

After working with bash for many years you get used to having aliases for different development stuff available.

  | Command     | Aka   | Description |
  | -------     | ---   | ----------- |
  | `hint`      | hints | shows hints for available commands (in "bash-stuff") |
  | `a4 <par>`  | alias-for | shows all aliases matching param (using grep) |
  | `a4 - <par>`| not alias-for | shows all aliases not matching param (--invert-match)|
  | --> `a4 git`| | shows all aliases matching `git` |
  | --> `a4 - git`| | shows all `non git` aliases (aliases not matching `git`) |
  | --> `a4 git log`| | shows all aliases matching `git log` |
  | --> `a4 commit`| | shows all aliases matching `commit` |
  | `a4g`       | -> `a4 git` | shows all `git` aliases (aliases matching `git`) |
  | `a4g-`      | -> `a4 - git` | shows all `non git` aliases (aliases not matching `git`) |
  | `iop`       | -> `info-on-project` | shows information on project (in folder) |
  | `bdd-init`  | | Setup for running **BDD** (ads `features` folder + subfolder `steps`) |
  | `bdd`  	    | | Run **BDD** test - running tests (in `features`) |
  | `wip`       | | Run **BDD** tests tagged with **@wip** _(work-in-progress)_|
  | `venv`      | | Show info about configured _virtual environment (in shell)_ |
}

# Other useful bash/linux commands

  | Command       | Description |
  | -------       | ----------- |
  | `env`         | Show all environment variables |
  | `ll`          | Show content of folder |
  | -> `ll -a`    | Show content of folder _including hidden_ |
  | `find`        | Find files |
  | --> `find ~ -name "me.txt"` | Find the `me.txt` in or below "home" (~) |
  | `which` | Display the Path of Any Executable File |
  | -> `which py` | Locate program `py`|
  | -> `which -a py` | Display Multiple Paths of Executable Files `py`|


## A nice git flow

When you have checked out a git repo and want to make some changes you can quickly come up to speed when using these aliases/functions:

  `gcob staging` (=> `git checkout -b staging`) - creates branch `staging` and switches to it\

Hint:
  Don't reuse a already used `staging` branch.
  Delete it (or rename to keep) and create a new => `gcob staging` for each "new development"
After working in another branch
  `gcos` - switches to the `staging` branch\
  `gco -`' - always switches back to your *previous branch*

## Starting with BDD

When you add BDD to your flow these steps can be useful:\
`bdd-init` will add things for running BDD \
It creates '**features**' folder + it's subfolder '**steps**' and also an initial file to implement the *glue-code* ie. step definitions). \
<!-- TODO: find correct file extension context based on project-type (or param to bdd-init) \ -->
<!-- TODO: If django involved in python project, put things under tests folder. run bbd with behave-django (manage.py behave) -->
Default glue-code file is `steps.py`. Just rename file to `steps.ts` if you are using TypeScript.

Happy BDD :smile: !
