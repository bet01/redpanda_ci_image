build:
	docker build -t ghcr.io/bet01/redpanda_ci_image:v21.5.7 .


push: build
	docker push ghcr.io/bet01/redpanda_ci_image:v21.5.7 


example: build
	docker run -t 
	docker run -ti --rm --hostname redpanda_ci_image --name=redpanda_ci_image ghcr.io/bet01/redpanda_ci_image:v21.5.7 test,bar,baz

debug: build
	docker run -ti --rm --hostname redpanda_ci_image --name=redpanda_ci_image --entrypoint /bin/bash  ghcr.io/bet01/redpanda_ci_image:v21.5.7 
