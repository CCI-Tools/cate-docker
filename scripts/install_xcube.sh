#!/bin/env bash

echo "###################################################################"
echo "INSTALLING xcube-${XCUBE_VERSION} using mode $XCUBE_INSTALL_MODE"
echo "###################################################################"

source activate cate-env

if [[ $XCUBE_INSTALL_MODE == "branch" ]]; then
  git clone https://github.com/dcs4cop/xcube
  cd xcube || exit
  git checkout "${XCUBE_VERSION}"

  conda info --envs

  mamba env update -n cate-env
  pip install .

  cd ..
  rm -rf xcube
elif [[ $XCUBE_INSTALL_MODE == "github" ]]; then
  wget https://github.com/dcs4cop/xcube/archive/v"${XCUBE_VERSION}".tar.gz
  tar xvzf v"${XCUBE_VERSION}".tar.gz

  cd xcube-"${XCUBE_VERSION}" || exit

  mamba env update -n cate-env
  pip install .

  cd ..
  rm v"${XCUBE_VERSION}".tar.gz
else
  mamba update -y -n cate-env -c conda-forge xcube="${XCUBE_VERSION}"
fi

