#!/usr/bin/env bats
#
# GAMBIT tests of yaml files BATS framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.

# GAMBIT helper functions.

load funcs
load gambit
load pyyaml

# Remove output files if present (shouldn't be)
setup() {
  :
}

# Echo information on teardown, if error
# Remove output files if present (should be in most cases)
teardown() {
  error "$output"
  error email = "$Test_email"
  rm -f Key.dat  # TODO: This file should never be generated
}

# BAT framework tests - make information as descriptive as possible.

@test "ScannerBit_multinest with gambit" {
  local test=ScannerBit_multinest
  local yaml=./yaml/$test.yaml
  source_yaml "$yaml"
  run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
  [ $status = 0 ]
}

@test "DarkBit_lnL_oh2 with gambit" {
  local test=DarkBit_lnL_oh2
  local yaml=./yaml/$test.yaml
  source_yaml "$yaml"
  run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
  [ $status = 0 ]
}

@test "ColliderBit_LEPSUSY with gambit" {
  local test=ColliderBit_LEPSUSY
  local yaml=./yaml/$test.yaml
  source_yaml "$yaml"
  run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
  [ $status = 0 ]
}

@test "DecayBit_MSSM20 with gambit" {
  local test=DecayBit_MSSM20_BATS
  local yaml=./yaml/$test.yaml
  source_yaml "$yaml"
  run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
  [ $status = 0 ]
}

@test "PrecisionBit_MSSM20 with gambit" {
  local test=PrecisionBit_MSSM20_BATS
  local yaml=./yaml/$test.yaml
  source_yaml "$yaml"
  run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
  [ $status = 0 ]
}

@test "Key.dat file from gambit" {
  skip "I suspect this file shoudn't be generated but skip for now"
  local test=DarkBit_lnL_oh2
  local yaml=./yaml/$test.yaml
  source_yaml "$yaml"
  run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
  [ ! -e Key.dat ]
}
