#!/usr/bin/env bats
#
# Tests of standalones in bats framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.

load funcs

setup() {
  rm -f SM_Z
  rm -f MSSM_H
  rm -f MSSM_Z
}

# Echo information on teardown, if error
teardown() {
  error "$output"
  rm -rf runs
}

@test "build DarkBit_standalone_WIMP" {
  cd "$GAMBIT"/build
  run make DarkBit_standalone_WIMP
  [ $status = 0 ]
}

@test "build DarkBit_standalone_MSSM" {
  cd "$GAMBIT"/build
  run make DarkBit_standalone_MSSM
  [ $status = 0 ]
}

@test "DarkBit_standalone_WIMP in mode 7" {
  skip 'not maintained and broken by changes to standalone output'
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_WIMP 7
  )
  cat "$GAMBIT"/LUX_2016_SD_table.dat \
      "$GAMBIT"/LUX_2016_SI_table.dat \
      "$GAMBIT"/PandaX_2017_SD_table.dat \
      "$GAMBIT"/PandaX_2017_SI_table.dat \
      "$GAMBIT"/PICO_60_2017_SD_table.dat \
      "$GAMBIT"/PICO_60_2017_SI_table.dat \
      "$GAMBIT"/XENON1T_2017_SD_table.dat \
      "$GAMBIT"/XENON1T_2017_SI_table.dat > data_gambit/DarkBit_standalone_WIMP_7.dat

  rm -f "$GAMBIT"/LUX_2016_SD_table.dat \
        "$GAMBIT"/LUX_2016_SI_table.dat \
        "$GAMBIT"/PandaX_2017_SD_table.dat \
        "$GAMBIT"/PandaX_2017_SI_table.dat \
        "$GAMBIT"/PICO_60_2017_SD_table.dat \
        "$GAMBIT"/PICO_60_2017_SI_table.dat \
        "$GAMBIT"/XENON1T_2017_SD_table.dat \
        "$GAMBIT"/XENON1T_2017_SI_table.dat

  run id_ascii_files data_gambit/DarkBit_standalone_WIMP_7.dat data_expected/DarkBit_standalone_WIMP_7.dat 0.01 0.01
  [ $status = 0 ]
}

DATA_1705_07920="$GAMBIT"/DarkBit/data/benchmarks

@test "DarkBit_standalone_MSSM_1705.07920_Model_1" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/HA_funnel_gaugino.slha2 > data_gambit/1705.07920_Model_1.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_1.txt data_expected/1705.07920_Model_1.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_2" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/HA_funnel_mixed.slha2 > data_gambit/1705.07920_Model_2.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_2.txt data_expected/1705.07920_Model_2.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_3" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/HA_funnel_higgsino.slha2 > data_gambit/1705.07920_Model_3.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_3.txt data_expected/1705.07920_Model_3.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_4" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/hZ_funnel.slha2 > data_gambit/1705.07920_Model_4.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_4.txt data_expected/1705.07920_Model_4.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_5" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/stau_coannihilation.slha2 > data_gambit/1705.07920_Model_5.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_5.txt data_expected/1705.07920_Model_5.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_6" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/stop_coannihilation_gaugino.slha2 > data_gambit/1705.07920_Model_6.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_6.txt data_expected/1705.07920_Model_6.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_7" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/stop_coannihilation_mixed.slha2 > data_gambit/1705.07920_Model_7.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_7.txt data_expected/1705.07920_Model_7.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_8" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/stop_coannihilation_higgsino.slha2 > data_gambit/1705.07920_Model_8.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_8.txt data_expected/1705.07920_Model_8.txt 0.01 0.01
  [ $status = 0 ]
}

@test "DarkBit_standalone_MSSM_1705.07920_Model_9" {
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_MSSM "$DATA_1705_07920"/chargino_coannihilation.slha2 > data_gambit/1705.07920_Model_9.txt
  )
  run id_ascii_files data_gambit/1705.07920_Model_9.txt data_expected/1705.07920_Model_9.txt 0.01 0.01
  [ $status = 0 ]
}

@test "SM_Z" {
  g++ -std=c++11 -o SM_Z ./examples/SM_Z.cpp -I"$GAMBIT"/DecayBit/include/gambit/DecayBit/
  rm -f data_gambit/SM_Z.dat
  ./SM_Z > data_gambit/SM_Z.dat
  run id_ascii_files data_gambit/SM_Z.dat data_expected/SM_Z.dat 0.01 0.01
  [ $status = 0 ]
}

@test "MSSM_H" {
  g++ -std=c++11 -o MSSM_H ./examples/MSSM_H.cpp -I"$GAMBIT"/DecayBit/include/gambit/DecayBit/
  rm -f data_gambit/MSSM_H.dat
  ./MSSM_H > data_gambit/MSSM_H.dat
  run id_ascii_files data_gambit/MSSM_H.dat data_expected/MSSM_H.dat 0.01 0.01
  [ $status = 0 ]
}

@test "MSSM_Z" {
  g++ -std=c++11 -o MSSM_Z ./examples/MSSM_Z.cpp -I"$GAMBIT"/DecayBit/include/gambit/DecayBit/
  rm -f data_gambit/MSSM_Z.dat
  ./MSSM_Z > data_gambit/MSSM_Z.dat
  run id_ascii_files data_gambit/MSSM_Z.dat data_expected/MSSM_Z.dat 0.01 0.01
  [ $status = 0 ]
}
