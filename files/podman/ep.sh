#!/bin/sh

# For rootless Podman container it's not needed to create a user with the same UID:GID as on host.
# Container process owner will be automatically be mapped as "root" in user namespace and vice versa.
# So files created by process within container will have container process owner UID:GID in host file system.
#
# That information has been used to create such unprivileged user and perform docker CMD commands with it's permissions
#   Reason 1: browser will be run not by 'root'
#   Reason 2: files downloaded by browser will be stored in mounted folder with unprivileged user ownership 
#             and host user will have no troubles to access them
install_luals_for_user()
{
    mkdir -p "$HOME/.local/share/"
    cp -a /opt/lua-language-server "$HOME/.local/share/"

    chown "$(id -u)":"$(id -g)" -R \
        "$HOME/.local/share/lua-language-server"

    ln -sf "$HOME/.local/share/lua-language-server/bin/lua-language-server" /usr/local/bin/lua-language-server
}

main()
{
    install_luals_for_user
    cd "$HOME";
    /bin/bash -c "$*"
}

main "$@"
