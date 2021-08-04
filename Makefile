IMG=ghcr.io/bet01/redpanda_ci_image:latest

build:
	docker build -t ${IMG} .

push: build
	docker push ${IMG}  

example1: build
	docker run -t --rm --hostname redpanda_ci_image --name=redpanda_ci_image --env CREATE_TOPICS=foo,bar,baz ${IMG}

example2: build
	docker run -t --rm --hostname redpanda_ci_image --name=redpanda_ci_image --env CREATE_TOPICS=foo,bar:1,baz:3 ${IMG}

debug: build
	docker run -ti --rm --hostname redpanda_ci_image --name=redpanda_ci_image --entrypoint /bin/bash ${IMG}
