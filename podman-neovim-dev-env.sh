#!/bin/sh

# TODO: make list of files and list of dirs to mount
#       Reason: strict check that mount needed type

VOLUMES=
if [ -f "$HOME/.ssh" ]; then
    VOLUMES="$VOLUMES --volume $HOME/.ssh:/root/.ssh:ro"
fi
if [ -f "$HOME/.bashrc" ]; then
    VOLUMES="$VOLUMES --volume $HOME/.bashrc:/root/.bashrc:ro"
fi
if [ -f "$HOME/.gnupg" ]; then
    VOLUMES="$VOLUMES --volume $HOME/.gnupg:/root/.gnupg:ro"
fi
if [ -f "$HOME/.gitconfig" ]; then
    VOLUMES="$VOLUMES --volume $HOME/.gitconfig:/root/.gitconfig:ro"
fi
if [ -f "$HOME/.gitignore_global" ]; then
    VOLUMES="$VOLUMES --volume $HOME/.gitignore_global:/root/.gitignore_global:ro"
fi
if [ -d "$HOME/.local" ]; then
    VOLUMES="$VOLUMES --volume $HOME/.local:/root/.local:rw"
fi

podman run --rm -ti \
    $VOLUMES \
    --volume "$HOME/bin":"/root/bin":ro \
    --volume "$HOME/.tmux":"/root/.tmux":ro \
    --volume "$HOME/.tmux.conf":"/root/.tmux.conf":ro \
    --volume "$HOME/.config/nvim":"/root/.config/nvim":rw \
    --volume "$HOME/.arduino15":"/root/.arduino15":rw \
    --volume "$HOME/.config/arduino":"/root/.config/arduino":rw \
    --volume "$HOME/.cache":"/root/.cache":rw \
    --volume "$HOME/Arduino":"/root/Arduino":rw \
    --volume "$(pwd):/ws" \
    neovim-dev-env "cd /ws && tmux"
