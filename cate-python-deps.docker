ARG CATE_VERSION
ARG CATE_DOCKER_BUILD

FROM quay.io/bcdev/cate-python-base:${CATE_VERSION}${CATE_DOCKER_BUILD}

ARG CATE_VERSION
ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate python dependencies"
LABEL cate_version=${CATE_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

USER ${CATE_USER_NAME}

RUN whoami
RUN git clone https://github.com/CCI-Tools/cate
RUN mamba env create -f  cate/environment.yml
RUN conda info --envs
RUN source activate cate-env && conda list

CMD ["/bin/bash"]
