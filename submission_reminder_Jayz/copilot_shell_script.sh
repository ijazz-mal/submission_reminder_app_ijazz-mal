#!/usr/bin/env bash

name=$(basename "$PWD" | awk -F'_' '{print $NF}')
read -r -p "Hey $name, please enter your assignment name: " ass_name

sed -i "/ASSIGNMENT/s/=.*/=\"$ass_name\"/g" config/config.env
