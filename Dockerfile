# syntax=docker/dockerfile:1

# Debian "slim" image has lower size then regular Debian or Ubuntu
# But it's still with APT package manager
FROM debian:stable-slim

# Yandex APT mirror is used as more available and fast
COPY files/debian.sources.stable /etc/apt/sources.list.d/debian.sources

ENV LUALS_VER=3.18.2

RUN apt update && \
    apt install --yes --no-install-recommends \
      # ep.sh deps:
      adduser \
      # Dockerfile deps:
      bash \
      # NeoVim deps:
      neovim \
      git-core \
      # pyright deps:
      python3 \
      python3-pip \
      # Clang LSP
      clangd \
      clang-tidy \
      # Run container per file is overhead. Use console manager to use single container per user.
      tmux \
      # Lua LSP deps:
      lua5.1 \
      # Bash LSP deps:
      shellcheck \
      shfmt \
      npm \
      nodejs \
    && \
    apt clean
#
# Python LSP
#
RUN pip install --break-system-packages pyright
#
# Lua LSP
#
ADD --checksum=sha256:ca71415dd19f19e30aaa35a4915aefca9fdb5fec31b98331cc3d77f778d539c5 \
    --unpack=true \
    "https://github.com/LuaLS/lua-language-server/releases/download/$LUALS_VER/lua-language-server-$LUALS_VER-linux-x64.tar.gz" \
    /opt/lua-language-server/
#
# Bash LSP
#
RUN npm i -g bash-language-server

# ep = entrypoint
COPY files/ep.sh /root/ep.sh
ENTRYPOINT ["/root/ep.sh"]

CMD ["/bin/bash"]

