"""
Check descriptions
==================
"""

from import_yaml import load

import os
from subprocess import check_output


GAMBIT = os.environ["GAMBIT"]
DESCRIPTIONS = "{}/config/capabilities.dat".format(GAMBIT)
COMMAND = "{}/gambit capabilities | sed 's/\x1b\[[0-9;]*m//g'".format(GAMBIT)


SKIP = ('This is GAMBIT.', 'CAPABILITIES', 'Calling MPI_Finalize...', '___', '>>>')
skip = lambda line: any(s in line for s in SKIP) or not line


def caps():
    """
    """
    output = check_output(COMMAND, shell=True)
    caps_ = [line.split()[0] for line in output.split('\n') if not skip(line)]
    return set(caps_)

def docs():
    """
    """
    with open(DESCRIPTIONS, 'r') as yaml_file:
        caps_ = load(yaml_file).keys()
    return set(caps_)

def missing():
    """
    """
    return caps() - docs()

if __name__ == '__main__':
    missing_ = missing()
    message = "The capabilities: {} were missing descriptions in {}"
    assert not missing_, message.format(missing_, DESCRIPTIONS)
