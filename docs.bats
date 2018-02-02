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

@test "check for capabilities that are missing in docs" {
  run python docs.py capabilities missing
  [ $status = 0 ]
}

@test "check for models that are missing missing in docs" {
  run python docs.py models missing
  [ $status = 0 ]
}

@test "check for capabilities that are duplicated in docs" {
  run python docs.py capabilities duplicates
  [ $status = 0 ]
}

@test "check for models that are duplicated in docs" {
  run python docs.py models duplicates
  [ $status = 0 ]
}

@test "check for capabilities that are extra in docs" {
  run python docs.py capabilities extra
  [ $status = 0 ]
}

@test "check for models that are extra in docs" {
  run python docs.py models extra
  [ $status = 0 ]
}
