#!/bin/bash

sudo diff /var/log/syslog /tmp/syslog/syslog.old | grep "^<" | awk '{print substr($0,3)}' > /tmp/syslog/syslog.diff
cat /var/log/syslog > /tmp/syslog/syslog.old