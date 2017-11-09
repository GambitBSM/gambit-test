#!/bin/bash
#
# Read a yaml file in bash via Python
#
# Written by A. Fowlie.

# Parse a yaml file into bash X = ... commands
parse_yaml() {
  local yaml=$1
  python yaml_bash.py "$yaml"
}

# Evaluate yaml file parsed in to X = ... commands
source_yaml() {
  local yaml=$1
  eval "$(parse_yaml "$yaml")"
}
