import os
from types import SimpleNamespace
from inspect import getsourcelines, isclass

import json


class Packer:
    def __init__(self):
        self.packages = {}
        self.remote_data = {'all': None}

    def create_package(self, package_name):
        self.packages[package_name] = {'callables': {},
                                       'globals': {}}

    def package_globals(self, package_name, **kwargs):
        if package_name in self.packages:
            self.packages[package_name]['globals'].update(kwargs)
        else:
            self.create_package(package_name)
            self.package_globals(package_name, **kwargs)

    def package(self, package_name):

        def wrap(callable):

            def inner(*args, **kwargs):
                return callable(*args, **kwargs)
            if package_name in self.packages:
                classy = 1
                if isclass(callable):
                    classy = 0
                self.packages[package_name]['callables'].update(
                    {callable.__name__: getsourcelines(callable)[0][classy:]})
            else:
                self.create_package(package_name)
                return wrap(callable)

            return inner

        return wrap

    def prepare(self):
        formed_packages = json.dumps(self.form_packages()).encode('utf-8')
        return formed_packages

    def form_packages(self):
        formed_packages = {}
        for package_name, package in self.packages.items():
            unformed_package = []
            for k, vS in package['globals'].items():
                unformed_package.append(' = '.join([k, v]) + '\n')
            for _, c in package['callables'].items():
                unformed_package.append(''.join(c) + '\n')
            formed_packages[package_name] = '\n\n'.join(unformed_package)
        return formed_packages

    def prepare_data(self, pc):
        try:
            data = self.remote_data[pc]
        except KeyError:
            data = self.remote_data['all']

        return json.dumps(data).encode('utf-8')

    @staticmethod
    def combine(*args):
        result = bytearray()
        for arg in args:
            try:
                arg = arg.encode('utf-8')
            except AttributeError:
                pass
            result += arg
        return result

    @staticmethod
    def write_package(path, package_name, contents):
        # print('TO WRITE', contents)
        with open(os.path.join(path, package_name + '.py'), 'w') as f:
            f.write(contents)

    @staticmethod
    def write_data(path, package_name, contents):
        # print('TO WRITE', contents)
        with open(os.path.join(path, package_name + '.json'), 'w') as f:
            json.dump(contents, f)
