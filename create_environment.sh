#!/usr/bin/env bash
# This file creates the necessary directories that submission_reminder_app. need to function


read -p "Your name, please?" username
mkdir -p "submission_reminder_$username"
dir="submission_reminder_$username"
mkdir -p $dir/app $dir/modules $dir/assets $dir/config
if [ -f $dir/app/reminder.sh ]; then
echo "al"
else
cat << 'EOF' > $dir/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
fi

if [ -f $dir/modules/functions.sh ]; then
echo "all"
else
cat << 'EOF' > $dir/modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
fi

if [  -f $dir/assets/submissions.txt ]; then
echo "all se"
else
cat << 'EOF' > $dir/assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, not submitted
Killua, Shell Basics, not submitted
Guevara, Python basics, submitted
Jayz, SLTD Formative, not submitted
Eric, Leadership quiz-01, submitted
Mahoraga, Git, not submitted
EOF
fi

if [ -f $dir/config/config.env ]; then
echo "all set"
else
cat << 'EOF' > $dir/config/config.env
# This is the config file
ASSIGNMENT="Shell Basics"
DAYS_REMAINING=2
EOF
fi
if [ -f $dir/copilot_shell_script.sh ]; then
echo ""
else
cat << 'EOF' > $dir/copilot_shell_script.sh
#!/usr/bin/env bash

name=$(basename "$PWD" | awk -F'_' '{print $NF}')
read -r -p "Hey $name, please enter your assignment name: " ass_name

sed -i "/ASSIGNMENT/s/=.*/=\"$ass_name\"/g" config/config.env
EOF
fi

if [ -f $dir/startup.sh ]; then
echo "all set!!"
else
cat << 'EOF' > $dir/startup.sh
#!/usr/bin/env bash
# This file start up the assignment reminder app

./copilot_shell_script.sh
./app/reminder.sh
EOF
fi

find . -name "*.sh" | xargs chmod 777

cd $dir
./startup.sh
