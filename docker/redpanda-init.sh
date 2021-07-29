#!/bin/bash

CREATE_TOPICS=$@

echo "initializing redpanda-init wrapper"
echo "creating the following topics: ${CREATE_TOPICS}"

IFS=', ' read -r -a topics <<< ${CREATE_TOPICS:?must specify topics as Docker argument CREATE_TOPICS}

# create topic bash function - 
# parses the rpk command output and produces true/false or exit 1 depending on the output
function create_topic() {
  topic=$1
  res=$(rpk topic create $topic 2>&1)
  if [[ $res =~ "Topic with this name already exists" || $res =~ "Created topic" ]]; then
    echo "topic now exists: ${topic}"
    true
  elif [[ $res =~ "Error: couldn't connect" ]]; then
    echo "couldn't connect to server creating topic: ${topic}"
    false
  else
    echo "unexpected response creating topic: ${topic} from rpk: ${res}" >/dev/stderr
    exit 1
  fi
}

#start rpk in the background
/usr/bin/rpk \
  redpanda \
  start \
  --smp \
  "1" \
  --reserve-memory \
  0M \
  --overprovisioned \
  --node-id \
  "0" \
  --kafka-addr \
  PLAINTEXT://0.0.0.0:29092,OUTSIDE://0.0.0.0:9092 \
  --advertise-kafka-addr \
  PLAINTEXT://$(hostname -f):29092,OUTSIDE://127.0.0.1:9092 &

#capture pid of rpk process
rpk_pid=$!

# get length of topics array
topicslength=${#topics[@]}

# iterate over topics array and use until/sleep to repeatedly attempt to create topic until 
# create_topic() function returns true or exits the script with failure (1) return value
for ((i = 0; i < ${topicslength}; i++)); do
  topic=${topics[$i]}
  until create_topic $topic; do
    sleep 4
    echo attempting to create topic $topic
  done
done

# block until backgrounded rpk process completes
wait $rpk_pid
