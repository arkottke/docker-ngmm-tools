
TAG=ngmm-tools
PWD=$(shell pwd)

build:
	docker build . -t $(TAG)

debug: build
	docker run -t -i --rm --entrypoint /bin/bash $(TAG)

run: build
	docker run --rm -p 8890:8890 -v "$(PWD)/work":/home/jovyan/work $(TAG)

push: build
	docker tag $(TAG) arkottke/$(TAG)
	docker push arkottke/$(TAG)

dl-rawfiles:
	docker run --rm -p 8890:8890 -v "$(pwd)/work":/home/jovyan/local ngmm-tools sh /home/jovyan/work/ngmm_tools/download_rawfiles.sh

dl-examplfiles:
	docker run --rm -p 8890:8890 -v "$(pwd)/work":/home/jovyan/local ngmm-tools sh /home/jovyan/work/ngmm_tools/download_examplfiles.sh

dl-syndata:
	docker run --rm -p 8890:8890 -v "$(pwd)/work":/home/jovyan/local ngmm-tools sh /home/jovyan/work/ngmm_tools/download_syndata.sh
