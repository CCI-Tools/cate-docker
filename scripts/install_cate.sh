#!/bin/env bash


if [[ $CATE_VERSION == *"dev"* ]]; then
  echo "-------------------------------------------------";
  echo "Installing dev version ${CATE_VERSION}"           ;
  echo "-------------------------------------------------";

  wget https://github.com/CCI-Tools/cate/archive/v"${CATE_VERSION}".tar.gz
  tar xvzf v"${CATE_VERSION}".tar.gz

  cd cate-"${CATE_VERSION}" || exit

  mamba env create .
  source activate cate-env && pip install .
  echo "conda activate cate-env" >> ~/.bashrc
else
  echo "-------------------------------------------------";
  echo "Installing release version ${CATE_VERSION}" ;
  echo "-------------------------------------------------";

  mamba create -y -n cate-env -c ccitools cate="${CATE_VERSION}"
  echo "conda activate cate-env" >> ~/.bashrc
fi
