FROM node:stretch-slim as build-deps

ARG CATE_VERSION
ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME
ARG CATE_APP_VERSION
ARG CATE_MODE=stage
ARG CATE_APP_INSTALL_MODE

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate webui"
LABEL cate_version=${CATE_VERSION}
LABEL cate_webui_version=${CATE_APP_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

RUN apt-get -y update && apt-get install -y git wget

SHELL ["/bin/bash", "-c"]

RUN echo "##########################################"
RUN echo ${CATE_APP_VERSION}
RUN echo "##########################################"

RUN mkdir /usr/src/app

RUN if [[ ${CATE_APP_INSTALL_MODE} == "branch" ]]; then \
        echo "-------------------------------------------------"; \
        echo "Loading Stage dev version ${CATE_APP_VERSION}"; \
        echo "-------------------------------------------------"; \
        git clone https://github.com/CCI-Tools/cate-app /usr/src/app/cate-app-${CATE_APP_VERSION}; \
        cd /usr/src/app/cate-app-${CATE_APP_VERSION}; \
        git checkout ${CATE_APP_VERSION}; \
    else \
        echo "-------------------------------------------------"; \
        echo "Loading release ${CATE_APP_VERSION}"; \
        echo "-------------------------------------------------"; \
        wget https://github.com/CCI-Tools/cate-app/archive/v${CATE_APP_VERSION}.tar.gz; \
        tar xvf v${CATE_APP_VERSION}.tar.gz -C /usr/src/app ; \
    fi

RUN ls -al /usr/src/app

WORKDIR /usr/src/app/cate-app-${CATE_APP_VERSION}

RUN yarn install --network-concurrency 1 --network-timeout 1000000

RUN echo "##### Using mode ${CATE_MODE} #####"
ADD .env.webui.${CATE_MODE} .env.production

RUN npx browserslist@latest --update-db
RUN yarn build
RUN yarn global add serve

CMD ["bash", "-c", "serve -l 80 -d -s build"]
