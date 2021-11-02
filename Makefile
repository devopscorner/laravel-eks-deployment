# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache version 2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_COMPOSE="compose"
export PATH_DOCKER="compose/docker"
export PROJECT_NAME="infra-laravel-deployment"
export PROJECT_NAMESPACE="laravel-app"

export CI_REGISTRY     ?= hub.docker.com
export CI_PROJECT_PATH ?= zeroc0d3

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.3.0

BASE_IMAGE     = ubuntu
BASE_VERSION   = 20.04

.PHONY: run stop remove build push push-container
run:
	@echo "============================================"
	@echo " Task      : Docker Container "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@./run-docker.sh
	@echo '- DONE -'

stop:
	@echo "============================================"
	@echo " Task      : Stopping Docker Container "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@docker-compose -f ${PATH_COMPOSE}/app-compose.yml stop
	@echo '- DONE -'

remove:
	@echo "============================================"
	@echo " Task      : Remove Docker Container "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@docker-compose -f ${PATH_COMPOSE}/app-compose.yml down
	@echo '- DONE -'

build:
	@echo "============================================"
	@echo " Task      : Create Docker Image "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${PATH_DOCKER} && ./docker-build.sh
	@echo '- DONE -'

push:
	@echo "============================================"
	@echo " Task      : Push Docker Image "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${PATH_DOCKER} && ./docker-push.sh
	@echo '- DONE -'

push-container:
	@echo "============================================"
	@echo " Task      : Push Docker Hub "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${PATH_DOCKER} && ./docker-build.sh
	@cd ${PATH_DOCKER} && ./docker-push.sh
	@echo '- DONE -'

.PHONY: sub-official sub-community sub-all
sub-official:
	@echo "============================================"
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@./get-official.sh
	@echo '- DONE -'

sub-community:
	@echo "============================================"
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@./get-community.sh
	@echo '- DONE -'

sub-all:
	@make sub-official
	@echo ""
	@make sub-community
	@echo ""
	@echo "---"
	@echo '- ALL DONE -'

.PHONY: helm-others-test helm-others helm-stateful-test helm-stateful-test
helm-others-test:
	@echo "============================================"
	@echo " Task      : Deploy HelmChart "
	@echo " Date/Time : `date`"
	@echo " HelmChart : others/${ARGS}"
	@echo "============================================"
	@echo "Update Dependencies Charts... "
	@cd ${PATH_CHART}/others/${ARGS} && helm dependency update
	@echo '- DONE -'
	@echo "Deploy Others Chart... "
	@cd ${PATH_CHART}/others && helm install --dry-run --debug ${ARGS}/. --generate-name -n ${PROJECT_NAMESPACE}
	@echo '- DONE -'

helm-others:
	@echo "============================================"
	@echo " Task      : Deploy HelmChart "
	@echo " Date/Time : `date`"
	@echo " HelmChart : others/${ARGS}"
	@echo "============================================"
	@echo "Update Dependencies Charts... "
	@cd ${PATH_CHART}/others/${ARGS} && helm dependency update
	@echo '- DONE -'
	@echo "Deploy Others Chart... "
	@cd ${PATH_CHART}/others && helm install --debug ${ARGS}/. --generate-name -n ${PROJECT_NAMESPACE}
	@echo '- DONE -'

helm-stateful-test:
	@echo "============================================"
	@echo " Task      : Deploy HelmChart "
	@echo " Date/Time : `date`"
	@echo " HelmChart : stateful/${ARGS}"
	@echo "============================================"
	@echo "Update Dependencies Charts... "
	@cd ${PATH_CHART}/stateful/${ARGS} && helm dependency update
	@echo '- DONE -'
	@echo "Deploy Stateful Chart... "
	@cd ${PATH_CHART}/stateful && helm install --dry-run --debug ${ARGS}/. --generate-name -n ${PROJECT_NAMESPACE}
	@echo '- DONE -'

helm-stateful:
	@echo "============================================"
	@echo " Task      : Deploy HelmChart "
	@echo " Date/Time : `date`"
	@echo " HelmChart : stateful/${ARGS}"
	@echo "============================================"
	@echo "Update Dependencies Charts... "
	@cd ${PATH_CHART}/stateful/${ARGS} && helm dependency update
	@echo '- DONE -'
	@echo "Deploy Stateful Chart... "
	@cd ${PATH_CHART}/stateful && helm install --debug ${ARGS}/. --generate-name -n ${PROJECT_NAMESPACE}
	@echo '- DONE -'

.PHONY: remove-helm-others remove-helm-stateful
remove-helm-others:
	@echo "============================================"
	@echo " Task      : Unistall Deployment HelmChart "
	@echo " Date/Time : `date`"
	@echo " HelmChart : others/${ARGS}"
	@echo "============================================"
	@echo "Uninstall Deployment Others Chart... "
	@cd ${PATH_CHART}/others && helm uninstall ${CHARTS} --debug
	@echo '- DONE -'

remove-helm-stateful:
	@echo "============================================"
	@echo " Task      : Uninstall Deploy HelmChart "
	@echo " Date/Time : `date`"
	@echo " HelmChart : stateful/${ARGS}"
	@echo "============================================"
	@echo "Uninstall Deployment Stateful Chart... "
	@cd ${PATH_CHART}/stateful && helm uninstall ${CHARTS} --debug
	@echo '- DONE -'