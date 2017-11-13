#!/bin/bash
#
# Extract email addresses from error file.
#
# Written by A. Fowlie.

# Extract email addresses from error file.
bats_fail_email() {

  local tap=$1
  grep 'email =' "$tap" | cut -c11-
}

git_fail_email() {

  local git=$1
  (
  cd "$git"
  git log --format='%ae' -n 1
  )
}
