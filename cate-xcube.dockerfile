ARG CATE_VERSION

FROM quay.io/ccitools/cate:${CATE_VERSION}

ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME
ARG CATE_VERSION
ARG CATE_BASE_VERSION
ARG CATE_INSTALL_MODE
ARG XCUBE_INSTALL_MODE
ARG XCUBE_VERSION
ARG XCUBE_CCI_INSTALL_MODE
ARG XCUBE_CCI_VERSION

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

# STAGE XCUBE DOWNLOAD

RUN whoami
COPY scripts/install_xcube.sh ./
RUN bash ./install_xcube.sh

COPY scripts/install_xcube_cci.sh ./
RUN bash ./install_xcube_cci.sh


# STAGE INSTALL XCUBE DEPENDENCIES

RUN conda info --envs
#RUN source activate cate-env && conda list

USER ${CATE_USER_NAME}

WORKDIR /home/${CATE_USER_NAME}
