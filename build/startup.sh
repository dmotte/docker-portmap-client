#!/bin/sh

set -ex

keepalive_interval=${KEEPALIVE_INTERVAL:-30}
auto_restart=${AUTO_RESTART:--1}

################################################################################

install -m600 -t ~portmap/.ssh /ssh_client_key
install -m644 -t ~portmap/.ssh /known_hosts || :

if [ "$auto_restart" = -1 ]; then
    # Start the OpenSSH client with "exec" to ensure it receives all the stop
    # signals correctly
    exec /usr/bin/ssh \
        -oServerAliveInterval="$keepalive_interval" \
        -oExitOnForwardFailure=yes \
        -i ~/.ssh/ssh_client_key \
        "$@"
else
    while :; do
        result=0
        /usr/bin/ssh \
            -oServerAliveInterval="$keepalive_interval" \
            -oExitOnForwardFailure=yes \
            -i ~/.ssh/ssh_client_key \
            "$@" || result=$?
        [ "$result" = 0 ] ||
            echo "The OpenSSH client exited with status code $result" >&2

        echo "Sleeping $auto_restart" >&2
        sleep "$auto_restart"
    done
fi
