# Infra Laravel Deployment

![all contributors](https://img.shields.io/github/contributors/devopscorner/laravel-eks-deployment)
![tags](https://img.shields.io/github/v/tag/devopscorner/laravel-eks-deployment?sort=semver)
![issues](https://img.shields.io/github/issues/devopscorner/laravel-eks-deployment)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/laravel-eks-deployment)
![forks](https://img.shields.io/github/forks/devopscorner/laravel-eks-deployment)
![stars](https://img.shields.io/github/stars/devopscorner/laravel-eks-deployment)
[![License: CC BY-NC 4.0](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)

Laravel Kubernetes (EKS) Deployment Tools

## Prerequirements

- [Docker](https://www.docker.com)
- [Docker-Compose](https://github.com/docker/compose/releases)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Helm](https://helm.sh)
- [Terraform](https://www.terraform.io)
- [Terraform Provider AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Kubectx](https://github.com/ahmetb/kubectx/releases)

## Folder Structure

### **Compose**

Docker Compose for Build Image, eg:

- Ubuntu (Bastion SSH)
- Nginx
- PHPFpm (Laravel App)
- _etc_

### **Core**

Infra Services (Network), eg:

- IGW
- NAT
- VPC
- _etc_

### **Helm**

HelmChart for Stateful & Others:

- Stateful
  - MariaDB
  - MySQL
  - PostgreSQL
  - Redis
  - _etc_
- Others
  - Fluentd
  - Grafana
  - Jenkins
  - Kibana
  - NGINX
  - PHPFpm
  - _etc_

### **Resources**

AWS Services, eg:

- EC2
- EKS
- RDS
- S3
- _etc_

### **Modules (Terraform Submodules)**

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

- AWS Cli version

  ```
  aws --version
  ---
  aws-cli/1.20.1 Python/3.8.5 Darwin/20.6.0 botocore/1.21.1
  ```

- Docker version

  ```
  docker -v
  ---
  Docker version 20.10.8, build 3967b7d

  docker version
  ---
  Client:
    Cloud integration: 1.0.17
    Version:           20.10.7
    API version:       1.41
    Go version:        go1.16.4
    Git commit:        f0df350
    Built:             Wed Jun  2 11:56:22 2021
    OS/Arch:           darwin/amd64
    Context:           default
    Experimental:      true

  Server: Docker Engine - Community
    Engine:
      Version:          20.10.7
      API version:      1.41 (minimum version 1.12)
      Go version:       go1.13.15
      Git commit:       b0f5bc3
      Built:            Wed Jun  2 11:54:58 2021
      OS/Arch:          linux/amd64
      Experimental:     false
    containerd:
      Version:          1.4.6
      GitCommit:        d71fcd7d8303cbf684402823e425e9dd2e99285d
    runc:
      Version:          1.0.0-rc95
      GitCommit:        b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7
    docker-init:
      Version:          0.19.0
      GitCommit:        de40ad0
  ```

- Docker-Compose version

  ```
  docker-compose -v
  ---
  docker-compose version 1.29.2, build 5becea4c

  docker-compose version
  ---
  docker-compose version 1.29.2, build 5becea4c
  docker-py version: 5.0.0
  CPython version: 3.9.0
  OpenSSL version: OpenSSL 1.1.1h  22 Sep 2020
  ```

- Terraform version

  ```
  terraform version
  ---
  Terraform v1.0.9
  + provider registry.terraform.io/hashicorp/aws v3.61.0
  + provider registry.terraform.io/hashicorp/local v2.1.0
  + provider registry.terraform.io/hashicorp/null v3.1.0
  + provider registry.terraform.io/hashicorp/template v2.2.0
  ```

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- License: **Apache v2**
