FROM docker.vectorized.io/vectorized/redpanda:v21.5.7

RUN sudo apt-get install -y curl

ENV CREATE_TOPICS=""

COPY docker/redpanda-init.sh /redpanda-init.sh

COPY docker/redpanda.yml /etc/redpanda/redpanda.yml

HEALTHCHECK CMD /usr/bin/curl http://localhost:9644/metrics

ENTRYPOINT /redpanda-init.sh ${CREATE_TOPICS}
