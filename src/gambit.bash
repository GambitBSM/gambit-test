#!/bin/bash
#
# GAMBIT functions for tests in BATS framework
#
# Written by A. Fowlie

# Echo message to stderr
error() {
  echo -e "$*" 1>&2 
}

# Check for numerical differences between files
id_ascii_files() {

  local file_1=$1
  local file_2=$2
  local rtol=$3
  local atol=$4

  numdiff --strict -r "$rtol" -a "$atol" "$file_1" "$file_2"
}

# Source YAML file into bash
source_yaml() {
  local yaml=$1
  eval "$(python yaml_bash.py "$yaml")"
}

# Test a ./gambit -f call against expected ascii output
gambit_id_ascii_files() {

  local yaml=$1
  

  # Safely delete an existing GAMBIT result file

  if [ -n "$Test_gambita" ] && [ -f "$Test_gambit" ] && [ -n "$(find ./data_gambit -wholename "$Test_gambit")" ]; then
    rm -f "$Test_gambit"
  fi
  
  # Call GAMBIT
        
  "$GAMBIT"/gambit -rf "$yaml"
  
  # Print information about GAMBIT result file
  
  local gambit_info="$Test_gambit"_info
  
  if [ -f "$gambit_info" ]; then
    cat "$gambit_info"
  fi
  
  # Check GAMBIT result file against expected file
  
  numdiff --strict -r "$Test_rtol" -a "$Test_atol" "$Test_gambit" "$Test_expected"
}
