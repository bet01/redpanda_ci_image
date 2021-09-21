# redpanda_ci_image

Because github actions don't allow overriding ENTRYPOINT we need a custom repanda image where we can use environmental variables and arguments to specify such things as log level. 

# Environmental Options

* `DEFAULT_LOG_LEVEL` passed to redpanda startup args, useful values are 'trace' or 'info' 

# Container arguments 



example1: build
	docker run -t --rm --hostname redpanda_ci_image --name=redpanda_ci_image --env CREATE_TOPICS=foo,bar,baz ${IMG}


example2: build
	docker run -t --rm --hostname redpanda_ci_image --name=redpanda_ci_image --env CREATE_TOPICS=foo,bar:1,baz:3 ${IMG}


