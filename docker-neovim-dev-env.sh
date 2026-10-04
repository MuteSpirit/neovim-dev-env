#!/bin/sh

docker run --rm -ti \
    --env ENV_USER="$USER" \
    --env ENV_USER_ID="$(id -u)" \
    --env ENV_USER_GROUP_ID="$(id -g)" \
    --volume "$HOME/bin":"$HOME/bin":ro \
    --volume "$HOME/.arduino15":"$HOME/.arduino15":rw \
    --volume "$HOME/.config/arduino":"$HOME/.config/arduino":rw \
    --volume "$HOME/Arduino":"$HOME/Arduino":rw \
    --volume "$HOME/.gitconfig":"$HOME/.gitconfig":ro \
    --volume "$HOME/.tmux":"$HOME/.tmux":ro \
    --volume "$HOME/.ssh":"$HOME/.ssh":ro \
    --volume "$HOME/.config/nvim":"$HOME/.config/nvim":rw \
    --volume "$HOME/.local/share/nvim":"$HOME/.local/share/nvim":rw \
    --volume "$HOME/.local/state/nvim":"$HOME/.local/state/nvim":rw \
    --volume "$HOME/.local/bin":"$HOME/.local/bin":ro \
    --volume "$(pwd):/ws" \
    --workdir "/ws" \
    neovim-dev-env "export PATH="$HOME/bin:$PATH"; cd /ws; tmux"
