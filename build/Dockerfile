# Tested with docker.io/library/alpine:3.18.2
FROM docker.io/library/alpine:latest

RUN apk add --no-cache openssh-client

COPY --chown=root:root --chmod=755 startup.sh /

RUN addgroup -S portmap && adduser -S portmap -G portmap -s /bin/ash

RUN mkdir /home/portmap/.ssh && \
    chown portmap:portmap /home/portmap/.ssh && \
    chmod 700 /home/portmap/.ssh

COPY --chown=portmap:portmap --chmod=755 client.sh /home/portmap

ENTRYPOINT ["/startup.sh"]
