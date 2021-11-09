#!/bin/env bash


echo "######################"
echo "COPYING MOOC Notebooks"
echo "######################"

git clone https://github.com/CCI-Tools/cate-edu
cd cate-edu || exit
git checkout alicja-xxx-update_of_nbs

COPY --chown=1000:100 ECVs/ /home/jovyan/examples

cd ..
rm -rf cate-edu
