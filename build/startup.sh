#!/bin/sh

set -ex

export SSH_USERNAME="${SSH_USERNAME:-portmap}"
export SSH_PORT="${SSH_PORT:-22}"
export KEEPALIVE_INTERVAL="${KEEPALIVE_INTERVAL:-30}"

cp /ssh_client_key /home/portmap/.ssh/ssh_client_key
chown portmap:portmap /home/portmap/.ssh/ssh_client_key
chmod 600 /home/portmap/.ssh/ssh_client_key

if [ -f /known_hosts ]; then
    cp /known_hosts /home/portmap/.ssh/known_hosts
    chown portmap:portmap /home/portmap/.ssh/known_hosts
    chmod 644 /home/portmap/.ssh/known_hosts
fi

su portmap -c "/home/portmap/client.sh $*"
