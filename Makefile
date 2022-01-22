
TAG=ngmm-tools
PWD=$(shell pwd)

build:
	docker build . -t $(TAG)

debug: build
	docker run -t -i --rm --entrypoint /bin/bash $(TAG)

run: build
	docker run --rm -p 8888:8888 -v "$(PWD)":/home/jovyan/work $(TAG)
