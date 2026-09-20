# neovim-dev-env

Container for Developer environment with NeoVim, LSP servers (C/C++, Bash, Python, Lua) and tmux inside.

It's difficult to manually support the same development environment on several workplaces (work PC, home PC, VPS, etc.).
The goal of this project - container for development quickstart with NeoVim on Linux PC.

## Docker

Besides useful development tools present in image there is also entrypoint script which creates unprivileged user with the same UID and GID as host user has. That allows to avoid troubles with access rights to files created on host and inside container.

Build:

```
make docker-img
```

Install:
* make symlink to `neovim-dev-env.sh` script at folder present in `PATH` user evironment variable

Usage:
```
cd <working-directory>
/path/to/neovim-dev-env.sh

/ws $ you are in container now. Current host directory is bind to /ws now
```

## Podman

### Why?

* No daemon - less RAM consumption.
* Rootless mode. More security. Not needed to create separate user inside container because `root` inside will be mapped to your user on host and there will be no file access rights troubles also.
* Image size (5 times less!):

```
$ docker image ls | grep neovim
neovim-dev-env           latest              61b054dabb9a   38 hours ago   10.7GB

$ podman image ls | grep neovim
localhost/neovim-dev-env  latest         a33b2976f0ea  39 hours ago  1.79 GB
```

### Usage

Build:

```
make podman-img
```

Install:
* make symlink to `podman-neovim-dev-env.sh` script at folder present in `PATH` user evironment variable

Usage:
```
cd <working-directory>
/path/to/podman-neovim-dev-env.sh

/ws # you are in container now. Current host directory is bind to /ws now
```

## Known issues

* [ ] webdevicons does not work
* [ ] colors in NeoVim color schemas are broken - looks different inside container and on host
