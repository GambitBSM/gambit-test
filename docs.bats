#!/usr/bin/env bats
#
# Tests of docs in BATS framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.

load funcs

setup() {
  :
}

# Echo information on teardown, if error
teardown() {
  error "$output"
}

@test "check for capabilities that are missing descriptions" {
  run python docs.py capabilities
  [ $status = 0 ]
}

@test "check for models that are missing descriptions" {
  run python docs.py models
  [ $status = 0 ]
}

