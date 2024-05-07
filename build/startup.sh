#!/bin/sh

set -ex

install -m600 /ssh_client_key ~portmap/.ssh
install -m644 /known_hosts ~portmap/.ssh || :

ssh_username=${SSH_USERNAME:-portmap}
ssh_port=${SSH_PORT:-22}
keepalive_interval=${KEEPALIVE_INTERVAL:-30}

fwds2=$(echo "$FORWARDINGS" | sed 's/,/ -R /g')

# Start the OpenSSH client with "exec" to ensure it receives all the stop
# signals correctly
# shellcheck disable=SC2046,SC2086
exec /usr/bin/ssh \
    -i ~/.ssh/ssh_client_key \
    -oServerAliveInterval="$keepalive_interval" \
    -oExitOnForwardFailure=yes \
    -p"$ssh_port" \
    $(if [ $# = 0 ]; then echo '-N'; fi) \
    -R $fwds2 \
    $ADDITIONAL_OPTIONS \
    "$ssh_username@$SSH_SERVER" \
    "$*"
