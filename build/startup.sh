#!/bin/sh

set -ex

export SSH_USERNAME="${SSH_USERNAME:-portmap}"
export SSH_PORT="${SSH_PORT:-22}"
export KEEPALIVE_INTERVAL="${KEEPALIVE_INTERVAL:-30}"

install -oportmap -gportmap -m600 /ssh_client_key ~portmap/.ssh
install -oportmap -gportmap -m644 /known_hosts ~portmap/.ssh || :

su portmap -c "~portmap/client.sh $*"
