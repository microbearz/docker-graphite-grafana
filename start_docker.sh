#!/usr/bin/env bash

mkidr -p whisper grafana >/dev/null 2>&1
sudo docker run -d \
    -p 2003:2003 \
    -p 3000:3000 \
    -v whisper:/opt/grafana/storage/whisper \
    -v grafana:/var/lib/grafana \
    ubuntu/grafana