#!/bin/env bash


echo "######################"
echo "COPYING MOOC Notebooks"
echo "######################"

git clone https://github.com/CCI-Tools/cate-edu
cd cate-edu || exit
git checkout main

cp -r ECVs/ ~/examples

cd ..
rm -rf cate-edu
