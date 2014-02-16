#!/bin/bash

./node_modules/.bin/coffee --compile --output app/js app/js
./node_modules/.bin/jade app/partials app/index.jade
sass --update app/css:app/css
