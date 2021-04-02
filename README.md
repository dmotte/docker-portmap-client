# docker-portmap-client

![](portmap-client-icon-149.png)

[![Docker Pulls](https://img.shields.io/docker/pulls/dmotte/portmap-client.svg?logo=docker)](https://hub.docker.com/r/dmotte/portmap-client)

This is a :whale: **Docker image** you can use to expose a **local TCP port** to the internet using an **SSH tunnel**.

It works by connecting to a (publicly exposed) SSH server; this can be for example an instance of the **[dmotte/portmap-server](https://github.com/dmotte/docker-portmap-server.git) image** or an online **SSH tunneling service** like [portmap.io](https://portmap.io/)

> :package: This image is also on **Docker Hub** as [`dmotte/portmap-client`](https://hub.docker.com/r/dmotte/portmap-client) and runs on **several architectures** (e.g. amd64, arm64, ...). To see the full list of supported platforms, please refer to the `.github/workflows/docker.yml` file.

## Usage

For this section, we assume that you have already set up an SSH server for remote port forwarding (such as [`dmotte/portmap-server`](https://hub.docker.com/r/dmotte/portmap-server)) or you use an online port forwarding service (such as [portmap.io](https://portmap.io/)).

This Docker image only supports **SSH public key authentication**, so we assume that you have a :key: **private key file** (hereinafter called `ssh_client_key`) to log into the server. Please note:

- The private key file must be **unencrypted**, as otherwise the SSH client would ask for the passphrase at startup
- It must have **`600` permissions**. To achieve this:
  ```bash
  chmod 600 ssh_client_key
  ```

Then you'll need an SSH `known_hosts` file containing the **public fingerprint** of your server. To obtain it, you can use the following command (replace the server address and port with yours):

```bash
ssh-keyscan -p 2222 10.0.2.15 > "known_hosts"
```

Suppose that you want to publicly expose a web service running locally in your LAN at `http://192.168.0.123:8080/`. You can start your portmap client:

```bash
docker run -it --rm \
    -v $PWD/known_hosts:/home/portmap/.ssh/known_hosts:ro \
    -v $PWD/ssh_client_key:/home/portmap/.ssh/ssh_client_key:ro \
    -e SSH_SERVER=TODO \
    -e SSH_USERNAME=TODO \
    -e REMOTE_PORT=TODO \
    -e LOCAL_HOSTNAME=192.168.0.123 \
    -e LOCAL_PORT=8080 \
    dmotte/portmap-client
```

TODO permissions issue. startup.sh as root, portmap copy and set perms. known_hosts optional (strict checking env var)

For a more complex example, please refer to the `docker-compose.yml` file.

TODO screenshot

### Environment variables

List of supported **environment variables**:

TODO envvars list, all required except SSH_USERNAME=portmap, SSH_PORT=22

## Development

```bash
git clone https://github.com/dmotte/docker-portmap-client.git
```

TODO place your `ssh_client_key` (with correct permissions) and `known_hosts` into the `vols-portmap-client` folder and:

```bash
docker-compose up --build
```

Or if you prefer daemon:

```bash
docker-compose up -d
```

```bash
docker-compose logs -ft
```
