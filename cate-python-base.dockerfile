ARG MINICONDA_VERSION

FROM continuumio/miniconda3:${MINICONDA_VERSION}

ARG CATE_VERSION
ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate miniconda base"
LABEL cate_version=${CATE_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

USER root
RUN apt-get -y update && apt-get -y install vim

SHELL ["/bin/bash", "-c"]
RUN groupadd -g 1000 ${CATE_USER_NAME}
RUN useradd -u 1000 -g 1000 -ms /bin/bash ${CATE_USER_NAME}
RUN mkdir /workspace && chown ${CATE_USER_NAME}.${CATE_USER_NAME} /workspace
COPY --chown=1000:1000 bashrc /home/${CATE_USER_NAME}/.bashrc
RUN chown -R ${CATE_USER_NAME}.${CATE_USER_NAME} /opt/conda

USER ${CATE_USER_NAME}

WORKDIR /workspace

RUN source activate base && conda update -n base conda && conda init
RUN source activate base && conda install -y -c conda-forge mamba

RUN echo "conda activate cate-env" >> ~/.bashrc

CMD ["/bin/bash"]
