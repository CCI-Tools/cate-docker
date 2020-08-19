FROM node:stretch-slim as build-deps

ARG CATE_VERSION
ARG CATE_WEBUI_VERSION
ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate webui"
LABEL cate_version=${CATE_VERSION}
LABEL cate_webui_version=${CATE_WEBUI_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

RUN apt-get -y update && apt-get install -y git apt-utils

RUN git clone https://github.com/CCI-Tools/cate-webui /usr/src/app
WORKDIR /usr/src/app

RUN yarn install --network-concurrency 1 --network-timeout 1000000

RUN yarn build
RUN yarn global add serve

CMD ["bash", "-c", "serve -l 80 -d -s build"]
