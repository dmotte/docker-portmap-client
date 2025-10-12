# Tested with docker.io/library/alpine:3.19.1
FROM docker.io/library/alpine:latest

RUN apk add --no-cache openssh-client

COPY --chown=root:root --chmod=755 startup.sh /

RUN addgroup -S portmap && adduser -S portmap -G portmap -s /bin/ash && \
    install -oportmap -gportmap -dvm700 /home/portmap/.ssh

USER portmap

ENTRYPOINT ["/startup.sh"]
