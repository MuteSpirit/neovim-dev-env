#!/bin/sh

docker run --rm -ti \
    --env ENV_USER="$USER" \
    --env ENV_USER_ID="$(id -u)" \
    --env ENV_USER_GROUP_ID="$(id -g)" \
    --volume "$HOME/.gitconfig":"$HOME/.gitconfig" \
    --volume "$HOME/.config/nvim":"$HOME/.config/nvim" \
    --volume "$HOME/.local/share/nvim":"$HOME/.local/share/nvim" \
    --volume "$(pwd):/ws" \
    --workdir "/ws" \
    neovim-dev-env "cd /ws; tmux"
