#!/usr/bin/env bats
#
# GAMBIT basic i/o tests in BATS framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.

# GAMBIT helper functions.

load funcs
load gambit

setup() {
  :
}

# Echo information on teardown, if error
teardown() {
  error "$output"
  rm -rf ./runs  # This shouldn't be neccessary
}

# BAT framework tests - make information as descriptive as possible.

@test "relative yaml imports gambit" {
  run $GAMBIT/gambit -f ./yaml/import.yaml
  [ $status = 0 ]
}

@test "nonexistent yaml using gambit" {
  run "$GAMBIT"/gambit -f no.yaml
  [ $status -ne 0 ]
}

@test "no yaml using gambit" {
  run "$GAMBIT"/gambit -f
  [ $status -ne 0 ]
}

@test "empty yaml using gambit" {
  run "$GAMBIT"/gambit -f ./yaml/empty.yaml
  [ $status -ne 0 ]
}

@test "unknown option using gambit" {
  run "$GAMBIT"/gambit --unknown
  [ $status -ne 0 ]
}

@test "no options using gambit" {
  run $GAMBIT/gambit
  [ $status = 0 ]
}

@test "runs folder from empty yaml" {
  run "$GAMBIT"/gambit -f ./yaml/empty.yaml
  [ ! -e $GAMBIT/runs ]
}

@test "local runs folder from empty yaml" {
  run "$GAMBIT"/gambit -f ./yaml/empty.yaml
  [ ! -e ./runs ]
}
