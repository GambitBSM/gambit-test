#!/bin/bash
#
# Read a yaml file in bash - https://gist.github.com/pkuczynski/8665367
#
# Written by A. Fowlie.

# Parse a yaml file into bash X = ... commands
parse_yaml() {

  local yaml=$1
  
  local s='[[:space:]]*'
  local w='[a-zA-Z0-9_]*'
  local fs=$(echo @|tr @ '\034')
  
  sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
      -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$yaml" |
  awk -F"$fs" '{
    indent = length($1)/2;
    vname[indent] = $2;
    for (i in vname) {if (i > indent) {delete vname[i]}}
    if (length($3) > 0) {
       vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
       printf("%s%s=\"%s\"\n", vn, $2, $3);
    }
  }' |
  sed 's/#.*/"/' |  # Remove comments
  sed 's/[[:blank:]]//g'  # Remove blank spaces
}

# Evaluate yaml file parsed in to X = ... commands
source_yaml() {
  local yaml=$1
  eval "$(parse_yaml "$yaml")"
}
