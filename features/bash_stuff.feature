Feature: Bash Stuff
  Some bash aliases and functions usable when programming and focused on a BDD process.
  (collected by Sten Aksel Heien)
  @wip
  Scenario: With tag
    Given bash_stuff installed and working
    When I issue the "hint" command
    Then I get hints for available commands

  @wip @todo
  Scenario: Both wip and todo tags
    Given bash_stuff installed and working
    When I issue the "hint" command
    Then I get hints for available commands

  Scenario: No tags
    Given bash_stuff installed and working
    When I issue the "hint" command
    Then I get hints for available commands
