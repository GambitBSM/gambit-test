#!/usr/bin/env bats
#
# Tests of standalones in bats framework. See e.g. https://github.com/sstephenson/bats
#
# Written by A. Fowlie.

load funcs

setup() {
  :
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
  (
  cd "$GAMBIT"
  ./DarkBit_standalone_WIMP 7
  )
  cat "$GAMBIT"/LUX_2016_SD_table.dat \
      "$GAMBIT"/LUX_2016_SI_table.dat \
      "$GAMBIT"/PandaX_2016_SD_table.dat \
      "$GAMBIT"/PandaX_2016_SI_table.dat \
      "$GAMBIT"/PICO_60_2017_SD_table.dat \
      "$GAMBIT"/PICO_60_2017_SI_table.dat \
      "$GAMBIT"/XENON1T_2017_SD_table.dat \
      "$GAMBIT"/XENON1T_2017_SI_table.dat > data_gambit/DarkBit_standalone_WIMP_7.dat

  rm -f "$GAMBIT"/LUX_2016_SD_table.dat \
        "$GAMBIT"/LUX_2016_SI_table.dat \
        "$GAMBIT"/PandaX_2016_SD_table.dat \
        "$GAMBIT"/PandaX_2016_SI_table.dat \
        "$GAMBIT"/PICO_60_2017_SD_table.dat \
        "$GAMBIT"/PICO_60_2017_SI_table.dat \
        "$GAMBIT"/XENON1T_2017_SD_table.dat \
        "$GAMBIT"/XENON1T_2017_SI_table.dat

  run id_ascii_files data_gambit/DarkBit_standalone_WIMP_7.dat data_expected/DarkBit_standalone_WIMP_7.dat 0.01 0.01
  [ $status = 0 ]
}

