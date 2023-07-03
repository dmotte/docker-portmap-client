# Tested with docker.io/library/alpine:3.18.2
FROM docker.io/library/alpine:latest

# Install required packages
RUN apk add --no-cache openssh-client

# Copy the startup script
COPY --chown=root:root --chmod=755 startup.sh /

# Create the portmap user
RUN addgroup -S portmap && adduser -S portmap -G portmap -s /bin/ash

# As the portmap user, create the .ssh directory and copy the client.sh script
USER portmap
WORKDIR /home/portmap

RUN mkdir .ssh && chmod 700 .ssh

COPY --chown=portmap:portmap --chmod=755 client.sh .

# Become the root user again and declare the entrypoint
USER root
WORKDIR /

ENTRYPOINT ["/startup.sh"]
