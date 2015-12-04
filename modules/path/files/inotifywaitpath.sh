#!/bin/bash

while read line
do
	echo $line >> /tmp/email
	#mail -s "DO NOT REPLY: PATH Variable Changed" puppet.master@outlook.com < /tmp/email 
done < <(inotifywait -e close_write --exclude '.*\.swp.*' $(echo $PATH | gawk -F':' 'BEGIN { OFS=" "}; {$1=$1; print $0}') -m)