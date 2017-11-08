#!/usr/bin/env bats
#
# Tests of helper functions in BATS framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.

# GAMBIT helper functions to be tested.
load funcs

setup() {
  :
}

# Echo information on teardown, if error
teardown() {
  error "$output"
}

# BAT framework tests - make information as descriptive as possible.

@test "identical files using id_ascii_files" {
  run id_ascii_files ./data_expected/id_1.dat ./data_expected/id_2.dat 0.
  [ $status = 0 ]
}

@test "differing files using id_ascii_files" {
  run id_ascii_files ./data_expected/id_1.dat ./data_expected/diff.dat 0.
  [ $status = 1 ]
}

@test "throw error differing files using id_ascii_files" {
  run id_ascii_files ./data_expected/id_1.dat ./data_expected/diff.dat 0.
  [ $status = 0 ]
}

@test "nonexistent files using id_ascii_files" {
  run id_ascii_files no.dat ./data_expected/diff.dat 0.
  [ $status = 255 ]
}

@test "special char _ * . -" {
  :
}
