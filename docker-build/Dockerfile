FROM alpine

RUN apk add --no-cache openssh-client

RUN addgroup -S portmap && adduser -S portmap -G portmap
USER portmap

WORKDIR /home/portmap
RUN mkdir .ssh && chmod 700 .ssh

COPY --chown=portmap startup.sh .
RUN chmod +x startup.sh

ENTRYPOINT ["/home/portmap/startup.sh"]
