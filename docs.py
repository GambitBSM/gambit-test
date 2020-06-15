"""
Check gambit documentation in config files
==========================================

Usage e.g.,

python docs.py capabilities extra

"""

import os
from subprocess import check_output

from import_yaml import load, duplicates


try:
    GAMBIT = os.environ["GAMBIT"]
except KeyError:
    raise RuntimeError("You must export GAMBIT=/path/to/gambit/executable")

START = dict(models='MODEL', capabilities='CAPABILITIES')
END = 'Calling MPI_Finalize'
EXTRA = set()


def filter_(lines, start, end):
    """
    :returns: Iterator over non-trivial lines in gambit output
    """
    yield_ = False

    for line in lines:

        if not line:
            continue
        elif line.startswith(start):
            yield_ = True
        elif line.startswith(end):
            break
        elif yield_:
            yield line

def dupes(command):
    """
    :returns: Duplicated entries in gambit config
    """
    file_name = "{}/config/{}.dat".format(GAMBIT, command)

    with open(file_name, 'r') as yaml_file:
        return duplicates(yaml_file)

def docs(command):
    """
    :returns: Entries in gambit config
    """
    file_name = "{}/config/{}.dat".format(GAMBIT, command)

    with open(file_name, 'r') as yaml_file:
        return set(load(yaml_file).keys())

def call(command):
    """
    :returns: Entries found when gambit called
    """
    shell = r"{}/gambit {} | sed 's/\x1b\[[0-9;]*m//g'".format(GAMBIT, command)
    output = check_output(shell, shell=True)

    lines = output.splitlines()
    items = [line.split()[0] for line in filter_(lines, START[command], END)]

    return set(items)

def missing(command):
    """
    :returns: Entries that are missing in gambit docs
    """
    return call(command) - docs(command)

def extra(command):
    """
    :returns: Entries that are extra in gambit docs
    """
    return docs(command) - call(command)


if __name__ == '__main__':

    import argparse

    parser = argparse.ArgumentParser(description='Check gambit documentation. You must export GAMBIT=...')
    parser.add_argument('command', type=str, help='which documentation to check', choices=['capabilities', 'models'])
    parser.add_argument('mode', type=str, help='which test to perform', choices=['missing', 'duplicates', 'extra'])
    args = parser.parse_args()

    if args.mode == 'missing':

        missing_ = missing(args.command)
        message = "The {}: {} were missing descriptions"
        assert not missing_, message.format(args.command, missing_)

    elif args.mode == 'extra':

        extra_ = extra(args.command)
        message = "The {}: {} are extra"
        assert not extra_ or extra_ == EXTRA, message.format(args.command, extra_)

    elif args.mode == "duplicates":

        duplicates_ = dupes(args.command)
        message = "The {}: {} were duplicated"
        assert not duplicates_, message.format(args.command, duplicates_)

    else:
        raise ValueError("Unknown mode: {}".format(args.mode))
