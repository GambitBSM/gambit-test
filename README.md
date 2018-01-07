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

Other than GAMBIT, we require [numdiff](https://github.com/tjhei/numdiff), [BATS](https://github.com/sstephenson/bats) and
[PyYAML](https://pypi.python.org/pypi/PyYAML).

# Writing a YAML test

The YAML files must contain a special `Test` block with testing information, e.g.,

    Test:
      gambit: ./data_gambit/DarkBit_lnL_oh2/samples/DarkBit_lnL_oh2.dat  # Result produced by YAML file
      expected: ./data_expected/DarkBit_lnL_oh2.expected  # Expected result
      rtol: 1E-3  # Acceptable relative error in result (optional)
      atol: 1E-3  # Acceptable absolute error in result (optional)
      email: name@domain.com  # Contact email addresses separated by whitespace
    
There are three mandatory recognized entries: `gambit`, `expected` and `email`. Note that gambit on Jenkins produces data files *without* an `_0` suffix so don't include it. This may differ from behaviour on your computer. 

There are two optional recognized entries: `rtol`, the relative tolerance, and `atol`, the asbolute tolerance. If `rtol` (`atol`) is not supplied, arbitrarily large relative (absolute) differences won't cause an error. Files are tested in `numdiff --strict` mode, such that `atol` and `rtol` must both pass.
 
# Adding YAML test to BATS

Add a test to `gambit_yaml.bats` by coping this template:

    @test "ScannerBit_multinest with gambit" {
      local test=ScannerBit_multinest
      local yaml=./yaml/$test.yaml
      source_yaml "$yaml"
      run gambit_id_ascii_files "$yaml" "$Test_gambit" "$Test_expected" "$Test_rtol" "$Test_atol"
      [ $status = 0 ]
    
and changing `ScannerBit_multinest with gambit` and `ScannerBit_multinest` to the description and
name of your yaml file (excluding the `.yaml` extension).

You must add the expected output (`Test:expected` in the YAML file) to the `./data_expected` directory.
