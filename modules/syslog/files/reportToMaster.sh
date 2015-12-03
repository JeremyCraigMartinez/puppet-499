#!/bin/bash

function send {
	len=$(wc -c /tmp/syslog/syslog.diff | awk '{print $1}')
	if [ "0" -ne "$len" ]; 
	then
		mail -s "DO NOT REPLY: $1 Report - $(date)" puppet.master@outlook.com < $2 
	else
		echo "no changes"
	fi
}

send "Syslog" /tmp/syslog/syslog.diff
