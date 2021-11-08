ARG JUPYTER_VERSION
FROM jupyter/scipy-notebook:${JUPYTER_VERSION}

ARG CATE_INSTALL_MODE
ARG CATE_VERSION
ARG XCUBE_VERSION
ARG XCUBE_CCI_VERSION

# Person responsible
LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=cate-jupyter

RUN echo "cate version: ${CATE_VERSION}";\
    echo "cate install mode: ${CATE_INSTALL_MODE}";\
    echo "xcube version: ${XCUBE_VERSION}";\
    echo "xcube cci version: ${XCUBE_CCI_VERSION}"

# Update OS and install
USER root
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
        dnsutils \
        git \
        iputils-ping \
 && rm -rf /var/lib/apt/lists/*
USER $NB_USER

RUN conda install -n base -c conda-forge mamba pip

WORKDIR /tmp

COPY scripts/install_cate.sh .
RUN . install_cate.sh

WORKDIR /tmp/cate

RUN source activate base && mamba install -c conda-forge xcube=${XCUBE_VERSION} xcube-cci=${XCUBE_CCI_VERSION}

RUN mamba install -n base -y  -c conda-forge jupyterlab-git jupyterlab-drawio jupyterlab_code_formatter jupyterlab-spellchecker
RUN source activate base && pip install nb_black jupyterlab-geojson
RUN source activate base && mamba install -n base -y  -c conda-forge nbgitpuller cartopy
RUN source activate base && jupyter serverextension enable --py nbgitpuller --sys-prefix

WORKDIR $HOME
