#!/usr/bin/env bash
REMOTE=
TOKEN=
DIGEST=
UPSTREAM="localhost:8080"
docker run \
--interactive --tty \
--net=host \
--env=REMOTE=${REMOTE} \
--env=TOKEN=${TOKEN} \
inlets/inlets@${DIGEST} \
client \
--remote=${REMOTE} \
--upstream=${UPSTREAM} \
--token=${TOKEN} 
