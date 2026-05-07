# syntax=docker/dockerfile:1

# Debian "slim" image has lower size then regular Debian or Ubuntu
# But it's still with APT package manager
FROM debian:stable-slim

# Yandex APT mirror is used as more available and fast
COPY files/debian.sources.stable /etc/apt/sources.list.d/debian.sources

RUN apt update && \
    apt install --yes --no-install-recommends \
      # ep.sh deps:
      adduser \
      # Dockerfile deps:
      bash \
      # NeoVim deps:
      neovim \
    && \
    apt clean

RUN apt update

RUN apt install --yes --no-install-recommends \
  python3 \
  python3-pip

# Python LSP
RUN pip install --break-system-packages pyright

RUN apt install --yes --no-install-recommends \
    # Clang LSP
      clangd \
      clang-tidy

RUN apt install --yes --no-install-recommends \
    # Run container per file is overhead. Use console manager to use single container per user.
    tmux
#
# Lua LSP
#
ENV LUALS_VER=3.18.2

ADD --checksum=sha256:ca71415dd19f19e30aaa35a4915aefca9fdb5fec31b98331cc3d77f778d539c5 \
    --unpack=true \
    "https://github.com/LuaLS/lua-language-server/releases/download/$LUALS_VER/lua-language-server-$LUALS_VER-linux-x64.tar.gz" \
    /opt/lua-language-server/

RUN ln -s /opt/lua-language-server/bin/lua-language-server /usr/local/bin/lua-language-server
#
# Bash LSP
#
RUN apt install --yes --no-install-recommends \
      shellcheck \
      shfmt \
      npm \
      nodejs \
      && \
    npm i -g bash-language-server

RUN apt install --yes --no-install-recommends \
      git-core

RUN apt clean

# ep = entrypoint
COPY files/ep.sh /root/ep.sh
ENTRYPOINT ["/root/ep.sh"]

CMD ["/bin/bash"]

