#!/bin/bash

# Exit on error
set -e

# Load functions
source /scripts/update-app-user-uid-gid.sh

# Debug output
set -x

update_user_gid $SYS_USERNAME $SYS_GROUPNAME $SYS_GID
update_user_uid $SYS_USERNAME $SYS_UID
update_user_gid $APP_USERNAME $APP_GROUPNAME $APP_GID
update_user_uid $APP_USERNAME $APP_UID

chown -R $APP_USERNAME $APP_USERHOME

export HOME=$APP_USERHOME

if [ -n "$NET_GW" ]; then
    ip route del default || true
    ip route add default via $NET_GW
fi

if [ "$1" = $APP_NAME ]; then
  shift;
  exec supervisord -c /app/supervisord.conf
fi

exec "$@"
