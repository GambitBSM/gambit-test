#!/bin/bash
#
# Extract email addresses from error file.
#
# Written by A. Fowlie.

# Extract email addresses from error file.
bats_fail_email() {

  local tap=$1
  email=$(grep 'email =' "$tap" | cut -c11-)
  export BATS_FAIL_EMAIL="$email"
}

