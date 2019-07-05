DOCKER_REPO ?= docker-push.ocf.berkeley.edu/
DOCKER_REVISION ?= irclogger-testing-$(USER)
DOCKER_TAG_IRCLOGGER = $(DOCKER_REPO)irclogger-run:$(DOCKER_REVISION)
DOCKER_TAG_NGINX = $(DOCKER_REPO)irclogger-nginx:$(DOCKER_REVISION)

IRCLOGGER_SHA := add3db5c06deafe0e0828e593b22e4010c3a4615

.PHONY: cook-image
cook-image:
	docker build \
		--build-arg IRCLOGGER_SHA=$(IRCLOGGER_SHA) \
		-t $(DOCKER_TAG_IRCLOGGER) \
		-f Dockerfile.irclogger \
		.

	docker build \
		--build-arg IRCLOGGER_SHA=$(IRCLOGGER_SHA) \
		-t $(DOCKER_TAG_NGINX) \
		-f Dockerfile.nginx \
		.

.PHONY: push-image
push-image:
	docker push $(DOCKER_TAG_IRCLOGGER)
	docker push $(DOCKER_TAG_NGINX)

