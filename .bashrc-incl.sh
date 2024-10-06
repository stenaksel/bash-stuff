# In your ~/.bashrc you should use this include:
ESC='\033'
FG_RED=31
BG_RED=41
FG_CYAN=36
CYAN="${ESC}[${FG_CYAN}m"
RED="${ESC}[${FG_RED}m"
ALERT="${ESC}[${BG_RED}m"
NC="${ESC}[0m" # No Color

# Example: Check variable BASH_STUFF_INCL
printf "\n Installing \"bash-stuff\" (in .bashrc-incl.sh)\n"
if [ -z "${BASH_STUFF_INCL}" ]; then
  printf "  ${ALERT}   Aborting \".bashrc-incl.sh\" !                                                    ${NC}\n"
  printf "  ${ALERT}   Expected to find environment variable named \"BASH_STUFF_INCL\"!                  ${NC}\n"
  printf "  ${ALERT}   It is either not set or it just contain an empty string!                          ${NC}\n"
  printf "  ${ALERT}   \"BASH_STUFF_INCL\" should contain a comma separated list of \"context strings\". ${NC}\n"
  printf "  ${ALERT}   You can e.g. include the  ${NC}\n"
  return 1
else
  printf "${CYAN} BASH_STUFF_INCL contains: \"${BASH_STUFF_INCL}\"!${NC}\n"
  # Place further logic here
fi

# Save the current IFS value (IFS = Internal Field Separator)
OLD_IFS=$IFS

# Temporarily set IFS to a comma, so we can read the context string in BASH_STUFF_INCL
IFS=','

# Convert the comma-separated string into an array
read -ra envVarArray <<< "$BASH_STUFF_INCL"

# Reset IFS to its original value
IFS=$OLD_IFS

# Create an array to hold trimmed envVarArray elements aka envVarElement
contextArray=()

# Trim each element and store it in the new contextArray
for envVarElement in "${envVarArray[@]}"; do
  # Trim leading and trailing spaces in wish string using xargs
  context=$(echo "$envVarElement" | xargs)
  contextArray+=("$context")
done

# Print each string in the contextArray
#printf "After trimming:\n"
#for context in "${contextArray[@]}"; do
#  echo "[$context]"
#done

printf " Installing \"bash-stuff\" from files:\n"
# Print the envVarArray right aligned
for context in "${contextArray[@]}"; do
  printf "[$context]:"

  fileName=".bash_aliases_$context.sh"
#  echo "$fileName"
  printf "\t $fileName \n"
  fullName="$BASH_STUFF_PATH/$fileName"
  printf "\t $fullName \n"
  if [ -f "$fullName" ]; then
#    echo "(Found $fileName)"
    source $fullName
  else
    echo "${ALERT} $fileName was NOT found!"
  fi
done
  printf "(all done in .bashrc-incl.sh)\n\n"

# Other aliases
if [ -e $BASH_STUFF_PATH/.bash_aliases.sh ]; then
    source $BASH_STUFF_PATH/.bash_aliases.sh
fi
# All functions
if [ -e $BASH_STUFF_PATH/.bash_functions.sh ]; then
    source $BASH_STUFF_PATH/.bash_functions.sh
fi

#alias