#!/usr/bin/env bash

# Write a script that can be used to install, start and enable services
# The names of the services must be provided as command line arguments
# If no command line arguments were provided while starting the script, the script should show an error message
# Before starting the next service, the script should check that at least 256MB of RAM is still available. If that is not the case, the script should stop.

# ERROR CODES
NO_ARGUMENTS=1
LOWER_RAM=2

# Functions
function check_available_ram() {
  AVAIL_RAM=$(free --mega | grep -i mem | awk '{ print $4 }')
  MIM_RAM=256

  if [ "${AVAIL_RAM}" -lt ${MIM_RAM} ]; then
    echo 'ERROR: Lower RAM memory'
    exit ${LOWER_RAM}
  fi
}

# Check arguments
if [ -z "$1" ]; then
  echo "ERROR: This script needs services as arguments"
  exit ${NO_ARGUMENTS}
fi

# Manage services
for service in "${@}"; do
  check_available_ram
  sudo dnf install "${service}"
  sudo systemctl enable --now "${service}"
done
