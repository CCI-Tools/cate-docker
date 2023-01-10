ARG JUPYTER_VERSION
FROM jupyter/scipy-notebook:${JUPYTER_VERSION}

ARG CATE_INSTALL_MODE
ARG CATE_VERSION
ARG XCUBE_INSTALL_MODE
ARG XCUBE_VERSION
ARG XCUBE_CCI_VERSION
ARG INSTALL_MOOC

# Person responsible
LABEL maintainer="tonio.fincke@brockmann-consult.de"
LABEL name=cate-jupyter

RUN echo "cate version: ${CATE_VERSION}";\
    echo "cate install mode: ${CATE_INSTALL_MODE}";\
    echo "xcube install mode: ${XCUBE_INSTALL_MODE}";\
    echo "xcube version: ${XCUBE_VERSION}";\
    echo "xcube install mode: ${XCUBE_CCI_INSTALL_MODE}";\
    echo "xcube cci version: ${XCUBE_CCI_VERSION}";\
    echo "install mooc notebooks: ${INSTALL_MOOC}"

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

COPY scripts/install_xcube.sh .
RUN . install_xcube.sh xcube ${XCUBE_VERSION} ${XCUBE_INSTALL_MODE}
RUN . install_xcube.sh xcube-cci ${XCUBE_CCI_VERSION} ${XCUBE_CCI_INSTALL_MODE}

COPY scripts/install_cate.sh .
RUN . install_cate.sh

COPY scripts/install_mooc_nbs.sh .
RUN if [[ ${INSTALL_MOOC} == '1' ]]; then . install_mooc_nbs.sh; fi;

COPY scripts/install_beginners_notebook.sh .
RUN . install_beginners_notebook.sh

WORKDIR /tmp/cate

RUN source activate base && mamba install -n base -y -c conda-forge jupyterlab-git jupyterlab-drawio jupyterlab_code_formatter jupyterlab-spellchecker nbgitpuller cartopy graphviz
RUN mamba install -n base -y -c conda-forge rasterio=1.2.4

RUN pip install nb_black jupyterlab-geojson
RUN jupyter serverextension enable --py nbgitpuller --sys-prefix

WORKDIR $HOME
