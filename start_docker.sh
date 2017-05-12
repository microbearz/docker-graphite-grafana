#!/usr/bin/env bash

mkidr -p data/whisper data/grafana >/dev/null 2>&1
sudo docker run \
    -p 2003:2003 \
    -p 3000:3000 \
    -v data/whisper:/opt/grafana/storage/whisper \
    -v data/grafana:/var/lib/grafana \
    ubuntu/grafana