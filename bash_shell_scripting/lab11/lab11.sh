#!/usr/bin/env bash

# Use arrays to write roster script. The script should do the following:
# For each day of the week, prompt the user "enter janitor name for day"
# Store the names in an associative array, where weekdays are used as the key, and janitors names  as the value
# TODO: After prompting for the janitor names, the script should print the roster for this week

WEEK=('Monday' 'Tuesday' 'Wednesday' 'Thursday' 'Friday' 'Saturday' 'Sunday')
declare -A ROSTER

for day in "${WEEK[@]}"; do
    echo "Enter Janitor's name for ${day}: "
    read -r JANITOR_NAME
    ROSTER["${day}"]="${JANITOR_NAME}"
done

echo "The roster for the week is"
for day in "${WEEK[@]}"; do
    echo "${day}: ${ROSTER[${day}]}"
done