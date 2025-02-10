#!/usr/bin/env bats
#
# GAMBIT tests of yaml files BATS framework


load test_helper/bats-assert/load
load test_helper/bats-support/load
load "$BATS_TEST_DIRNAME"/../src/gambit


@test "FlexibleSUSY_MSSM11 benchmark point with gambit" {
  run gambit_id_ascii_files "$YAML"/FlexibleSUSY_MSSM11.yaml
  assert_success
}

@test "DarkBit_lnL_oh2 with gambit" {
  run gambit_id_ascii_files "$YAML"/DarkBit_lnL_oh2.yaml
  assert_success
}

@test "DarkBit_lnL_DD with gambit" {
  run gambit_id_ascii_files "$YAML"/DarkBit_lnL_DD.yaml
  assert_success
}

@test "DarkBit_lnL_IceCube with gambit" {
  run gambit_id_ascii_files "$YAML"/DarkBit_lnL_IceCube.yaml
  assert_success
}

@test "DarkBit_lnL_GammaRays with gambit" {
  local test=
  local yaml="$YAML"/$test.yaml
  run gambit_id_ascii_files "$YAML"/DarkBit_lnL_GammaRays.yaml
  assert_success
}

@test "ColliderBit_LEPSUSY with gambit" {
  run gambit_id_ascii_files "$YAML"/ColliderBit_LEPSUSY.yaml
  assert_success
}

@test "ColliderBit_eventloop with gambit" {
  run gambit_id_ascii_files "$YAML"/ColliderBit_eventloop.yaml
  assert_success
}

@test "DecayBit_MSSM20 with gambit" {
  run gambit_id_ascii_files "$YAML"/DecayBit_MSSM20_BATS.yaml
  assert_success
}

@test "PrecisionBit_MSSM20 with gambit" {
  run gambit_id_ascii_files "$YAML"/PrecisionBit_MSSM20_BATS.yaml
  assert_success
}

@test "Key.dat file from gambit" {
  skip "I suspect this file shoudn't be generated but skip for now"
  run gambit_id_ascii_files "$YAML"/DarkBit_lnL_oh2.yaml
  [ ! -e Key.dat ]
}

@test "ScannerBit_multinest with gambit" {
  run gambit_id_ascii_files "$YAML"/ScannerBit_multinest.yaml
  assert_success
}

@test "ScannerBit_diver with gambit" {
  run gambit_id_ascii_files "$YAML"/ScannerBit_diver.yaml
  assert_success
}

@test "DecayBit H and Z invisible decays with gambit" {
  run gambit_id_ascii_files "$YAML"/PrecisionBit_invisible_decays.yaml
  assert_success
}

@test "FlavBit Wilson coefficients with gambit" {
  run gambit_id_ascii_files "$YAML"/FlavBit_WC.yaml
  assert_success
}

@test "Axion-related capabilities and likelihoods" {
  run gambit_id_ascii_files"$YAML"/Axions.yaml
  assert_success
}