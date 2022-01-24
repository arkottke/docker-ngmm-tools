
TAG=ngmm-tools
PWD=$(shell pwd)

NonErgModeling/.git/config:
	git submodule update --init

build: NonErgModeling/.git/config
	docker build . -t $(TAG)

debug: build
	docker run -t -i --rm --entrypoint /bin/bash $(TAG)

run: build
	docker run --rm -p 8888:8888 -v "$(PWD)":/home/jovyan/work $(TAG)
