#!/usr/bin/env bash

export GRAFANA_URL="http://www.bizhishu.net"
export GRAFANA_PASSWORD=`pwgen 12 1`

sudo docker build -t ubuntu/grafana --build-arg GRAFANA_URL=$GRAFANA_URL --build-arg GRAFANA_PASSWORD=$GRAFANA_PASSWORD .

echo "Build done! Password: $GRAFANA_PASSWORD";

DePhee0Vohgh