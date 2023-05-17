NAMESPACE ?= ctxsh
# VERSION := $(shell git describe --tags)
BUILD := $(shell git rev-parse --short HEAD)
CR_TOKEN ?= unset
CR_USERNAME ?= anonymous

.PHONY: all
all: core

###################################################################################################
# Login
###################################################################################################
.PHONY: login
login:
	@echo $(CR_TOKEN) | docker login ghcr.io -u $(CR_USERNAME) --password-stdin 

###################################################################################################
# Base
###################################################################################################
.PHONY: core
core:
	@docker build \
		--tag ghcr.io/$(NAMESPACE)/core:$(BUILD) \
		--file core/Dockerfile \
		core

.PHONY: release-core
release-core:
	@docker push ghcr.io/$(NAMESPACE)/core:$(BUILD)

.PHONY: release-core-latest
release-core-latest:
	@docker tag ghcr.io/$(NAMESPACE)/core:$(BUILD) ghcr.io/$(NAMESPACE)/core:latest
	@docker push ghcr.io/$(NAMESPACE)/core:latest


###################################################################################################
# Clean
###################################################################################################
clean:
	@docker rm $(shell docker ps -qa) || true
	@docker rmi $(shell docker images -q $(NAMESPACE)/core) --force || true
