#!/bin/env bash

CATE_VERSION=$1;
CATE_INSTALL_MODE=$2;

echo "###################################################################"
echo "INSTALLING cate-${CATE_VERSION} using mode $CATE_INSTALL_MODE"
echo "###################################################################"

if [[ $CATE_INSTALL_MODE == "branch" ]]; then
  git clone https://github.com/CCI-Tools/cate
  cd cate || exit
  git checkout "${CATE_VERSION}"
  pip install -e .
  cd ..
  rm -rf cate
elif [[ $CATE_INSTALL_MODE == "release" ]]; then
  wget https://github.com/CCI-Tools/cate/archive/"${CATE_VERSION}".tar.gz
  tar xvzf "${CATE_VERSION}".tar.gz
  cd cate-"${CATE_VERSION#"v"}" || exit
  pip install -e .
  cd ..
  rm "${CATE_VERSION}".tar.gz
else
  echo "Not implemented."
fi


#echo "conda activate cate-env" >> ~/.bashrc

