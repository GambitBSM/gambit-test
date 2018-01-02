"""
Modified PyYAML that supports !import keyword and lists as keys
===============================================================
"""

import os
import yaml


IMPORT_TAG = '!import'
SEQ_TAG = 'tag:yaml.org,2002:seq'


class ImportLoader(yaml.Loader):
    """
    Override default loader to support inclusion of YAML files and permit lists
    as YAML keys.
    """
    def __init__(self, stream):
        """
        Obtain path to stream, if possible.
        """
        try:
            self._root = os.path.split(stream.name)[0]
        except AttributeError:
            self._root = os.getcwd()
        super(ImportLoader, self).__init__(stream)

    def import_(self, node):
        """
        Import YAML file via a keyword (see
        https://stackoverflow.com/a/9577670/2855071)

        :returns: YAML file for inclusion
        :rtype: dict
        """
        yamal_name = os.path.join(self._root, self.construct_scalar(node))

        with open(yamal_name, 'r') as yamal_file:
            return yaml.load(yamal_file, ImportLoader)

    def construct_tuple(self, node):
        """
        Permit lists as YAML keys (see
        https://gist.github.com/miracle2k/3184458#file-tuple-py).
        """
        return tuple(ImportLoader.construct_sequence(self, node))


ImportLoader.add_constructor(SEQ_TAG, ImportLoader.construct_tuple)
ImportLoader.add_constructor(IMPORT_TAG, ImportLoader.import_)


def load(stream):
    """
    :param stream: YAML file to be loaded
    :type stream: Stream obj. File or str

    :returns: YAML file as nested dictionary
    :rtype: dict
    """
    return yaml.load(stream, ImportLoader)
