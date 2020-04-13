"""
Parse relevant data from YAML file into BASH commands
=====================================================
"""
from __future__ import print_function
from sys import argv
from import_yaml import load


BLOCK = 'Test'
COMPULSORY = ('gambit', 'expected', 'email')
OPTIONAL = (('rtol', 1E10), ('atol', 1E10))
BASH = '{}_{}="{}"'


def yaml_to_bash(yaml_name):
    """
    Parse relevant data from YAML file into BASH commands. The YAML file
    must contain particular entries.

    :param yaml_name: Name of YAML file
    :type yaml_name: str

    :returns: YAML data in BASH syntax
    :rtype: str
    """
    with open(yaml_name, 'r') as yaml_file:
        data = load(yaml_file)

    try:
        bash = [BASH.format(BLOCK, k, data[BLOCK][k]) for k in COMPULSORY]
    except (TypeError, KeyError):
        error = "YAML '{}' didn't contain '{}' block with {} keys"
        raise RuntimeError(error.format(yaml_name, BLOCK, COMPULSORY))

    bash += [BASH.format(BLOCK, k, data[BLOCK].get(k, d)) for k, d in OPTIONAL]

    bash = ";\n".join(bash)
    return bash


if __name__ == '__main__':

    assert len(argv) == 2
    YAML_NAME = argv[1]
    print(yaml_to_bash(YAML_NAME))
