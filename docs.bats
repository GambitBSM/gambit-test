#!/usr/bin/env bats
#
# Tests of docs in BATS framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.


@test "Check for capabilities that are missing descriptions" {
  python docs.py
  [ $status = 0 ]
}

