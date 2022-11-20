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
	@echo "============================================================"
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@mkdir -p $(TF_MODULES)/officials
	@cd $(PATH_APP) && ./get-officials.sh

sub-community:
	@echo "============================================================"
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date` "
	@echo "============================================================"
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
	@echo "============================================================"
	@echo " Task      : Get CodeBuild Modules "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@./get-modules-codebuild.sh

# ==================== #
#   CLONE REPOSITORY   #
# ==================== #
.PHONY: git-clone
git-clone:
	@echo "============================================================"
	@echo " Task      : Clone Repository Sources "
	@echo " Date/Time : `date` "
	@echo "============================================================"
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
dockerhub-build:
	@echo "========================================================"
	@echo " Task      : Create Container Application Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh laravel Dockerfile ${LARAVEL_VERSION}

ecr-build:
	@echo "========================================================"
	@echo " Task      : Create Container Application Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) laravel Dockerfile ${LARAVEL_VERSION}

# ============================== #
#   TAGS CONTAINER APPLICATION   #
# ============================== #
.PHONY: tag-dockerhub tag-ecr
dockerhub-tag:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Application to DockerHub "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh laravel ${LARAVEL_VERSION}

ecr-tag:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Application to ECR "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) laravel ${LARAVEL_VERSION} $(CI_PATH)

# ============================== #
#   PUSH CONTAINER APPLICATION   #
# ============================== #
.PHONY: dockerhub-push ecr-push
dockerhub-push:
	@echo "========================================================"
	@echo " Task      : Push Image Application to DockerHub "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh laravel $(CI_PATH)

ecr-push:
	@echo "========================================================"
	@echo " Task      : Push Image Application to ECR "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) laravel $(CI_PATH)

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
