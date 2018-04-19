#!/bin/bash
lab=BenTest
console=0
date=$(/bin/date +"%m-%d-%Y-%T")
hostname=$(/bin/hostname)
if /usr/bin/who -H | /bin/grep " tty" | /bin/grep " (:" > /dev/null 2>&1; then console=1; fi

#echo "$date"
#echo "$hostname"
#echo "$console"
#echo "$lab"

curl -H "Content-Type: application/json" -X POST -d '{"logged":"'"$date"'","workstation":"'"$hostname"'","console":"'"$console"'","lab":"'"$lab"'"}' https://urgl220xq1.execute-api.us-west-2.amazonaws.com/v1/labusage
