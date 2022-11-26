#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_REGISTRY="YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner"
export CI_PROJECT_PATH="mariadb"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH"
export TAG="10.5.12"

echo " Push Image => $IMAGE:$TAG"
docker push $IMAGE:$TAG