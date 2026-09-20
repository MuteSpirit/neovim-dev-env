#!/bin/sh

podman run --rm -ti \
    --volume "$HOME/bin":"/root/bin":ro \
    --volume "$HOME/.gitconfig":"/root/.gitconfig":ro \
    --volume "$HOME/.tmux":"/root/.tmux":ro \
    --volume "$HOME/.ssh":"/root/.ssh":ro \
    --volume "$HOME/.config/nvim":"/root/.config/nvim":rw \
    --volume "$HOME/.local/share/nvim":"/root/.local/share/nvim":rw \
    --volume "$HOME/.local/state/nvim":"/root/.local/state/nvim":rw \
    --volume "$HOME/.local/bin":"/root/.local/bin":ro \
    --volume "$HOME/.arduino15":"/root/.arduino15":rw \
    --volume "$HOME/.config/arduino":"/root/.config/arduino":rw \
    --volume "$HOME/Arduino":"/root/Arduino":rw \
    --volume "$(pwd):/ws" \
    neovim-dev-env "export PATH="$HOME/bin:$PATH"; cd /ws; tmux"
