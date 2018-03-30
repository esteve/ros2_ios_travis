#!/bin/sh

gpg --keyserver hkps.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

rvm get stable

brew upgrade python

sudo -H python3 -m pip install empy setuptools vcstool pyparsing

gem install xcpretty
