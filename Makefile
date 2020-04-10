ORG=liridev
NAME=lupdate-action
VERSION=latest

build:
	@sudo docker build -t $(ORG)/$(NAME):$(VERSION) --build-arg today=$(date +%s) .

push:
	@sudo docker push $(ORG)/$(NAME):$(VERSION)

all: build

.PHONY: build
