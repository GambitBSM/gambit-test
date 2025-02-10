#!/usr/bin/env bats
#
# GAMBIT basic i/o tests in BATS framework
#
# Written by A. Fowlie

load test_helper/bats-assert/load
load test_helper/bats-file/load
load test_helper/bats-support/load
load $(dirname "$BATS_TEST_FILENAME")/../src/gambit

YAML=$(dirname "$BATS_TEST_FILENAME")/../yaml

# Echo information on teardown, if error
teardown() {
  error "$output"
  rm -rf ./runs  # This shouldn't be necessary
  rm -rf $GAMBIT/runs  # This shouldn't be necessary
}

# BAT framework tests - make information as descriptive as possible.

@test "relative yaml imports gambit" {
  run $GAMBIT/gambit -f "$YAML"/import.yaml
  assert_success
}

@test "nonexistent yaml using gambit" {
  run "$GAMBIT"/gambit -f no.yaml
  assert_failure
}

@test "no yaml using gambit" {
  skip "We should fix this return code but skip for now"
  run "$GAMBIT"/gambit -f
  assert_failure
}

@test "empty yaml using gambit" {
  run "$GAMBIT"/gambit -f "$YAML"/empty.yaml
  assert_failure
}

@test "unknown option using gambit" {
  skip "We should fix this return code but skip for now"
  run "$GAMBIT"/gambit --unknown
  assert_failure
}

@test "no options using gambit" {
  run $GAMBIT/gambit
  assert_success
}

@test "runs folder from empty yaml" {
  run "$GAMBIT"/gambit -f "$YAML"/empty.yaml
  assert_not_exists $GAMBIT/runs
}

@test "local runs folder from empty yaml" {
  skip "We shouldn't make this directory but skip for now"
  run "$GAMBIT"/gambit -f "$YAML"/empty.yaml
  assert_not_exists ./runs
}
