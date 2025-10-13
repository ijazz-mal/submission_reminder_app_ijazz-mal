#!/usr/bin/env bash
# This file start up the assignment reminder app

name=$(basename "$PWD" | awk -F'_' '{print $NF}')
echo "Hello $name!!"
