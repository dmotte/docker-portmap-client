#!/bin/sh

set -ex

FWDS2=$(echo "$FORWARDINGS" | sed 's/,/ -R /g')

# shellcheck disable=SC2046,SC2086
/usr/bin/ssh \
    -i ~/.ssh/ssh_client_key \
    -o ServerAliveInterval="$KEEPALIVE_INTERVAL" \
    -o ExitOnForwardFailure=yes \
    -p "$SSH_PORT" \
    $(if [ $# -eq 0 ]; then echo '-N'; fi) \
    -R $FWDS2 \
    $ADDITIONAL_OPTIONS \
    "$SSH_USERNAME@$SSH_SERVER" \
    "$*"
