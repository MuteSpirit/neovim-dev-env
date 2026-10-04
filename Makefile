.PHONY: img docker-img podman-img help

NAME ?= neovim-dev-env

img: docker-img podman-img

docker-img: common.d/* docker.d/* ./files/*.sources ./files/docker/* ## Build Docker image
	mkdir -p .tmp
	cat docker.d/* > .tmp/Dockerfile
	docker build -f .tmp/Dockerfile -t "$(NAME)" .

run-docker: docker-img    ## Run Docker container
	./docker-neovim-dev-env.sh

podman-img: common.d/* podman.d/* ./files/*.sources ./files/podman/* ## Build Podman image
	mkdir -p .tmp
	cat podman.d/* > .tmp/Containerfile
	podman build -f .tmp/Containerfile -t "$(NAME)" .

run-podman: podman-img    ## Run Podman container
	./podman-neovim-dev-env.sh

help: ## Show this help
	@sed -ne '/@sed/!s/:.*## /:\t/p' $(MAKEFILE_LIST)
