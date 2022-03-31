#!/bin/bash
set -xe

#Working directory : default-config
cd default-config && scripts/package.sh && cd ..
cp default-config/target/default_config.zip bahmni-india-package/bahmni-web/resources/

cd bahmni-india-package/bahmni-web
rm -rf build/
mkdir build/

# Unzipping Resources
unzip -q -u -d build/default_config resources/default_config.zip
unzip -q -u -d build/NDHMReact resources/ndhm-react.zip
cp -a build/NDHMReact/build/. build/NDHMReact/
rm -rf build/NDHMReact/build/

#Building Docker images
BAHMNI_WEB_IMAGE_TAG=${BAHMNI_VERSION}-${GITHUB_RUN_NUMBER}
docker build -t bahmni/bahmni-web:${BAHMNI_WEB_IMAGE_TAG} -f docker/Dockerfile  . --no-cache
