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
