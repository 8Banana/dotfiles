#!/usr/bin/env python3

from setuptools import setup
from sys import version_info

if version_info < (3, 5, 2):
    # 3.5.2 is when __aiter__ became a synchronous function
    raise SystemExit('Sorry! multicomputering requires python 3.5.2 or later.')

setup(
    name='multicomputering',
    description='multicomputering - multiprocessing for multiple computers!',
    license='MIT',
    version='0.0.1',
    author='Mark Jameson - aka theelous3',
    url='https://github.com/theelous3/multicomputering',
    packages=['multicomputering'],
    classifiers=['Programming Language :: Python :: 3']
)
