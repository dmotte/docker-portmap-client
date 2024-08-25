#!/bin/sh

set -ex

keepalive_interval=${KEEPALIVE_INTERVAL:-30}

################################################################################

install -m600 /ssh_client_key ~portmap/.ssh
install -m644 /known_hosts ~portmap/.ssh || :

# Start the OpenSSH client with "exec" to ensure it receives all the stop
# signals correctly
exec /usr/bin/ssh \
    -oServerAliveInterval="$keepalive_interval" \
    -oExitOnForwardFailure=yes \
    -i ~/.ssh/ssh_client_key \
    "$@"
