#!/bin/sh

set -ex

# Default values for some env vars
SSH_USERNAME=${SSH_USERNAME:-"portmap"}
SSH_PORT=${SSH_PORT:-"22"}
KEEPALIVE_INTERVAL=${KEEPALIVE_INTERVAL:-"30"}

# Connect and open the tunnel
ssh \
    -i ~/.ssh/ssh_client_key \
    -o ServerAliveInterval=$KEEPALIVE_INTERVAL \
    -o ExitOnForwardFailure=yes \
    $SSH_USERNAME@$SSH_SERVER \
    -p $SSH_PORT \
    -N \
    -R $REMOTE_PORT:$LOCAL_HOSTNAME:$LOCAL_PORT
