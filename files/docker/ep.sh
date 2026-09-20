#!/bin/sh

# Set next environment variables preliminary to execute this script:
#   ENV_USER - username
#   ENV_USER_ID - user ID 
#   ENV_USER_GROUP_ID - user group ID
# That information has been used to create such unprivileged user and perform docker CMD commands with it's permissions
#   Reason 1: browser will be run not by 'root'
#   Reason 2: files downloaded by browser will be stored in mounted folder with unprivileged user ownership 
#             and host user will have no troubles to access them
create_user()
{
    if [ -z "$ENV_USER" ]; then
        echo 'Use docker run cmdline option: -e ENV_USER="$USER"'
        exit 1
    fi

    if [ -z "$ENV_USER_ID" ]; then
        echo 'Use docker run cmdline option: -e ENV_USER_ID="$(id -u)"'
        exit 1
    fi

    if [ -z "$ENV_USER_GROUP_ID" ]; then
        echo 'Use docker run cmdline option: -e ENV_USER_GROUP_ID="$(id -g)"'
        exit 1
    fi

    addgroup --gid "$ENV_USER_GROUP_ID" "$ENV_USER"
    
    mkdir -p "/home/$ENV_USER" \
             "/home/$ENV_USER/.local/share/nvim" \
             "/home/$ENV_USER/.config/nvim"

    chown "$ENV_USER_ID":"$ENV_USER_GROUP_ID" \
        "/home/$ENV_USER" \
        "/home/$ENV_USER/.local" \
        "/home/$ENV_USER/.local/share" \
        "/home/$ENV_USER/.local/share/nvim" \
        "/home/$ENV_USER/.config" \
        "/home/$ENV_USER/.config/nvim"

    adduser  --uid "$ENV_USER_ID" \
             --gid "$ENV_USER_GROUP_ID" \
             --disabled-password \
             --gecos "" \
             "$ENV_USER"
}

install_luals_for_user()
{
    cp -a /opt/lua-language-server "/home/$ENV_USER/.local/share/"

    chown "$ENV_USER_ID":"$ENV_USER_GROUP_ID" -R \
        "/home/$ENV_USER/.local/share/lua-language-server"

    ln -sf "/home/$ENV_USER/.local/share/lua-language-server/bin/lua-language-server" /usr/local/bin/lua-language-server
}

main()
{
    create_user "$@"
    install_luals_for_user
    su --pty "$ENV_USER" /bin/sh -c "cd \"/home/$ENV_USER\"; $*"
}

main "$@"
