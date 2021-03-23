#!/bin/env bash


echo "###################################################################"
echo "INSTALLING cate-${CATE_VERSION} using mode $CATE_INSTALL_MODE"
echo "###################################################################"

if [[ $CATE_INSTALL_MODE == "branch" ]]; then
  git clone https://github.com/CCI-Tools/cate
  cd cate || exit
  git checkout "${CATE_VERSION}"


  mamba env create .
  source activate cate-env
  python setup.py install

  cd ..
  rm -rf cate
elif [[ $CATE_INSTALL_MODE == "github" ]]; then
  wget https://github.com/CCI-Tools/cate/archive/v"${CATE_VERSION}".tar.gz
  tar xvzf v"${CATE_VERSION}".tar.gz

  cd cate-"${CATE_VERSION}" || exit

  mamba env create .
  source activate cate-env
  python setup.py install

  cd ..
  rm v"${CATE_VERSION}".tar.gz
else
  echo "Not implemented."
fi


echo "conda activate cate-env" >> ~/.bashrc

