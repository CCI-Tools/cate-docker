ARG CATE_VERSION

FROM quay.io/bcdev/cate:${CATE_VERSION}

ARG CATE_VERSION
ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate webapi for k8s"
LABEL cate_version=${CATE_VERSION}
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

USER ${CATE_USER_NAME}

RUN source activate cate-env && mamba install -y jupyterhub=0.9.6 jupyterlab

WORKDIR "/home/${CATE_USER_NAME}"

EXPOSE 8888

CMD ["/bin/bash", "-c", "source activate cate-env && cate-webapi-start -v -p 8888 -a 0.0.0.0"]
