# Useful bash files

After working with bash for many years you get used to having aliases for different development stuff available.

  `a4g` shows you all git aliases.

## A nice git flow:

When you have checked out a git repo and want to make some changes you can quickly come up to speed when using these aliases/functions:

  `gcob staging` - creates branch `staging` and switches to it\
  ('`gco -`' - switches always back to previous branch)\
  `gcos` - switches to the `staging` branch\

## Starting with BDD

When you add BDD to your flow these steps can be useful:
`bdd-init` will add folders for running BDD ('features' + subfolder 'steps'), ands `features/steps/steps.py` file. You must rename tile to `steps.ts` if you are using TypeScript.
