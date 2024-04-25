#!/bin/sh

set -ex

fwds2=$(echo "$FORWARDINGS" | sed 's/,/ -R /g')

# shellcheck disable=SC2046,SC2086
/usr/bin/ssh \
    -i ~/.ssh/ssh_client_key \
    -oServerAliveInterval="$KEEPALIVE_INTERVAL" \
    -oExitOnForwardFailure=yes \
    -p"$SSH_PORT" \
    $(if [ $# = 0 ]; then echo '-N'; fi) \
    -R $fwds2 \
    $ADDITIONAL_OPTIONS \
    "$SSH_USERNAME@$SSH_SERVER" \
    "$*"
