#!/bin/sh

set -ex

# Set any additional options
ADDITIONAL_OPTIONS=""
if [ "$DO_NOT_CHECK_HOST_KEY" = "true" ]; then
    ADDITIONAL_OPTIONS="-o StrictHostKeyChecking=no"
fi

# Connect and open the tunnel
ssh \
    -i ~/.ssh/ssh_client_key \
    -o ServerAliveInterval=$KEEPALIVE_INTERVAL \
    -o ExitOnForwardFailure=yes \
    $ADDITIONAL_OPTIONS \
    $SSH_USERNAME@$SSH_SERVER \
    -p $SSH_PORT \
    -N \
    -R $REMOTE_PORT:$LOCAL_HOSTNAME:$LOCAL_PORT
