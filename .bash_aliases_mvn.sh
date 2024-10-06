#!/bin/bash

printf "\t| Installing alias definitions ......${CYAN}~/bash-stuff/.bash_aliases${NC}\n"

# ----------------------
# mvn => Maven Aliases
# ----------------------


# alias wip-tag='printf "All wip tagged scenarios :\n" && run find_scenarios_with_tags wip'
alias 'bdd'='clear && run pytest -rA -m "not todo"'
alias 'bdd-ok'='clear && run pytest -rA -m ok'
alias 'bdd-nok'='clear && run pytest -rA -m "not ok"'
alias 'ok'='bdd-ok'
alias 'nok'='bdd-nok'
alias 'ok?'='bdd-ok'
alias 'wip?'='run wip'
alias ok-tag='tag ok'
alias mvn-h='run mvn help:effective-pom'
alias mvn-hs='run mvn help:effective-pom ">" temp/effective-pom.xml'
#alias mvn-h='run "mvn help:effective-pom"'
#alias mvn-hs0='run "mvn help:effective-pom -Doutput=./temp/effective-pom.xml" && printf "\n ....  saved ${CYAN}temp/effective-pom.xml${NC}\n"'
#alias mvn-hs1='run "mvn help:effective-pom -Doutput=\"./temp/effective-pom.xml\"" && printf "\n ....  saved ${CYAN}temp/effective-pom.xml${NC}\n"'
#alias mvn-hs2='run "mvn help:effective-pom -Doutput=\"./temp/effective-pom.xml\"" && printf "\n ....  saved ${CYAN}temp/effective-pom.xml${NC}\n"'

# Maven pom dependency info
alias mvn_ver:ddu='pom? && run mvn versions:display-dependency-updates'
alias mcu-d='printf "\"Maven Check Updates - Dependencies\" \n" && mvn_ver:ddu'

# Maven pom version info
alias mvn_ver:dpu='pom? && run mvn versions:display-property-updates'
alias mcu-p='printf "\"Maven Check Updates - Properties\" \n" && mvn_ver:dpu'
alias mcu-ps='printf "Saving : " && mcu-p > temp/pom-properties.txt && printf "(result in temp/pom-properties.txt)"'
alias mcu-psi='printf "Saving without [INFO]: " && mcu-p | grep -v "^\[INFO\]" > temp/pom-properties.txt && printf "\"(result in temp/pom-properties.txt)"'
alias mcu-p-s='printf "\"Maven Properties - Show\" \n" && cat temp/pom-properties.txt'
alias mcu-p-si='printf "\"Maven Properties - Show without [INFO]\" \n" && cat temp/pom-properties.txt | grep -v "^\\[INFO\\]"'

alias mcu='printf "\"Maven Check Updates\" \n> " && mcu-d && mcu-p && printf "\n(Use alias \"mcu-up\" to update outdated) \n> "'
alias mcu-up='printf "\"Maven Update versions\" \n> (Use alias \"mcu-up\" to update outdated) \n> " && mvn versions:use-latest-releases'
alias mvn_dt='run mvn dependency:tree'
alias meps='mep > temp/the-pom.xml && printf "Check temp/the-pom.xml"'
alias mdts='mdt > temp/the-pom.xml && printf "Check temp/the-pom.xml"'
alias mep='run mvn help:effective-pom'
#alias meps='run mep > temp/the-pom.xml && printf "Check temp/the-pom.xml"'
alias mci='pom? && run mvn clean install'
alias mct='pom? && run mvn clean test'
#alias mvn_='pom? && run mvn --version'
alias mvn_='run mvn --version && pom?'

#TODO bddf - create function to find context ('pyt_f' or 'cucumber_f')
#TODO bdds - create function to find context ('pyt_s' or 'cucumber_s')
