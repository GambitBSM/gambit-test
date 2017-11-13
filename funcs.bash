#!/bin/bash
#
# Helper functions for GAMBIT tests in BATS framework.
#
# Written by A. Fowlie.

# Echo message to stderr.
error() {
  echo -e "$*" 1>&2 
}

# Check for numerical differences between files. 
id_ascii_files() {

  local file_1=$1
  local file_2=$2
  local rtol=$3

  numdiff -r "$rtol" "$file_1" "$file_2"
}

