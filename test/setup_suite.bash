setup_suite() {

  load "$BATS_TEST_DIRNAME"/../src/gambit

  if [ -z "$GAMBIT" ]; then
    error "GAMBIT not defined"
    return 1
  fi

  export YAML="$BATS_TEST_DIRNAME"/../yaml
  export DATA="$BATS_TEST_DIRNAME"/../data
  export SRC="$BATS_TEST_DIRNAME"/../src
}