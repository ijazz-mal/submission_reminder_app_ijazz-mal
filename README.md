Name: Assignment reminder app 
Files and their use:
1.create_environment.sh --> Creates all needed directories and files and runs the app starter(startup.sh) after 
2.startup.sh --> runs copilot_shell_script.sh and /app/reminder.sh starting the app itself
3.copilot_shell_script.sh --> asks the user for the assignment name that they need to check
4.app/reminder.sh --> checks the given assignment from /config/config.env, /modules/function.sh and /assets/submissions.txt and display when it's and a list of other student who didn't submit yet
5.config/config.env --> stores the assignments and their due time of the signed in user
6./modules/functions.sh --> stores the function that checks the given assignments and their due time
7.assets/submissions.txt --> stores the assignments ,their status( submitted or not submitted ) and their owners

THANKS!!!
