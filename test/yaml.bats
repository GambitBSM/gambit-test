#!/usr/bin/env bats
#
# GAMBIT tests of yaml files BATS framework
#
# Written by A. Fowlie

load ../src/gambit

# Echo information on teardown, if error, & remove output files if present (should not be in most cases)
teardown() {
  error "$output"
  error email = "$Test_email"
  rm -f Key.dat  # This file should never be generated
}

# BAT framework tests - make information as descriptive as possible.

@test "FlexibleSUSY_MSSM11 with gambit" {
  run gambit_id_ascii_files ./yaml/MSSM11_test.yaml
  assert_success
}

@test "DarkBit_lnL_oh2 with gambit" {
  run gambit_id_ascii_files ./yaml/DarkBit_lnL_oh2.yaml
  assert_success
}

@test "DarkBit_lnL_DD with gambit" {
  run gambit_id_ascii_files ./yaml/DarkBit_lnL_DD.yaml
  assert_success
}

@test "DarkBit_lnL_IceCube with gambit" {
  run gambit_id_ascii_files ./yaml/DarkBit_lnL_IceCube.yaml
  assert_success
}

@test "DarkBit_lnL_GammaRays with gambit" {
  local test=
  local yaml=./yaml/$test.yaml
  run gambit_id_ascii_files ./yaml/DarkBit_lnL_GammaRays.yaml
  assert_success
}

@test "ColliderBit_LEPSUSY with gambit" {
  run gambit_id_ascii_files ./yaml/ColliderBit_LEPSUSY.yaml
  assert_success
}

@test "ColliderBit_eventloop with gambit" {
  run gambit_id_ascii_files ./yaml/ColliderBit_eventloop.yaml
  assert_success
}

@test "DecayBit_MSSM20 with gambit" {
  run gambit_id_ascii_files ./yaml/DecayBit_MSSM20_BATS.yaml
  assert_success
}

@test "PrecisionBit_MSSM20 with gambit" {
  run gambit_id_ascii_files ./yaml/PrecisionBit_MSSM20_BATS.yaml
  assert_success
}

@test "Key.dat file from gambit" {
  skip "I suspect this file shoudn't be generated but skip for now"
  run gambit_id_ascii_files ./yaml/DarkBit_lnL_oh2.yaml
  [ ! -e Key.dat ]
}

@test "ScannerBit_multinest with gambit" {
  run gambit_id_ascii_files ./yaml/ScannerBit_multinest.yaml
  assert_success
}

@test "ScannerBit_diver with gambit" {
  run gambit_id_ascii_files ./yaml/ScannerBit_diver.yaml
  assert_success
}

@test "DecayBit H and Z invisible decays with gambit" {
  run gambit_id_ascii_files ./yaml/invisible_decays_H_Z.yaml
  assert_success
}

@test "FlavBit Wilson coefficients with gambit" {
  run gambit_id_ascii_files ./yaml/WC_test.yaml
  assert_success
}

@test "Axion-related capabilities and likelihoods" {
  run gambit_id_ascii_files./yaml/Axions_BATS.yaml
  assert_success
}
