.PHONY: img run help

NAME ?= neovim-dev-env

img: Dockerfile   ## Build Docker image
	docker build -t $(NAME) .

help:     ## Show this help
	@sed -ne '/@sed/!s/:.*## /:\t/p' $(MAKEFILE_LIST)

run: img    ## Run container with preliminary build it
	./neovim-dev-env.sh

run-as-is:  ## Run container exist in local registry to avoid docker.io availability troubles 
	./neovim-dev-env.sh
