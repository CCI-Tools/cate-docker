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
elif [[ $CATE_VERSION == *"latest" ]]; then
  echo "-------------------------------------------------";
  echo "Installing dev version ${CATE_VERSION}"           ;
  echo "-------------------------------------------------";

  git clone https://github.com/CCI-Tools/cate

  cd cate || exit

  mamba env create .
  source activate cate-env && pip install .
else
  echo "-------------------------------------------------";
  echo "Installing release version ${CATE_VERSION}" ;
  echo "-------------------------------------------------";

  mamba create -y -n cate-env -c ccitools cate="${CATE_VERSION}"
fi

echo "conda activate cate-env" >> ~/.bashrc