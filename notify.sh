#!/bin/bash
logger -p user.info "invoked $0 $@"

log() {
    logger -p user.info "$0: $@"
}

export DISPLAY=:100

log "sending expire  warning message to  $USER"

notify-send -t 3600000 -u normal -i  /usr/share/icons/elementary-xfce/apps/48/un-reboot.png 'System Update' \
'A new system update is available.
Please log off to apply the system update.


'
log "vma status expired flag created !"
if  [ ! -f /tmp/vma.expired ]  ; then touch /tmp/vma.expired  ;fi

exit 0

