## Changes version 2.0.2

- Added a cate base image configuration
- Cate releases are now installed from ccitools conda repo
- Added browserslist update to webui docker config
- Docker repos are now hosted in bcdev's quay organisation `ccitools`
- Renamed `cate-webui` references to `cate-app`
- The cate webui build process does now run `git clone` if the 
  version tag contains `latest`. Otherwise, it downloads the cate-app version's release
  archive.
- The cate build process does now run `git clone` if the
  version tag contains `latest`. Otherwise, it downloads the cate-app version's release
  archive if version contains `dev` or installs cate from `conda-forge`.

__Versions:__

    MINICONDA_VERSION=4.8.2
    JUPYTER_VERSION=1.1.0
    
    CATE_BASE_VERSION=2.1.0
    CATE_VERSION=2.1.5.dev3
    CATE_WEBUI_VERSION=2.2.2-dev.5
    CATE_USER_NAME=cate
    CATE_DOCKER_VERSION=2.0.2


## Changes version 2.0.1

- Updated .env.webui to latest version for cate app 2.2.2-dev.4
- Updated cate-app version to 2.2.2-dev.4
- Updated cate version to 2.1.5.dev2
- Deploys now on tags only

## Changes version 2.0.0

Set cate webapi version to 2.1.3
