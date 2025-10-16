#!/usr/bin/env bash

read -r -p "Welcome $username, please enter your assignment name: " ass_name
sed -i "/ASSIGNMENT/s/=.*/=\"$ass_name\"/g" "$dir/config/config.env"

./$dir/startup.sh
