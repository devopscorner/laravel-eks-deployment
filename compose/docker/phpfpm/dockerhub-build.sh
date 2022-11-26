#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container (DockerHub)
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

# export CI_PROJECT_PATH="devopscorner"
# export CI_PROJECT_NAME="phpfpm"

# export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export IMAGE=$4

docker_build() {
  export TAGS_ID=$1
  export FILE=$2
  export CUSTOM_TAGS=$3

  if [ "$CUSTOM_TAGS" = "" ]; then
    echo "Build Image => $IMAGE:${TAGS_ID}"
    echo ">> docker build -t $IMAGE:${TAGS_ID} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .
  else
    echo "Build Image => $IMAGE:${TAGS_ID}"
    echo "docker build -t $IMAGE:${TAGS_ID} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .

    echo "Build Image => $IMAGE:${TAGS_ID}-${CUSTOM_TAGS}"
    docker build -t $IMAGE:${TAGS_ID}-${CUSTOM_TAGS} -f $FILE .
    echo ">> docker build -t $IMAGE:${TAGS_ID}-${CUSTOM_TAGS} -f $FILE ."
  fi
}

main() {
  # docker_build 8.1 Dockerfile-8.1-fpm alpine devopscorner/phpfpm
  # docker_build 8.0 Dockerfile-8.0-fpm alpine devopscorner/phpfpm
  # docker_build 7.4 Dockerfile-7.4-fpm alpine devopscorner/phpfpm
  docker_build $1 $2 $3 $4
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $1 $2 $3 $4
