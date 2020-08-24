[![Build Status](https://travis-ci.org/CCI-Tools/cate-docker.svg?branch=master)](https://travis-ci.org/CCI-Tools/cate-docker)

# Cate Docker Images

This repository aims at providing a configuration for a docker base image
that can be used to run cate services like `cate-webapi-start`.

## Cate Image

[![Docker Repository on Quay](https://quay.io/repository/bcdev/cate/status "Docker Repository on Quay")](https://quay.io/repository/bcdev/cate)


## Cate WebAPI for K8s Image

[![Docker Repository on Quay](https://quay.io/repository/bcdev/cate-webapi-k8s/status "Docker Repository on Quay")](https://quay.io/repository/bcdev/cate-webapi-k8s)


## Cate Webui

[![Docker Repository on Quay](https://quay.io/repository/bcdev/cate-webui/status "Docker Repository on Quay")](https://quay.io/repository/bcdev/cate-webui)

## Running cate from the docker base container using this image

Cate for docker is currently hosted on quay.io. Hence, use the following
command in order to run cate:

```shell script
docker run -it quay.io/bcdev/cate-webapi bash
```

This will open a bash session with an activated cate Python environment. However,
if you want to make this session a bitmore useful, mount a volume e.g the current directory:

```shell script
docker run -it -v $PWD:/workspace quay.io/bcdev/cate bash
```

The following docker-compose configuration can be used to run cate, here, its web service.
 

```yaml
version: "3.7"
services:
  cate:
    image: quay.io/bcdev/cate
    user: cate
    expose:
      - 4000
    ports:
      - 4000:4000
    command: ["/bin/bash", "-c", "source activate cate-env && cate-webapi-start -v -p 4000 -a 0.0.0.0"] 
```

cate-docker has been used in K8s deployments. 

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cate-serve
  labels:
    app: cate-serve
spec:
  selector:
    matchLabels:
      app: cate-serve
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: cate-serve
    spec:
      containers:
        - image: quay.io/bcdev/cate
          name: cate-serve
          command: ["/bin/bash"]
          args: ["-c", "source activate cate-env && cate-webapi-start -v -p 4000 -a 0.0.0.0"]
          ports:
            - containerPort: 4000
              name: cate-serve
```


## Release process Python Base Image

The purpose of teh Python base image is to deliver and 

- Clone or fork [cate-docker repositiry](https://github.com/CCI-Tools/cate-docker.
- Create a new branch called [your_user_name]_[new_version]
- Change Miniconda Version and increase CATE_PYTHON_BASE_VERSION in cate-python-base/Dockerfile
- Push and commit your branch
- Monitor building process on that has been started on quay.io 
- If the build succeeds, create a pull request and request reviewers
- Once approved merge the PR
- Check again whether the build succeeds. Be aware that from that moment
  your the version `latest` will be updated
- Change cat

## Release process case-base

cate-docker is hosted on quay.io. quay.io is configured so it automatically starts building processes on each 
push to [cate-dcker's GitHub](https://github.com/CCI-Tools/cate-docker). The docker image version 
tag is set by the name of the branch which includes version and release tags. 

Therefore, use the following steps to release a new cate docker image:

- Clone or fork [cate-docker repositiry](https://github.com/CCI-Tools/cate-docker.
- Create a new branch called [your_user_name]_[new_version]
- Make sure that the cate version you are building for has been released
- Edit the Dockerfile and change `ARG CATE_VERSION=[new_version]` reflecting the new version tag
- Push the changes to your branch
- Monitor building process on that has been started on quay.io 
- If the build succeeds, create a pull request and request reviewers
- Once approved merge the PR
- Check again whether the build succeeds. Be aware that from that moment
  your the version `latest` will be updated


 
