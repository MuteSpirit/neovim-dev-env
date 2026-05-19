#!/bin/sh

docker run --rm -ti \
    --env ENV_USER="$USER" \
    --env ENV_USER_ID="$(id -u)" \
    --env ENV_USER_GROUP_ID="$(id -g)" \
    --volume "$HOME/.gitconfig":"$HOME/.gitconfig":ro \
    --volume "$HOME/.tmux":"$HOME/.tmux":ro \
    --volume "$HOME/.ssh":"$HOME/.ssh":ro \
    --volume "$HOME/.config/nvim":"$HOME/.config/nvim":rw \
    --volume "$HOME/.local/share/nvim":"$HOME/.local/share/nvim":rw \
    --volume "$HOME/.local/state/nvim":"$HOME/.local/state/nvim":rw \
    --volume "$(pwd):/ws" \
    --workdir "/ws" \
    neovim-dev-env "cd /ws; tmux"
