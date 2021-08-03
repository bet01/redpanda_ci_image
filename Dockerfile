FROM docker.vectorized.io/vectorized/redpanda:v21.5.7

ENV CREATE_TOPICS=""

COPY docker/redpanda-init.sh /redpanda-init.sh

COPY docker/redpanda.yml /etc/redpanda/redpanda.yml

HEALTHCHECK CMD timeout 1m bash -c '
          until curl -f localhost:9644/metrics
          do echo plantuml - trying to determine if server running ; sleep 20
          done
         '

ENTRYPOINT /redpanda-init.sh ${CREATE_TOPICS}
