# Infra Laravel Deployment

![all contributors](https://img.shields.io/github/contributors/devopscorner/laravel-eks-deployment)
![tags](https://img.shields.io/github/v/tag/devopscorner/laravel-eks-deployment?sort=semver)
[![phpfpm pulls](https://img.shields.io/docker/pulls/devopscorner/laravel.svg?label=phpfpm%20container&logo=php)](https://hub.docker.com/r/devopscorner/phpfpm/)
[![laravel pulls](https://img.shields.io/docker/pulls/devopscorner/laravel.svg?label=laravel%20container&logo=laravel)](https://hub.docker.com/r/devopscorner/laravel/)
![download all](https://img.shields.io/github/downloads/devopscorner/laravel-eks-deployment/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/laravel-eks-deployment/1.3/total)
![view](https://views.whatilearened.today/views/github/devopscorner/laravel-eks-deployment.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/laravel-eks-deployment/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/laravel-eks-deployment)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/laravel-eks-deployment)
![forks](https://img.shields.io/github/forks/devopscorner/laravel-eks-deployment)
![stars](https://img.shields.io/github/stars/devopscorner/laravel-eks-deployment)
[![license](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)

Laravel Kubernetes (EKS) Deployment Tools

---
## Available Tags

### **PHP-FPM**

| Image name | Size |
|------------|------|
| `devopscorner/phpfpm:latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=latest) |
| `devopscorner/phpfpm:alpine` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/alpine.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=alpine) |
| `devopscorner/phpfpm:8.1-alpine` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/8.1-alpine.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=8.1-alpine) |
| `devopscorner/phpfpm:8.1` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/8.1.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=8.1) |
| `devopscorner/phpfpm:8.0-alpine` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/8.0-alpine.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=8.0-alpine) |
| `devopscorner/phpfpm:8.0` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/8.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=8.0) |
| `devopscorner/phpfpm:7.4-alpine` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/7.4-alpine.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=7.4-alpine) |
| `devopscorner/phpfpm:7.4` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/phpfpm/7.4.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/phpfpm/tags?page=1&ordering=last_updated&name=7.4) |


### **Laravel Framework**

| Image name | Size |
|------------|------|
| `devopscorner/laravel:latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/laravel/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/laravel/tags?page=1&ordering=last_updated&name=latest) |
| `devopscorner/laravel:9` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/laravel/9.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/laravel/tags?page=1&ordering=last_updated&name=9) |
| `devopscorner/laravel:9.41` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/laravel/9.41.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/laravel/tags?page=1&ordering=last_updated&name=9.41) |

---
## Prerequirements

- [Docker](https://www.docker.com)
- [Docker-Compose](https://github.com/docker/compose/releases)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Helm](https://helm.sh)
- [Terraform](https://www.terraform.io)
- [Terraform Provider AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Kubectx](https://github.com/ahmetb/kubectx/releases)

## Folder Structure

### **docs**

Index Documentation, see [here](docs/README.md) for detail

### **compose**

Docker Compose for Build Image, eg:

- Ubuntu (Bastion SSH)
- Nginx
- PHPFpm (Laravel App)
- _etc_

### **helm**

HelmChart, Template, Helmfile Values:

- charts
  - stateful
    - mariadb
    - mysql
    - postgresql
    - redis
    - _etc_
  - others
    - fluentd
    - grafana
    - jenkins
    - kibana
    - nginx
    - phpfpm
    - _etc_
- helmfile
  - laravel-template.yml
  - laravel-values.yml
  - manifest-laravel-secret.yml
  - mariadb-values.yml
- templates
  - api
  - backend
  - configmap
  - frontend
  - secretref
  - stateful
  - svcrole
  - helm-pack-lab.sh
  - helm-push-lab.sh


### **terraform/environment**

Teraform AWS Providers, eg:

- Core
- TFState
- Resources
  - Budget
  - EKS
  - RDS

### **terraform/modules (Terraform Submodules)**

- Official Repositories

  ```
  ./get-official.sh
  -- or --
  make sub-official
  ```

- Community Repositories

  ```
  ./get-community.sh
  -- or --
  make sub-community
  ```

## How-to-Use

- Clone this repository

  ```
  git clone git@github.com:devopscorner/laravel-eks-deployment.git
  ```

- Pull Submodule repository

  ```
  git submodule update --init --recursive
  -- or --
  make sub-all
  ```

- Assume Role for Terraform command

  ```
  aws sts assume-role --role-arn arn-role-to-assume --role-session-name AWSCLI
  ```

- Terraform Execution

  ```
  terraform init
  terraform plan
  terraform apply
  ```

- Terraform Cleanup (Remove ALL)
  ```
  terraform destroy
  ---
  Notes: PLEASE BEWARE TO USE THIS !!!
  ```

## Deploy HelmChart

- Set Context to Your Environment
  ```
  kubectl config use-context [YOUR_K8S_CONTEXT]
  -- or --
  kubectx [YOUR_K8S_CONTEXT]
  ```
- Create Namespace `larave-app`
  ```
  kubectl create namespace laravel-app
  ```
- Deploy Stateful HelmChart
  ```
  make helmchart-stateful [CHART_NAME]
  ---
  eg:
  make helmchart-stateful mariadb
  ```
- Deploy Others HelmChart
  ```
  make helmchart-others [CHART_NAME]
  ---
  eg:
  make helmchart-others nginx
  make helmchart-others laravel
  ```

## Cleanup Installation HelmChart

- Set Context to Your Environment
  ```
  kubectl config use-context [YOUR_K8S_CONTEXT]
  -- or --
  kubectx [YOUR_K8S_CONTEXT]
  ```
- Cleanup Stateful HelmChart
  ```
  make remove-helmchart-stateful [CHART_NAME]
  ---
  eg:
  make remove-helmchart-stateful mariadb
  ```
- Cleanup Others HelmChart
  ```
  make remove-helmchart-others [CHART_NAME]
  ---
  eg:
  make remove-helmchart-others nginx
  make remove-helmchart-others laravel
  ```

## Tested Environment

### Versioning

- Docker version

  ```
  docker -v
  ---
  Docker version 20.10.17-rd, build c2e4e01

  docker version
  ---
  Client:
    Version:           20.10.17-rd
    API version:       1.41
    Go version:        go1.17.11
    Git commit:        c2e4e01
    Built:             Fri Jul 22 18:31:17 2022
    OS/Arch:           darwin/amd64
    Context:           default
    Experimental:      true

  Server: Docker Desktop 4.14.1 (91661)
  Engine:
    Version:          20.10.21
    API version:      1.41 (minimum version 1.12)
    Go version:       go9.7
    Git commit:       3056208
    Built:            Tue Oct 25 18:00:19 2022
    OS/Arch:          linux/amd64
    Experimental:     false
  containerd:
    Version:          1.6.9
    GitCommit:        1c90a442489720eec95342e1789ee8a5e1b9536f
  runc:
    Version:          1.1.4
    GitCommit:        v1.1.4-0-g5fd4c4d
  docker-init:
    Version:          0.19.0
    GitCommit:        de40ad0
  ```

- Docker-Compose version

  ```
  docker-compose -v
  ---
  Docker Compose version v2.11.1
  ```

- AWS Cli

  ```
  aws --version
  ---
  aws-cli/2.8.7 Python/3.9.11 Darwin/21.6.0 exe/x86_64 prompt/off
  ```

- Terraform Cli

  ```
  terraform version
  ---
  Terraform v1.3.5
  on darwin_amd64
  - provider registry.terraform.io/hashicorp/aws v3.74.3
  - provider registry.terraform.io/hashicorp/local v2.1.0
  - provider registry.terraform.io/hashicorp/null v3.1.0
  - provider registry.terraform.io/hashicorp/random v3.1.0
  - provider registry.terraform.io/hashicorp/time v0.7.2
  ```

- Terraform Environment Cli

  ```
  tfenv -v
  ---
  tfenv 2.2.2
  ```

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- License: **Apache v2**
