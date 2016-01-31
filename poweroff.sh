#!/bin/bash
logger -p user.info "invoked $0 $@"

log() {
    logger -p user.info "$0: $@"
}

localip=$(/sbin/ip -4 -o addr show dev eth0| awk '{split($4,a,"/");print a[1]}')

if  [ -f  /tmp/vma.expired ]
then
    log "Stopping vma , now ! "
    curl http://$localip:3030/vma/poweroff
    rm -fv  /tmp/vma.expired
fi

exit 0

