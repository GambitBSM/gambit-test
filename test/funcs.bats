#!/usr/bin/env bats
#
# Tests of helper functions in BATS framework


load test_helper/bats-assert/load
load test_helper/bats-support/load
load "$BATS_TEST_DIRNAME"/../src/gambit


@test "identical files using id_ascii_files" {
  run id_ascii_files "$DATA"/expected/id_1.dat "$DATA"/expected/id_2.dat 0. 0.
  assert_success
}

@test "differing files using id_ascii_files" {
  run id_ascii_files "$DATA"/expected/id_1.dat "$DATA"/expected/diff.dat 0. 0.
  assert_failure 1
}

@test "throw error differing files using id_ascii_files" {
  skip "This is supposed to fail - test that fails work"
  run id_ascii_files "$DATA"/expected/id_1.dat "$DATA"/expected/diff.dat 0. 0.
  assert_success
}

@test "nonexistent files using id_ascii_files" {
  run id_ascii_files no.dat "$DATA"/expected/diff.dat 0. 0.
  assert_failure 255
}

@test "special char _ * . -" {
  :
}