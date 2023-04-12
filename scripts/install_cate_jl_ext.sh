#!/bin/env bash

CATE_JL_EXT_VERSION=$1;
CATE_JL_EXT_INSTALL_MODE=$2;

echo "###########################################################################"
echo "INSTALLING cate-${CATE_JL_EXT_VERSION} using mode $CATE_JL_EXT_INSTALL_MODE"
echo "###########################################################################"

if [[ $CATE_JL_EXT_INSTALL_MODE == "branch" ]]; then
  mamba install -c conda-forge -c nodefaults jupyterlab jupyter-server-proxy jupyter-packing
  pip install build
  git clone https://github.com/CCI-Tools/cate-jl-ext
  cd cate-jl-ext || exit
  git checkout "${CATE_JL_EXT_VERSION}"
  python setup.py install
  cd ..
  rm -rf cate-jl-ext

elif [[ $CATE_INSTALL_MODE == "release" ]]; then
  mamba install -c conda-forge -c nodefaults jupyterlab jupyter-server-proxy jupyter-packing
  pip install build
  wget https://github.com/CCI-Tools/cate-jl-ext/archive/"${CATE_JL_EXT_VERSION}".tar.gz
  tar xvzf "${CATE_JL_EXT_VERSION}".tar.gz
  cd cate-"${CATE_JL_EXT_VERSION#"v"}" || exit
  python setup.py install
  cd ..
  rm "${CATE_JL_EXT_VERSION}".tar.gz

elif [[ $CATE_INSTALL_MODE == "pip" ]]; then
  pip install cate-jl-ext

else
  echo "Not implemented."
fi


