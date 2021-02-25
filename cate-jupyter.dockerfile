ARG CATE_VERSION

FROM quay.io/ccitools/cate:${CATE_VERSION}

ARG CATE_VERSION
ARG CATE_DOCKER_VERSION
ARG JUPYTER_VERSION
ARG CATE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate webapi for k8s"
LABEL cate_version=${CATE_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

USER ${CATE_USER_NAME}

RUN source activate cate-env && mamba install -y -c conda-forge jupyterhub=${JUPYTER_VERSION} jupyterlab

WORKDIR "/home/${CATE_USER_NAME}"

EXPOSE 8888

CMD ["/bin/bash", "-c", "source activate cate-env && jupyter lab --ip=0.0.0.0 --port=8888"]
