#!/usr/bin/env bash

mkidr -p whisper grafana >/dev/null 2>&1
sudo docker run -d \
    -p 127.0.0.1:2003:2003 \
    -p 127.0.0.1:3000:3000 \
    -v whisper:/opt/grafana/storage/whisper \
    ubuntu/grafana