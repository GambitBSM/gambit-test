teardown_suite() {
  if [ -n "$output" ]; then
    error "$output"
  fi

  if [ -n "$Test_email" ]; then
    error email = "$Test_email"
  fi

  # This shouldn't be necessary
  rm -rf ./runs
  rm -rf $GAMBIT/runs
  rm -f Key.dat
}