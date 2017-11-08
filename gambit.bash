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
  
  rm -f "$gambit_result"  # Insure that we generate new output from GAMBIT.
  "$GAMBIT"/gambit -rf "$yaml"
  
  id_ascii_files "$gambit_result" "$gambit_expected" "$rtol"
}
