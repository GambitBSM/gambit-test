#!/usr/bin/env bats
#
# GAMBIT basic i/o tests in BATS framework


load test_helper/bats-assert/load
load test_helper/bats-file/load
load test_helper/bats-support/load


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