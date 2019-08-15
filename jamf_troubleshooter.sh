#!/bin/bash
###############################################################################
# JAMF Troubleshooter Wrapper GUI
# Created by: Mann Consulting (support@mann.com)
# Version : August 12, 2019
# Matt jerome
#
# Summary: Runs various commands in a terminal for JAMF Troubleshooting
#
#
# Useage:
#	Run as root. It will provide choices for which commands to run.
#
# Do Note:	This script is part of Mann Consulting's Jamf Pro Maintenance subscription and is only
# 			authorized for use for current subscribers.  If you'd like updates or support
#			sign up at https://mann.com/jamf or email support@mann.com for more details
###############################################################################
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
options=("Run Inventory" "Run Policy Check In" "Check For Configuration Profiles" "List all JAMF Commands" "Re-Run DEP Enrollment" "Quit")
opt=""
while [[ "$opt" != "Quit" ]]; do
select opt in "${options[@]}"
do
  case $opt in
    "Run Inventory")
    jamf recon
    ;;
    "Run Policy Check In")
    jamf policy
    ;;
    "Re-Run DEP Enrollment")
    profiles renew -type enrollment
    ;;
    "Check For Configuration Profiles")
    jamf manage
    ;;
    "List JAMF Commands")
    jamf help -hidden
    "Quit")
    break
    ;;
    *)
    echo "Invalid choice, please choose again";;
  esac
  break
done
done
