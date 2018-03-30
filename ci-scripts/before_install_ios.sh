#!/bin/bash

set -euf -o pipefail

command curl -sSL https://rvm.io/mpapis.asc | gpg --import -

rvm get stable

brew upgrade python

sudo -H python3 -m pip install empy setuptools vcstool pyparsing

gem install xcpretty
