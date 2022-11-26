#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_REGISTRY="YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner"
export CI_PROJECT_PATH="phpfm"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH"
export TAG="8.1-fpm"

echo " Build Image => $IMAGE:$TAG"
docker build . -t $IMAGE:$TAG