#!/bin/bash

BASE_DIR=`dirname $0`

coffee --compile --output app/js app/js

echo ""
echo "Starting Karma Server (http://karma-runner.github.io)"
echo "-------------------------------------------------------------------"

$BASE_DIR/../node_modules/karma/bin/karma start --single-run --browsers PhantomJS $BASE_DIR/../config/karma.conf.js $*
