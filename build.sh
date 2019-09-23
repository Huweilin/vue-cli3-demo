#!/bin/bash

ENV="prod"

while getopts e: o
do  case "$o" in
  e)  ENV="$OPTARG";;
  [?])  echo >&2 "Usage: $0 [-e env]"
    exit 1;;
  esac
done
shift $(($OPTIND - 1))

# validate options
if [ $ENV != 'test' ] && [ $ENV != 'prod' ]; then
  ENV='prod'
fi


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILES_OR_DIRS_TO_MOUNT=(
src
build
config
static
index.html
.babelrc
.postcssrc.js
package.json
dist
)
DOCKER_IMAGE_NAME="demo/web"

DOCKER_MOUNT_STR=''
for f in "${FILES_OR_DIRS_TO_MOUNT[@]}"
do
  DOCKER_MOUNT_STR="${DOCKER_MOUNT_STR} -v ${SCRIPT_DIR}/${f}:/usr/src/app/${f}"
done

echo "==> Start building package for [${ENV}]."
docker run --rm ${DOCKER_MOUNT_STR} ${DOCKER_IMAGE_NAME}:base npm run build:${ENV}
if [ $? -ne 0 ]; then
  echo "Webpack build failed."
  exit 1
fi
echo "==> Finished building package."
echo "==> Start building docker image for [${ENV}]."

cd ${SCRIPT_DIR}
docker build -t "${DOCKER_IMAGE_NAME}:${ENV}" .
docker tag "${DOCKER_IMAGE_NAME}:${ENV}" "docker-registry.changqi.prod.ywqian.com/${DOCKER_IMAGE_NAME}:${ENV}"
echo "==> Built docker image \"docker-registry.changqi.prod.ywqian.com/${DOCKER_IMAGE_NAME}:${ENV}\" successfully!"
