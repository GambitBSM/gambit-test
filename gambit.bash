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
  
  # Safely delete an existing gambit result

  if [ -n "$gambit_result" ] && [ -f "$gambit_result" ] && [ -n "$(find ./data_gambit -wholename "$gambit_result")" ]; then
    rm -f "$gambit_result"
  fi
        
  "$GAMBIT"/gambit -rf "$yaml"
  
  id_ascii_files "$gambit_result" "$gambit_expected" "$rtol"
}
