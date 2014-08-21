#!/bin/bash

sudo docker rm shipyard > /dev/null 2>&1

SHIPYARD=$(docker run \
    --name shipyard \
	-p 8005:8000 \
	-d \
	shipyard/shipyard)

echo "Started SHIPYARD in container $SHIPYARD"