#!/bin/sh

# put this script at ~/twenty.sh
# put the launch agent to run it at ~/Library/LaunchAgents/local.twenty.plist
# then run:
#    launchctl load ~/Library/LaunchAgents/local.twenty.plist
#    launchctl start local.twenty
osascript -e 'display notification "20-20-20" with title "20-20-20"'
