#!/bin/sh

set -ex

# Default values for some env vars
export SSH_USERNAME=${SSH_USERNAME:-"portmap"}
export SSH_PORT=${SSH_PORT:-"22"}
export KEEPALIVE_INTERVAL=${KEEPALIVE_INTERVAL:-"30"}

# Copy the ssh_client_key file in the home dir of the portmap user and set the
# right permissions
cp "/ssh_client_key" "/home/portmap/.ssh/ssh_client_key"
chown portmap:portmap "/home/portmap/.ssh/ssh_client_key"
chmod 600 "/home/portmap/.ssh/ssh_client_key"

# Copy the known_hosts file in the home dir of the portmap user and set the
# right permissions
cp "/known_hosts" "/home/portmap/.ssh/known_hosts"
chown portmap:portmap "/home/portmap/.ssh/known_hosts"
chmod 644 "/home/portmap/.ssh/known_hosts"

# Run the client.sh script as the portmap user
su portmap -c "/home/portmap/client.sh"
