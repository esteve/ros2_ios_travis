#!/bin/sh

rvm get stable

brew upgrade python

sudo -H python3 -m pip install empy setuptools vcstool pyparsing

gem install xcpretty
