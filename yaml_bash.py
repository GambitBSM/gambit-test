"""
Parse relevant data from YAML file into BASH commands
=====================================================
"""

from sys import argv
from import_yaml import load


BLOCK = "Test"
KEYS = ["gambit", "expected", "rtol"]


def yaml_to_bash(yaml_name):
    """
    :param yaml_name: Name of YAML file
    :type yaml_name: str

    :returns: YAML data in BASH syntax
    :rtype: str
    """
    with open(yaml_name) as yaml_file:
        data = load(yaml_file)

    try:
        bash = ['{}_{}="{}"'.format(BLOCK, k, data[BLOCK][k]) for k in KEYS]
    except (TypeError, IndexError):
        error = "YAML didn't contain {} block with {} keys".format(BLOCK, KEYS)
        raise RuntimeError(error)

    bash = ";".join(bash)
    return bash


if __name__ == "__main__":

    assert len(argv) == 2
    yaml_name = argv[1]
    print yaml_to_bash(yaml_name)
