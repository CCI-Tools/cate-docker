[![Build Status](https://travis-ci.org/CCI-Tools/cate-docker.svg?branch=master)](https://travis-ci.org/CCI-Tools/cate-docker)

# Cate Docker Images

This repository aims at providing a configuration for a docker base image
that can be used to run cate services. Main aim is to configure cate to run in a K8s environment.

## Images that will be built

- cate: Cate base image
- cate-jupyter: Inherits from cate but adds jupyter lab and jupyterhub  
- cate-webui: The React webui for cate

## Prerequisites for your local Computer

- docker
- docker-compose
- git

## Running cate from the docker base container using this image

Cate for docker is currently hosted on quay.io. Hence, use the following
command in order to run cate:

```shell script
docker run -it quay.io/bcdev/cate bash
```

This will open a bash session with an activated cate Python environment. However,
if you want to make this session a bitmore useful, mount a volume e.g the current directory:

```shell script
docker run -it -v $PWD:/workspace quay.io/bcdev/cate bash
```

The following docker-compose configuration can be used to run cate, here, its web service.
 

## Release process for teh cate Docker Image

- Clone or fork [cate-docker repository](https://github.com/CCI-Tools/cate-docker.
- Create a new branch called [your_user_name]_[new_version]
- Change Miniconda Version if necessary in .env
- Change cate version in .env
- Push and commit your branch
- run `docker-compose build` to test whether the images build
- Once approved merge the PR
- Check travis whether your build succeeds
- Check quay.io whether your version has been pushed  

## Using these images locally

Cate versions will have a .dev* suffix during the development stage. These versions will not autoimatically pushed
to quay.io. These versions need to be manually pushed using:

```bash
docker-compose push
```    

## Software Versions used in 0.1.3

| Software   | Version |
|------------|---------|
| cate       | 2.1.0   |
| cate-webui | 2.1.0   |
| miniconda  | 4.8.2   |
| jupyter    | 0.9.6   |
