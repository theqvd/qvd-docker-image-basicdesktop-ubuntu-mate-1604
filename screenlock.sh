#!/bin/bash
logger -p user.info "invoked $0 $@"

log() {
    logger -p user.info "$0: $@"
}

nxagentpid=$(pgrep nxagent)
[ -z "$nxagentpid" ] && log "nxagent was not running nxagent pid was empty"
nxagentuser=$(ps -ho "user" -p $nxagentpid)
[ -z "$nxagentuser" ] && log "nxagent user was not present???" && exit 1
su - "$nxagentuser" -c "DISPLAY=:100 gnome-screensaver-command --lock"

exit 0

