#!/usr/bin/env bash
# This file creates the necessary directories that submission_reminder_app. need to function


read -p "Your name, please?" username
mkdir -p "submission_reminder_$username"
create="submission_reminder_$username"

mkdir -p $create/app $create/modules $create/assets $create/config

find . -name "*.sh" | xargs chmod 777
