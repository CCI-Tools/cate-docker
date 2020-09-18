ARG MINICONDA_VERSION

FROM continuumio/miniconda3:${MINICONDA_VERSION}

ARG CATE_DOCKER_VERSION
ARG CATE_USER_NAME
ARG CATE_VESION

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=cate
LABEL cate_version=CATE_VERSION
LABEL cate_docker_version=${CATE_DOCKER_VERSION}

RUN echo "Building docker using args:"
RUN echo "CATE_VERSION:${CATE_VERSION}"

# STAGE LINUX/CONDA BASICS
SHELL ["/bin/bash", "-c"]

USER root
RUN apt-get -y update && apt-get -y install vim

SHELL ["/bin/bash", "-c"]
RUN groupadd -g 1000 ${CATE_USER_NAME}
RUN useradd -u 1000 -g 1000 -ms /bin/bash ${CATE_USER_NAME}
#RUN mkdir /workspace && chown ${CATE_USER_NAME}.${CATE_USER_NAME} /workspace
COPY --chown=1000:1000 bashrc /home/${CATE_USER_NAME}/.bashrc
RUN chown -R ${CATE_USER_NAME}.${CATE_USER_NAME} /opt/conda

USER ${CATE_USER_NAME}

WORKDIR /tmp

RUN source activate base && conda update -n base conda && conda init
RUN source activate base && conda install -y -c conda-forge mamba

RUN echo "conda activate cate-env" >> ~/.bashrc

# STAGE CATE DOWNLOAD

ARG CATE_VERSION

RUN whoami
RUN if [[ ${CATE_VERSION} == *"dev"* ]]; then \
            echo "-------------------------------------------------"; \
            echo "Loading dev version ${CATE_VERSION}"; \
            echo "-------------------------------------------------"; \
            git clone https://github.com/CCI-Tools/cate cate-${CATE_VERSION}; \
     else \
            echo "-------------------------------------------------"; \
            echo "Loading release ${CATE_VERSION}"; \
            echo "-------------------------------------------------"; \
            wget https://github.com/CCI-Tools/cate/archive/v${CATE_VERSION}.tar.gz; \
            tar xvf v${CATE_VERSION}.tar.gz; \
    fi

# STAGE INSTALL CONDA DEPENDENCIES

RUN mamba env create -f cate-${CATE_VERSION}/environment.yml
RUN conda info --envs
RUN source activate cate-env && conda list

# STAGE INSTALL CATE

RUN source activate cate-env && cd cate-${CATE_VERSION} && pip install .

#USER ${CATE_USER_NAME}

WORKDIR /home/${CATE_USER_NAME}

CMD ["/bin/bash", "-c", "source activate cate-env && cate-webapi-start -v -p 4000 -a 0.0.0.0"]
