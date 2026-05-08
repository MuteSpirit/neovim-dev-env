.PHONY: img run help

NAME ?= nvim-dev-env

img: Dockerfile   ## Build Docker image
	docker build -t $(NAME) .

help:     ## Show this help
	@sed -ne '/@sed/!s/:.*## /:\t/p' $(MAKEFILE_LIST)

define RunCmd
	docker run --rm -ti \
		--env ENV_USER="$$USER" \
		--env ENV_USER_ID="$$(id -u)" \
		--env ENV_USER_GROUP_ID="$$(id -g)" \
		--volume "$$HOME/.gitconfig":"$$HOME/.gitconfig" \
		--volume "$$HOME/.config/nvim":"$$HOME/.config/nvim" \
		--volume "$$HOME/.local/share/nvim":"$$HOME/.local/share/nvim" \
		--volume "$$(pwd):/ws" \
		--workdir "/ws" \
		$(NAME) "cd /ws; tmux"
endef

run: img
	$(call RunCmd)

run-as-is:
	$(call RunCmd)
