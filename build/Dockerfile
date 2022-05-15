FROM alpine

# Install required packages
RUN apk add --no-cache openssh-client

# Copy the startup script
COPY startup.sh /
RUN chmod +x /startup.sh

# Create the portmap user
RUN addgroup -S portmap && adduser -S portmap -G portmap -s /bin/ash

# As the portmap user, create the .ssh directory and copy the client.sh script
USER portmap
WORKDIR /home/portmap

RUN mkdir .ssh && chmod 700 .ssh

COPY --chown=portmap client.sh .
RUN chmod +x client.sh

# Become the root user again and declare the entrypoint
USER root
WORKDIR /

ENTRYPOINT ["/startup.sh"]
