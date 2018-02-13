"""
Check descriptions
==================
"""

from import_yaml import load, duplicates

import sys
import os
from subprocess import check_output


GAMBIT = os.environ["GAMBIT"]
START = dict(models='MODEL', capabilities='CAPABILITIES')
END = 'Calling MPI_Finalize'
EXTRA = set(['DetAnalysisNumbers', 
             'DetectorSim',
             'ReconstructedEvent',
             'DetAnalysisContainer'])


def filter_(lines, start, end):
    """
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
    """
    file_name = "{}/config/{}.dat".format(GAMBIT, command)

    with open(file_name, 'r') as yaml_file:
        return duplicates(yaml_file)

def docs(command):
    """
    """
    file_name = "{}/config/{}.dat".format(GAMBIT, command)

    with open(file_name, 'r') as yaml_file:
        keys = load(yaml_file).keys()

    return set(keys)

def call(command):
    """
    """
    shell = r"{}/gambit {} | sed 's/\x1b\[[0-9;]*m//g'".format(GAMBIT, command)
    output = check_output(shell, shell=True)

    lines = output.splitlines()
    items = [line.split()[0] for line in filter_(lines, START[command], END)]

    return set(items)

def missing(command):
    """
    """
    return call(command) - docs(command)
    
def extra(command):
    """
    """
    return docs(command) - call(command)


if __name__ == '__main__':

    assert len(sys.argv) == 3
    command = sys.argv[1]
    mode = sys.argv[2]
    assert command in ['capabilities', 'models']
    assert mode in ['missing', 'duplicates', 'extra']

    if mode == 'missing':

        missing_ = missing(command)
        message = "The {}: {} were missing descriptions"
        assert not missing_, message.format(command, missing_)

    elif mode == 'extra':
    
        extra_ = extra(command)
        message = "The {}: {} are extra"   
        assert not extra_ or extra_ == EXTRA, message.format(command, extra_)
    
    else:

        duplicates_ = dupes(command)
        message = "The {}: {} were duplicated"
        assert not duplicates_, message.format(command, duplicates_)
