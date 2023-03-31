#!/bin/sh

set -ex

# Process the FORWARDINGS list
FWDS2=$(echo "$FORWARDINGS" | sed 's/,/ -R /g')

# Connect and open the tunnel
# shellcheck disable=SC2086
/usr/bin/ssh \
    -i ~/.ssh/ssh_client_key \
    -o ServerAliveInterval="$KEEPALIVE_INTERVAL" \
    -o ExitOnForwardFailure=yes \
    -p "$SSH_PORT" \
    -N \
    -R $FWDS2 \
    $ADDITIONAL_OPTIONS \
    "$SSH_USERNAME@$SSH_SERVER"
