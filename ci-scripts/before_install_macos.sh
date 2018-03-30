#!/bin/sh

command curl -sSL https://rvm.io/mpapis.asc | gpg --import -

rvm get stable

brew upgrade python

brew install wget cmake cppcheck tinyxml eigen pcre

# install dependencies for Fast-RTPS if you are using it
brew install asio tinyxml2

brew install opencv

sudo -H python3 -m pip install vcstool

sudo -H python3 -m pip install argcomplete coverage empy flake8 flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-docstrings flake8-import-order flake8-quotes mock nose pep8 pydocstyle pyflakes pyparsing pytest pytest-cov pytest-runner pyyaml setuptools vcstool

gem install xcpretty
