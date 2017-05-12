# docker-graphite-grafana

A docker container that contains latest graphite/grafana packages.

# System information

## Packages

  - ubuntu: 16.04
  - carbon + whisper + graphite-web: 1.0.1
  - grafana: latest from the official repository

## Exposed ports

  - 2003, 2004, 7002: for carbon
  - 8081: for graphite-web
  - 3000: for grafana
  
# Build and run this container

## Build and tag image

To build it with default grafana username and password (grafana:grafana):  

    $ docker build -t ubuntu/grafana .

To build it with customized grafana username and password, and a customized url:  

    $ docker biuld -t ubuntu/grafana --build-arg GRAFANA_USERNAME=grafana GRAFANA_PASSWORD=4WjsHqLUNWyy GRAFANA_URL=http://www.example/grafana .

## Run your build

    $ docker run -p 127.0.0.1:2003:2003 -p 127.0.0.1:3000:3000 ubuntu/grafana

# Access grafana dashboard

Open your browser and visit http://127.0.0.1:3000 

# Acknowlegement

This repository borrowed a lot of code from: https://github.com/nickstenning/docker-graphite
