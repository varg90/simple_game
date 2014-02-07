#!/bin/bash

BASE_DIR=`dirname $0`

echo ""
echo "Compile Coffee scripts"
echo "-------------------------------------------------------------------"

coffee --compile --output app/js app/js

#echo ""
#echo "Running protractor tests"
#echo "-------------------------------------------------------------------"
#
#$BASE_DIR/../e2e-test.sh

echo ""
echo "Starting Karma Server (http://karma-runner.github.io)"
echo "-------------------------------------------------------------------"

$BASE_DIR/../test.sh

