# Debian "slim" image has lower size then regular Debian or Ubuntu. 
# But it's still with APT package manager.
#
# Latest Neovim is needed. It's located in PPA repository and "unstable" Debian.
# Also it's not recommended to use Ubuntu PPA on Debian.
# So let's try to use "unstable" Debian
FROM debian:unstable-slim

ENV DEBIAN_FRONTEND=noninteractive

# Yandex APT mirror is used as more available and fast
COPY files/debian-unstable.sources /etc/apt/sources.list.d/

ENV LUALS_VER=3.18.2

RUN apt update && \
    apt install --yes --no-install-recommends \
      bash \
      bash-completion \
      git \
      git-lfs \
      git-man \
      ssh \
      locales \
      # ep.sh deps:
      adduser \
      # NeoVim deps:
      ripgrep \
      neovim \
      # Rendering Markdown into HTML
      pandoc \
      # Run container per file is overhead. Use console manager to use single container per user.
      tmux \
      # pyright deps:
      python3 \
      python3-pip \
      # Clang LSP
      clangd \
      clang-tidy \
      # Lua LSP deps:
      lua5.1 \
      # Bash LSP deps:
      shellcheck \
      shfmt \
      npm \
      nodejs \
      # Useful tools
      less \
      curl \
      wget \
      # Compilers/interpreters
      clang \
      gcc \
      make \
      gawk \
      build-essential \
    && \
    apt clean && \
    # Python LSP
    pip install --break-system-packages pyright && \
    # Bash LSP
    npm i -g bash-language-server
#
# Lua LSP
#
RUN cd /tmp && \
    wget -O luals.tar.gz "https://github.com/LuaLS/lua-language-server/releases/download/$LUALS_VER/lua-language-server-$LUALS_VER-linux-x64.tar.gz" && \
    mkdir -p /opt/lua-language-server/ && \
    cd /opt/lua-language-server/ && \
    tar xf /tmp/luals.tar.gz && \
    rm /tmp/luals.tar.gz
#
# NeoVim fonts and icons
# Following
#  https://github.com/ryanoasis/nerd-fonts#font-installation
#  https://github.com/ryanoasis/vim-devicons
# RUN git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git /opt/nerd-fonts && \
#     /opt/nerd-fonts/install.sh install CodeNewRoman

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US
ENV LC_ALL=en_US.UTF-8

# ep = entrypoint
COPY files/podman/ep.sh /root/ep.sh
ENTRYPOINT ["/root/ep.sh"]

CMD ["/bin/bash"]
