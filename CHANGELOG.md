## Changes in 4.0.1
__Versions:__

    CATE_VERSION=3.1.6
    XCUBE_CCI_VERSION=0.9.8
    XCUBE_VERSION=0.13.0

## Changes in 4.0.0
__Versions:__

    CATE_VERSION=3.1.5
    XCUBE_CCI_VERSION=0.9.8
    XCUBE_VERSION=0.13.0

## Changes in 4.0.0.dev1
__Versions:__

    CATE_VERSION=3.1.4.dev4
    XCUBE_CCI_VERSION=0.9.8.dev1
    XCUBE_VERSION=0.13.0.dev8

## Changes in 4.0.0.dev0
- added argument XCUBE_CCI_INSTALL_MODE to allow using xcube cci code from branches

__Versions:__

    CATE_VERSION=3.1.4.dev4
    XCUBE_CCI_VERSION=0.9.8.dev0
    XCUBE_VERSION=0.13.0.dev8


## Changes in 3.0.1.dev1 
__Versions:__

    CATE_VERSION=3.0.1.dev1
    CATE_APP_VERSION=3.0.0
    XCUBE_CCI_VERSION=0.9.0
    XCUBE_VERSION=0.9.1

## Changes in 2.0.5
- Removed environment.yml
- Removed cate-xcube.dockerfile as xcube is now included in cate
- Added xcube-cci.dockerfile
- Removed maintenance message
- Changed from travis CI to appveyor

__Versions:__

    CATE_VERSION=3.0.0.dev1
    CATE_APP_VERSION=3.0.0-dev.0
    XCUBE_CCI_VERSION=0.8.0

## Changes in 2.0.4

- Set versions to dev versions
- Separated stage and prod images for teh cate-app
- Added install scripts for cate, xcube and xcube-cci
- Introduced an install mode for the libaries used in order to allow installation from either branch, github release or conda
- Added a cate-xcube image configuration to combine
  cate and xcube


## Changes version 2.0.3

- Updated cate version to dev4
- Updated REACT_APP_CATEHUB_ENDPOINT for the cate-app
- Renamed CATE_WEBUI_VERSION to CATE_APP_VERSION

__Versions:__

    MINICONDA_VERSION=4.8.2
    JUPYTER_VERSION=1.1.0
    
    CATE_BASE_VERSION=2.1.0
    CATE_VERSION=2.1.5
    CATE_APP_VERSION=2.2.2
    CATE_USER_NAME=cate

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
    CATE_APP_VERSION=2.2.2-dev.5
    CATE_USER_NAME=cate
    CATE_DOCKER_VERSION=2.0.2


## Changes version 2.0.1

- Updated .env.webui to latest version for cate app 2.2.2-dev.4
- Updated cate-app version to 2.2.2-dev.4
- Updated cate version to 2.1.5.dev2
- Deploys now on tags only

## Changes version 2.0.0

Set cate webapi version to 2.1.3
