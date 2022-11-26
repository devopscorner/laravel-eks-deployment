#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Tag Container (DockerHub)
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

# export CI_PROJECT_PATH="devopscorner"
# export CI_PROJECT_NAME="phpfpm"

# export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export IMAGE=$3

# export ALPINE_VERSION="3.16"

set_tag() {
  export TAGS_ID=$1
  export CUSTOM_TAGS=$2
  export BASE_IMAGE="$IMAGE:${TAGS_ID}"
  export COMMIT_HASH=`git log -1 --format=format:"%H"`

  if [ "$CUSTOM_TAGS" = "" ]; then
    export TAGS="${TAGS_ID} \
    ${TAGS_ID}-latest \
    ${TAGS_ID}-${COMMIT_HASH}"
  else
    export TAGS="${TAGS_ID} \
    ${TAGS_ID}-latest \
    ${TAGS_ID}-${CUSTOM_TAGS} \
    ${TAGS_ID}-${COMMIT_HASH}"
  fi
}

docker_tag() {
  for TAG in $TAGS; do
    echo "Docker Tags => $IMAGE:$TAG"
    echo ">> docker tag $BASE_IMAGE $IMAGE:$TAG"
    docker tag $BASE_IMAGE $IMAGE:$TAG
    echo '- DONE -'
    echo ''
  done
}

main() {
  # set_tag alpine latest devopscorner/phpfpm
  # set_tag alpine 8.1 devopscorner/phpfpm
  # set_tag alpine 8.0 devopscorner/phpfpm
  # set_tag alpine 7.4 devopscorner/phpfpm
  set_tag $1 $2 $3
  docker_tag
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $1 $2 $3
