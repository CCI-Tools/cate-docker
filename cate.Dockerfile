ARG XCUBE_VERSION
FROM quay.io/bcdev/xcube:${XCUBE_VERSION}

ARG XCUBE_VERSION
ARG XCUBE_CCI_INSTALL_MODE
ARG XCUBE_CCI_VERSION

# Person responsible
LABEL maintainer="tejas.morbagalharish@brockmann-consult.de"
LABEL name=cate

RUN echo "xcube install mode: ${XCUBE_CCI_INSTALL_MODE}";\
    echo "xcube cci version: ${XCUBE_CCI_VERSION}"; \

WORKDIR /tmp/cate

COPY scripts/install_xcube.sh .
RUN . install_xcube.sh xcube-cci ${XCUBE_CCI_VERSION} ${XCUBE_CCI_INSTALL_MODE}
COPY scripts/install_cate.sh .
RUN . install_cate.sh

WORKDIR $HOME