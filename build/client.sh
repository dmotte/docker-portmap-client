#!/bin/sh

set -ex

FWDS2=$(echo "$FORWARDINGS" | sed 's/,/ -R /g')

# shellcheck disable=SC2046,SC2086
/usr/bin/ssh \
    -i ~/.ssh/ssh_client_key \
    -oServerAliveInterval="$KEEPALIVE_INTERVAL" \
    -oExitOnForwardFailure=yes \
    -p"$SSH_PORT" \
    $(if [ $# = 0 ]; then echo '-N'; fi) \
    -R $FWDS2 \
    $ADDITIONAL_OPTIONS \
    "$SSH_USERNAME@$SSH_SERVER" \
    "$*"
