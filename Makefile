.PHONY: img run help

NAME ?= nvim-dev-env

img: Dockerfile   ## Build Docker image
	docker build -t $(NAME) .

help:     ## Show this help
	@sed -ne '/@sed/!s/:.*## /:\t/p' $(MAKEFILE_LIST)

run: img
	docker run --rm -ti -e ENV_USER="$$USER" -e ENV_USER_ID="$$(id -u)" -e ENV_USER_GROUP_ID="$$(id -g)" -v "$$HOME/.config/nvim":"$$HOME/.config/nvim":ro $(NAME)
