#!/bin/bash
echo -e "\x1B[1m \x1B[32m"
echo -e "--- Installing node modules ---"
echo -e "-------------------------------"
echo -e "\x1B[0m"

npm install

echo -e "\x1B[1m \x1B[32m"
echo -e "--- Installing bower packages ---"
echo -e "---------------------------------"
echo -e "\x1B[0m"

./node_modules/.bin/bower install

echo -e "\x1B[1m \x1B[32m"
echo -e "------- Installing gems -------"
echo -e "-------------------------------"
echo -e "\x1B[0m"

gem install sass
gem install foreman

echo -e "\x1B[1m \x1B[32m"
echo -e "-- Generatings js, html, css --"
echo -e "-------------------------------"
echo -e "\x1B[0m"

sh ./scripts/generate_all.sh

echo -e "\x1B[1m \x1B[32m"
echo -e "-------------------------------"
echo -e "--- Now run: \x1B[93mforeman start \x1B[1m \x1B[32m---"
echo -e "\x1B[0m"
