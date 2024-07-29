# docker-portmap-client

![icon](icon-149.png)

[![GitHub main workflow](https://img.shields.io/github/actions/workflow/status/dmotte/docker-portmap-client/main.yml?branch=main&logo=github&label=main&style=flat-square)](https://github.com/dmotte/docker-portmap-client/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/dmotte/portmap-client?logo=docker&style=flat-square)](https://hub.docker.com/r/dmotte/portmap-client)

This is a :whale: **Docker image** you can use to expose **one or more TCP ports** to the internet using an **SSH tunnel**.

It works by connecting to a (publicly exposed) SSH server; this can be for example an instance of the **[dmotte/portmap-server](https://github.com/dmotte/docker-portmap-server.git) image**, or an online **SSH tunneling service** such as [portmap.io](https://portmap.io/) or [ngrok.com](https://ngrok.com/).

**Note**: this image runs as an **unprivileged user** (**non-root**).

> :package: This image is also on **Docker Hub** as [`dmotte/portmap-client`](https://hub.docker.com/r/dmotte/portmap-client) and runs on **several architectures** (e.g. amd64, arm64, ...). To see the full list of supported platforms, please refer to the [`.github/workflows/main.yml`](.github/workflows/main.yml) file. If you need an architecture which is currently unsupported, feel free to open an issue.

## Usage

For this section, we assume that you have already set up an SSH server for remote port forwarding (such as [`dmotte/portmap-server`](https://hub.docker.com/r/dmotte/portmap-server)) or you use an online port forwarding service.

This Docker image only supports **SSH public key authentication**, so we assume that you have a :key: **private key file** (hereinafter called `ssh_client_key`) to log in to the server. Please note that the private key file must be kept **unencrypted**, as otherwise the SSH client would ask for the passphrase at startup. Plus, it must be readable by the `portmap` **unprivileged user** inside the container.

Then you'll need an SSH `known_hosts` file containing the **public fingerprint** of your server. To obtain it, you can use the following command (replace the server address and port with yours):

```bash
ssh-keyscan -p2222 10.0.2.15 > known_hosts
```

> **Note**: if you want, you can bypass the known_hosts step by adding `-o StrictHostKeyChecking=no` to the SSH command, but it's **highly discouraged** for security reasons. Please refer to the [OpenSSH client manual page](https://linux.die.net/man/1/ssh) for further information.

Now suppose that you want to publicly expose (using portmap.io) a web service running locally in your LAN at `http://192.168.0.123:8080/`. You can start your portmap client container like this:

```bash
docker run -it --rm \
    -v "$PWD/known_hosts:/known_hosts:ro" \
    -v "$PWD/ssh_client_key:/ssh_client_key:ro" \
    dmotte/portmap-client \
    myuser.mycfg@myuser-12345.portmap.io -NvR12345:192.168.0.123:8080
```

For a more complex example, refer to the [`docker-compose.yml`](docker-compose.yml) file.

### Environment variables

List of supported **environment variables**:

| Variable             | Required         | Description                                                      |
| -------------------- | ---------------- | ---------------------------------------------------------------- |
| `KEEPALIVE_INTERVAL` | No (default: 30) | Value for the `ServerAliveInterval` option of the OpenSSH client |

### Volumes

| Internal path     | Required | Description                                                                                                                                                 |
| ----------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/known_hosts`    | No       | File containing the SSH server's public fingerprint(s)                                                                                                      |
| `/ssh_client_key` | **Yes**  | Unencrypted private key file that will be used by the OpenSSH client to authenticate itself. It must be readable by the `portmap` user inside the container |

## Development

If you want to contribute to this project, you can use the following one-liner to **rebuild the image** and bring up the **Docker-Compose stack** every time you make a change to the code:

```bash
docker-compose down && docker-compose up --build
```
