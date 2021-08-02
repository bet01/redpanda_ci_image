FROM docker.vectorized.io/vectorized/redpanda:v21.5.7

ENV CREATE_TOPICS=""

COPY docker/redpanda-init.sh /redpanda-init.sh

COPY docker/redpanda.yml /etc/redpanda/redpanda.yml

ENTRYPOINT /redpanda-init.sh ${CREATE_TOPICS}
