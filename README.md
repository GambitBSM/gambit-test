# Introduction

This repo contains scripts to perform tests on GAMBIT using [Bats](https://github.com/bats-core/bats-core).
We check whether the output from running GAMBIT on a set of YAML files matches the expected output.

The YAML files are contained in [`/yaml`](https://github.com/GambitBSM/gambit-test/tree/master/yaml)
and the expected output is contained in [`/data/expected`](https://github.com/GambitBSM/gambit-test/tree/master/data/expected).

The BATS framework installed by cloning recursively:

   git clone --recursive https://github.com/GambitBSM/gambit-test

# Running

First, set the directory of the GAMBIT executable named `gambit`:

    export GAMBIT= ... path to gambit executable ...

Then run all the Bats tests with output in `TAP` format:

    ./test/bats/bin/bats test/*.bats

There are four Bats files:

- `funcs.bats`: tests gambit testing setup!
- `io.bats`: io tests of gambit. E.g. does it return correct error codes?
- `yaml.bats`: Functional tests of gambit from yaml files
- `standalones.bats`: builds and checks the output of a few standalones w/o calling gambit itself

You may find the [Bats usage](https://github.com/bats-core/bats-core#usage) section of the README helpful;
it's possible to e.g., filter the tests that you run using a regular expression.

# Dependencies

Other than GAMBIT, we require [numdiff](https://github.com/tjhei/numdiff), [Bats](https://github.com/bats-core/bats-core) and
[gambit-yaml](https://github.com/GambitBSM/gambit-yaml). E.g.,

    git clone --recursive https://github.com/GambitBSM/gambit-test
    apt install numdiff 
    pip install git+https://github.com/GambitBSM/gambit-yaml

# Writing a YAML test

The YAML files must contain a special `Test` block with testing information, e.g.,

    Test:
      gambit: ./data_gambit/DarkBit_lnL_oh2/samples/DarkBit_lnL_oh2.dat  # Result produced by YAML file
      expected: ./data_expected/DarkBit_lnL_oh2.expected  # Expected result
      rtol: 1E-3  # Acceptable relative error in result (optional)
      atol: 1E-3  # Acceptable absolute error in result (optional)
      email: name@domain.com  # Contact email addresses separated by whitespace

There are three mandatory recognized entries: `gambit`, `expected` and `email`.

There are two optional recognized entries: `rtol`, the relative tolerance, and `atol`, the absolute tolerance.
If `rtol` (`atol`) is not supplied, arbitrarily large relative (absolute) differences won't cause an error.
Files are tested in `numdiff --strict` mode, such that `atol` and `rtol` must both pass.
 
# Adding YAML test to Bats

Add a test to `gambit_yaml.bats` by copying this template:

    @test "ScannerBit_multinest with gambit" {
      run gambit_id_ascii_files ./yaml/ScannerBit_multinest.yaml
      assert_success

and changing `ScannerBit_multinest with gambit` and `ScannerBit_multinest` to the description and
name of your yaml file (excluding the `.yaml` extension).

You must add the expected output (`Test:expected` in the YAML file) to the `./data/expected` directory.
