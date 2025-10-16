#!/usr/bin/env bash
# This file creates the necessary directories that submission_reminder_app. need to function


read -p "Your name, please?" username
mkdir -p "submission_reminder_$username"
dir="submission_reminder_$username"
mkdir -p $dir/app $dir/modules $dir/assets $dir/config
export username
export dir

if [ ! -f $dir/app/reminder.sh ]; then
cat > $dir/app/reminder.sh << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./$dir/config/config.env
source ./$dir/modules/functions.sh

# Path to the submissions file
submissions_file="$dir/assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
fi




if [ ! -f $dir/modules/functions.sh ]; then
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



if [ ! -f $dir/assets/submissions.txt ]; then
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

if [ ! -f $dir/config/config.env ]; then
cat << 'EOF' > $dir/config/config.env
# This is the config file
ASSIGNMENT="Shell Basics"
DAYS_REMAINING=2
EOF
fi


if [ ! -f $dir/startup.sh ]; then
cat << 'EOF' > $dir/startup.sh
#!/usr/bin/env bash
# This file start up the assignment reminder app
bash $dir/app/reminder.sh
EOF
fi

find . -name "*.sh" | xargs chmod 777
./copilot_shell_script.sh
