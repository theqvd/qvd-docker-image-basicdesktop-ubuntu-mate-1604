#!/bin/bash
log() {
    logger -p user.info "$0: $@"
}
if [ $# -ne 2 ]; then
   log "Not enough arguments, 2 required example mate-screensaver-command lock|unlock <$@>"
   exit 1
fi
   
SCREENLOCK=$1
ACTION=$2

# Check that screenlock is executable
# Check for valid actions (lock/unlock)

log "invoked $0 $@"

nxagentpid=$(pgrep nxagent)
[ -z "$nxagentpid" ] && log "nxagent was not running nxagent pid was empty"
nxagentuser=$(ps -ho "user" -p $nxagentpid)
[ -z "$nxagentuser" ] && log "nxagent user was not present???" && exit 1

case "$ACTION" in
  lock)
      su - $nxagentuser -c "DISPLAY=:100 $SCREENLOCK -a -n QVD -r $ACTION"
      ;;
  unlock)
      su - $nxagentuser -c "DISPLAY=:100 $SCREENLOCK -d -n QVD -r $ACTION"
      ;;
  *)
      ;;
esac
su - $nxagentuser -c "DISPLAY=:100 $SCREENLOCK -a -r $REASON"

exit 0

