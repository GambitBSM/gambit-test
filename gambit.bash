#!/bin/bash
#
# GAMBIT functions for tests in BATS framework.
#
# Written by A. Fowlie

# Test a ./gambit -f call against expected ascii output.
gambit_id_ascii_files() {

  local yaml=$1
  local gambit_result=$2
  local gambit_expected=$3
  local rtol=$4
  local atol=$5
  
  # Safely delete an existing GAMBIT result file

  if [ -n "$gambit_result" ] && [ -f "$gambit_result" ] && [ -n "$(find ./data_gambit -wholename "$gambit_result")" ]; then
    rm -f "$gambit_result"
  fi
  
  # Call GAMBIT
        
  "$GAMBIT"/gambit -rf "$yaml"
  
  # Print information about GAMBIT result file
  
  local gambit_info="$gambit_result"_info
  
  if [ -f "$gambit_info" ]; then
    cat "$gambit_info"
  fi
  
  # Check GAMBIT result file against expected file
  
  id_ascii_files "$gambit_result" "$gambit_expected" "$rtol" "$atol"
}
