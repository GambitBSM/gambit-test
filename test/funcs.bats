#!/usr/bin/env bats
#
# Tests of helper functions in BATS framework
#
# Written by A. Fowlie

load ../src/gambit

# Echo information on teardown, if error
teardown() {
  error "$output"
}

# BAT framework tests - make information as descriptive as possible.

@test "identical files using id_ascii_files" {
  run id_ascii_files ./data_expected/id_1.dat ./data_expected/id_2.dat 0. 0.
  assert_success
}

@test "differing files using id_ascii_files" {
  run id_ascii_files ./data_expected/id_1.dat ./data_expected/diff.dat 0. 0.
  assert_failure 1
}

@test "throw error differing files using id_ascii_files" {
  skip "This is supposed to fail - test that fails work"
  run id_ascii_files ./data_expected/id_1.dat ./data_expected/diff.dat 0. 0.
  assert_success
}

@test "nonexistent files using id_ascii_files" {
  run id_ascii_files no.dat ./data_expected/diff.dat 0. 0.
  assert_failure 255
}

@test "special char _ * . -" {
  :
}
