# Useful bash aliases

After working with bash for many years you get used to having aliases for different development stuff available.

  `a4g` shows you all git aliases.

## A nice git flow:

When you have checked out a git repo and want to make some changes you can quickly come up to speed when using these aliases/functions:

  `gcob staging` (=> `git checkout -b staging`) - creates branch `staging` and switches to it\
  ('`gco -`' - switches always back to *previous branch*)\

  `gcos` - switches to the `staging` branch\

## Starting with BDD

When you add BDD to your flow these steps can be useful:\
`bdd-init` will add things for running BDD \
It creates '**features**' folder + it's subfolder '**steps**' and also an initial file to implement the _glue-code_ ie. step definitions). \
<!-- TODO: find correct file extension context based on project-type (or param to bdd-init) \ -->
<!-- TODO: If django involved in python project, put things under tests folder. run bbd with behave-django (manage.py behave) -->
Default glue-code file is `steps.py`. Just rename file to `steps.ts` if you are using TypeScript.

Happy BDD :smile: !
