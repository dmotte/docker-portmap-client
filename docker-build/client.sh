#!/bin/sh

set -ex

# Connect and open the tunnel
ssh \
    -i ~/.ssh/ssh_client_key \
    -o ServerAliveInterval=$KEEPALIVE_INTERVAL \
    -o ExitOnForwardFailure=yes \
    $SSH_USERNAME@$SSH_SERVER \
    -p $SSH_PORT \
    -N \
    -R $REMOTE_PORT:$LOCAL_HOSTNAME:$LOCAL_PORT
