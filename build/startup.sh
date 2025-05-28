#!/bin/sh

set -ex

keepalive_interval=${KEEPALIVE_INTERVAL:-30}

################################################################################

install -m600 -t ~portmap/.ssh /ssh_client_key
install -m644 -t ~portmap/.ssh /known_hosts || :

# Start the OpenSSH client with "exec" to ensure it receives all the stop
# signals correctly
exec /usr/bin/ssh \
    -oServerAliveInterval="$keepalive_interval" \
    -oExitOnForwardFailure=yes \
    -i ~/.ssh/ssh_client_key \
    "$@"
