# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache version 2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_APP=`pwd`
export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_HELM="helm/Chart"
export PATH_COMPOSE="."
export PATH_DOCKER="."
export PROJECT_NAME="infra-laravel-deployment"
export PROJECT_NAMESPACE="laravel-app"
export TF_PATH="terraform/environment/providers/aws/infra"
export TF_CORE="$(TF_PATH)/core"
export TF_RESOURCES="$(TF_PATH)/resources"
export TF_STATE="$(TF_PATH)/tfstate"

export TF_MODULES="terraform/modules/providers/aws"

export CI_REGISTRY     ?= $(ARGS).dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= laravel

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.3.0

export BASE_IMAGE=ubuntu
export BASE_VERSION=22.04
export LARAVEL_VERSION=22.04
export LARAVEL_VERSION=8.65

# =============== #
#   GET MODULES   #
# =============== #
.PHONY: sub-officials sub-community sub-all codebuild-modules
sub-officials:
	@echo "=============================================================="
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@mkdir -p $(TF_MODULES)/officials
	@cd $(PATH_APP) && ./get-officials.sh

sub-community:
	@echo "=============================================================="
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@mkdir -p $(TF_MODULES)/community
	@cd $(PATH_APP) && ./get-community.sh

sub-all:
	@make sub-officials
	@echo ''
	@make sub-community
	@echo ''
	@echo '---'
	@echo '- ALL DONE -'

codebuild-modules:
	@echo "=============================================================="
	@echo " Task      : Get CodeBuild Modules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@./get-modules-codebuild.sh

# ==================== #
#   CLONE REPOSITORY   #
# ==================== #
.PHONY: git-clone
git-clone:
	@echo "=============================================================="
	@echo " Task      : Clone Repository Sources "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@./git-clone.sh $(SOURCE) $(TARGET)
	@echo '- DONE -'

# ================== #
#   DOCKER-COMPOSE   #
# ================== #
.PHONY: run stop remove
run:
	@echo "========================================================"
	@echo " Task      : Docker Container "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@./run-docker.sh
	@echo '- DONE -'

stop:
	@echo "========================================================"
	@echo " Task      : Stopping Docker Container "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@docker-compose -f ${PATH_COMPOSE}/docker-compose.yml stop
	@echo '- DONE -'

remove:
	@echo "========================================================"
	@echo " Task      : Remove Docker Container "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@docker-compose -f ${PATH_COMPOSE}/docker-compose.yml down
	@echo '- DONE -'

# =============================== #
#   BUILD CONTAINER APPLICATION   #
# =============================== #
.PHONY: dockerhub-build ecr-build

# ./dockerhub-build.sh Dockerfile [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
dockerhub-build:
	@echo "========================================================"
	@echo " Task      : Create Container Application Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@sh ./dockerhub-build.sh Dockerfile $(CI_PATH) alpine ${LARAVEL_VERSION}

# ./ecr-build.sh [AWS_ACCOUNT] Dockerfile [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
ecr-build:
	@echo "========================================================"
	@echo " Task      : Create Container Application Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@sh ./ecr-build.sh $(ARGS) Dockerfile $(CI_PATH) alpine ${LARAVEL_VERSION}

# ============================== #
#   TAGS CONTAINER APPLICATION   #
# ============================== #
.PHONY: tag-dockerhub tag-ecr

# ./dockerhub-tag.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu] [version|latest|tags] [custom-tags]
dockerhub-tag:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Application to DockerHub "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@sh ./dockerhub-tag.sh $(CI_PATH) alpine ${LARAVEL_VERSION}

# ./ecr-tag.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu] [version|latest|tags] [custom-tags]
ecr-tag:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Application to ECR "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@sh ./ecr-tag.sh $(ARGS) $(CI_PATH) alpine ${LARAVEL_VERSION}

# ============================== #
#   PUSH CONTAINER APPLICATION   #
# ============================== #
.PHONY: dockerhub-push ecr-push

# ./dockerhub-push.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|version|latest|tags|custom-tags]
dockerhub-push:
	@echo "========================================================"
	@echo " Task      : Push Image Application to DockerHub "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@sh ./dockerhub-push.sh $(CI_PATH) alpine
	@sh ./dockerhub-push.sh $(CI_PATH) latest
	@sh ./dockerhub-push.sh $(CI_PATH) ${LARAVEL_VERSION}

# ./ecr-push.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|version|latest|tags|custom-tags]
ecr-push:
	@echo "========================================================"
	@echo " Task      : Push Image Application to ECR "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) alpine
	@sh ./ecr-push.sh $(CI_PATH) latest
	@sh ./ecr-push.sh $(CI_PATH) ${LARAVEL_VERSION}

# ============================== #
#   PULL CONTAINER APPLICATION   #
# ============================== #
.PHONY: ecr-pull

# ./ecr-pull.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
ecr-pull:
	@echo "=============================================================="
	@echo " Task      : Pull Container Image from ECR "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) alpine
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) latest
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) ${LARAVEL_VERSION}
	@echo '- DONE -'

# =================== #
#   HELM REPOSITORY   #
# =================== #
.PHONY: helm-pack-lab helm-push-lab
helm-pack-lab:
	@echo "============================================"
	@echo " Task      : Packing HelmChart "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${PATH_HELM} && ./helm-pack-lab.sh
	@echo '- DONE -'

helm-push-lab:
	@echo "============================================"
	@echo " Task      : PUSH HelmChart "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${PATH_HELM} && ./helm-push-lab.sh
	@echo '- DONE -'
