#! /bin/bash
REGISTRY="ghcr.io/hamburg-port-authority"

# parse options
while getopts :r: flag
do
    case "${flag}" in
        r) REGISTRY=${OPTARG};;
    esac
done

# get current tag information
IS_DEV_BUILD=$(git tag -l --contains HEAD)
GIT_TAG=$(git describe --abbrev=0 --tags HEAD)

if [ -z "$IS_DEV_BUILD" ]
then
    TIMESTAMP=$(date +%s)
    TAG=$(echo "$GIT_TAG"-"$TIMESTAMP")
else 
    TAG=$GIT_TAG
fi

echo "Building image with tag $TAG"

docker \
    build . \
    -f Dockerfile \
    -t $(echo "$REGISTRY/appcommons:$TAG")
    