#!/bin/bash
:  '
 install terraform using tfenv : https://github.com/tfutils/tfenv
 install rbenv   using git method : https://github.com/rbenv/rbenv 
 verify rbenv using rbenv-doctor
 rbenv install 2.7.4 
 gem install bundler 
 bundle install
'
set -x
set -e

 bundle exec kitchen create
 bundle exec kitchen converge
 bundle exec kitchen verify