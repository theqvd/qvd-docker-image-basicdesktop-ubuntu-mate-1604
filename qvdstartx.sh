#!/bin/bash
#
# Load /etc/environment and timezone if it exists
#
[ -r /etc/environment ] && . /etc/environment
[ -r /etc/timezone ] && export TZ=$(cat /etc/timezone)

/usr/bin/mate-session $@
