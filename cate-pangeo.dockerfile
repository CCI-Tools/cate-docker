ARG PANGEO_BASE_NOTEBOOK_VERSION

FROM pangeo/base-notebook:${PANGEO_BASE_NOTEBOOK_VERSION}

ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME
ARG CATE_VERSION
ARG CATE_BASE_VERSION

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate webapi for k8s"
LABEL cate_version=${CATE_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

USER root

RUN apt-get update -y && apt-get upgrade -y

USER jovyan

RUN conda install -c conda-forge -n base mamba
RUN conda install -n base nb_conda_kernels

WORKDIR /tmp

RUN wget https://github.com/CCI-Tools/cate/archive/v${CATE_VERSION}.tar.gz
RUN tar xvf  v${CATE_VERSION}.tar.gz

WORKDIR /tmp/cate-${CATE_VERSION}
RUN mamba env create
RUN source activate cate-env && pip install .
RUN source activate cate-env && conda install ipykernel

RUN source activate cate-env && mamba install -c conda-forge xcube
RUN source activate cate-env && mamba install -c conda-forge xcube-cci
RUN source activate cate-env && mamba install -c conda-forge xcube-sh
RUN source activate cate-env && mamba install -c conda-forge xcube-cds
