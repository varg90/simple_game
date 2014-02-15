#!/bin/bash

./node_modules/.bin/coffee --compile --output app/js app/js
sass --update app/css:app/css
