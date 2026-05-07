# syntax=docker/dockerfile:1

# Debian "slim" image has lower size then regular Debian or Ubuntu
# But it's still with APT package manager
FROM debian:stable-slim

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

# ep = entrypoint
COPY ep.sh /root/ep.sh
ENTRYPOINT ["/root/ep.sh"]

CMD ["/bin/bash"]

RUN apt update

RUN apt install --yes --no-install-recommends \
  python3 \
  python3-pip

RUN pip install --break-system-packages pyright

RUN apt clean
