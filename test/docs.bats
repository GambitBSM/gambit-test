#!/usr/bin/env bats
#
# Tests of docs in BATS framework
#
# Written by A. Fowlie

load ../src/gambit

# Echo information on teardown, if error
teardown() {
  error "$output"
}

@test "check for capabilities that are missing in docs" {
  run python docs.py capabilities missing
  assert_success
}

@test "check for models that are missing missing in docs" {
  run python docs.py models missing
  assert_success
}

@test "check for capabilities that are duplicated in docs" {
  run python docs.py capabilities duplicates
  assert_success
}

@test "check for models that are duplicated in docs" {
  run python docs.py models duplicates
  assert_success
}

@test "check for capabilities that are extra in docs" {
  run python docs.py capabilities extra
  assert_success
}

@test "check for models that are extra in docs" {
  run python docs.py models extra
  assert_success
}
