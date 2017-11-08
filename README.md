# Running

Set the directory of the GAMBIT executable named `gambit`:

    export GAMBIT= ... path to gambit ...

Run all the BATS tests with output in `TAP` format:

    bats --tap *.bats
    
There are three files:
    
- `funcs.bats`: tests my testing setup!
- `gambit_io.bats`: io tests of gambit. E.g. does it return correct error codes?
- `gambit_yaml.bats`: Functional tests of gambit from yaml files.

# Dependencies

Other than GAMBIT, we require [numdiff](https://github.com/tjhei/numdiff) and [BATS](https://github.com/sstephenson/bats).

# Writing a YAML test

The YAML files must contain a special `Test` block with testing information, e.g.,

    Test:
      gambit: ./data_gambit/DarkBit_lnL_oh2/samples/DarkBit_lnL_oh2.dat_0  # Result produced by YAML file
      expected: ./data_expected/DarkBit_lnL_oh2.expected  # Expected result
      rtol: 1E-3  # Acceptable relative error in result
    
There are three recognized entries: `gambit`, `expected` and `rtol`.
    
# Adding YAML test to BATS

Add a test to `gambit_yaml.bats` by coping this template:

    @test "ScannerBit_multinest with gambit" {
      local test=ScannerBit_multinest
      local yaml=./yaml/$test.yaml
      source_yaml "$yaml"
      run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol"
      [ $status = 0 ]
    
and changing `ScannerBit_multinest with gambit` and `ScannerBit_multinest` to the description and
name of your yaml file (excluding the `.yaml` extension).

You must add the expected output (`Test:expected` in the YAML file) to the `./data_expected` directory.
