#!/usr/bin/env bash
# Write a menu with the name operator. It should meet the following requirements:
# 1. The menu offers options to see available disk space, available RAM and users currently logged in
# 2. It should not be possible to exit from the menu using Ctrl-C

# Functions
function available_ram() {
    AVAIL_RAM=$(free --mega | grep -i mem | awk '{ print $4 }')
    echo "Available RAM for the system is ${AVAIL_RAM}MB"
}

function  available_disk_space(){
    AVAIL_DISK=$(df --block-size=G | grep -i '/$' | awk '{ print $4 }')

    # Remove GB from AVAIL_DISK
    AVAIL_DISK="${AVAIL_DISK%G}"

    echo "Available DISK for the system is ${AVAIL_DISK}GB"
}

function error_message() {
    clear
    echo "You cannot exit from the menu with Ctrl+c!"
    echo "Press enter to continue"
}

# Menu
OPTION_1="Available Disk Space"
OPTION_2="Available Ram"
OPTION_3="Users Logged in"
OPTION_4="Quit"
MENU_OPTIONS=("${OPTION_1}" "${OPTION_2}" "${OPTION_3}" "${OPTION_4}")

# Trap
trap error_message INT TERM

select option in "${MENU_OPTIONS[@]}"; do
    case $option in
        "${OPTION_1}")
            available_disk_space
            ;;
        "${OPTION_2}")
            available_ram
            ;;
        "${OPTION_3}")
            who --users | awk '{ print $1 }'
            ;;
        "${OPTION_4}")
            echo "Quiting"
            break
            ;;
        *)
            echo "Invalid option try again"
            ;;
    esac
done
