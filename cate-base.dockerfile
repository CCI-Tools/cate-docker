ARG MINICONDA_VERSION

FROM continuumio/miniconda3:${MINICONDA_VERSION}

ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME
ARG CATE_BASE_VERSION

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=cate
LABEL cate_base_version=CATE_BASE_VESION
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

RUN echo "Building cate base image using args:"
RUN echo "CATE_BASE_VERSION:${CATE_BASE_VERSION}"
RUN echo "CATE_DOCKER_VERSION:${CATE_DOCKER_VERSION}"

# STAGE LINUX/CONDA BASICS
SHELL ["/bin/bash", "-c"]

USER root
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install vim

SHELL ["/bin/bash", "-c"]
RUN groupadd -g 1000 ${CATE_USER_NAME}
RUN useradd -u 1000 -g 1000 -ms /bin/bash ${CATE_USER_NAME}
COPY --chown=1000:1000 bashrc /home/${CATE_USER_NAME}/.bashrc
RUN chown -R ${CATE_USER_NAME}.${CATE_USER_NAME} /opt/conda

RUN source activate base && conda update -n base conda && conda init
RUN source activate base && conda install -y -c conda-forge mamba

CMD ["/bin/bash"]