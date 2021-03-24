ARG CATE_BASE_VERSION

FROM quay.io/ccitools/cate-base:${CATE_BASE_VERSION}

ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME
ARG CATE_VERSION
ARG CATE_BASE_VERSION
ARG CATE_INSTALL_MODE

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=cate
LABEL cate_version=CATE_VERSION
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

RUN echo "Building docker using args:"
RUN echo "CATE_VERSION:${CATE_VERSION}"

# STAGE LINUX/CONDA BASICS
SHELL ["/bin/bash", "-c"]

USER ${CATE_USER_NAME}

WORKDIR /tmp

# STAGE CATE DOWNLOAD

ARG CATE_VERSION

RUN whoami

COPY environment.yml /tmp/environment.yml
COPY scripts/install_cate.sh ./
RUN bash ./install_cate.sh



# STAGE INSTALL CONDA DEPENDENCIES

RUN conda info --envs
RUN source activate cate-env && conda list


#USER ${CATE_USER_NAME}

WORKDIR /home/${CATE_USER_NAME}

CMD ["/bin/bash", "-c", "source activate cate-env && cate-webapi-start -v -p 4000 -a 0.0.0.0"]
