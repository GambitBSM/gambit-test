#!/usr/bin/env bats
#
# Tests of standalones in bats framework
#
# Written by A. Fowlie

load test_helper/bats-assert/load
load test_helper/bats-support/load
load $(dirname "$BATS_TEST_FILENAME")/../src/gambit

DATA=$(dirname "$BATS_TEST_FILENAME")/../data

# Echo information on teardown, if error
teardown() {
  error "$output"
  rm -rf runs
}

@test "build DarkBit_standalone_WIMP" {
  cd "$GAMBIT"/build
  run make DarkBit_standalone_WIMP
  assert_success
}

@test "build DarkBit_standalone_MSSM" {
  cd "$GAMBIT"/build
  run make DarkBit_standalone_MSSM
  assert_success
}

DATA_1705_07920="$GAMBIT"/DarkBit/data/benchmarks

@test "DarkBit_standalone_MSSM_1705.07920_Model_1" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/HA_funnel_gaugino.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_1.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_1.txt "$DATA"/expected/1705.07920_Model_1.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_2" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/HA_funnel_mixed.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_2.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_2.txt "$DATA"/expected/1705.07920_Model_2.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_3" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/HA_funnel_higgsino.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_3.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_3.txt "$DATA"/expected/1705.07920_Model_3.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_4" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/hZ_funnel.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_4.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_4.txt "$DATA"/expected/1705.07920_Model_4.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_5" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/stau_coannihilation.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_5.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_5.txt "$DATA"/expected/1705.07920_Model_5.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_6" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/stop_coannihilation_gaugino.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_6.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_6.txt "$DATA"/expected/1705.07920_Model_6.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_7" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/stop_coannihilation_mixed.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_7.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_7.txt "$DATA"/expected/1705.07920_Model_7.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_8" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/stop_coannihilation_higgsino.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_8.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_8.txt "$DATA"/expected/1705.07920_Model_8.txt 0.01 0.01
  assert_success
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_9" {
  "$GAMBIT"/DarkBit_standalone_MSSM "$DATA_1705_07920"/chargino_coannihilation.slha2 | tail -n15 > "$DATA"/run/1705.07920_Model_9.txt
  run id_ascii_files "$DATA"/run/1705.07920_Model_9.txt "$DATA"/expected/1705.07920_Model_9.txt 0.01 0.01
  assert_success
}