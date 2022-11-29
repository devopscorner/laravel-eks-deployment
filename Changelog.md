# Infra Laravel Deployment - Changelog History

Laravel Kubernetes (EKS) Deployment Tools

![all contributors](https://img.shields.io/github/contributors/devopscorner/laravel-eks-deployment)
![tags](https://img.shields.io/github/v/tag/devopscorner/laravel-eks-deployment?sort=semver)
[![phpfpm pulls](https://img.shields.io/docker/pulls/devopscorner/laravel.svg?label=phpfpm%20container&logo=php)](https://hub.docker.com/r/devopscorner/phpfpm/)
[![laravel pulls](https://img.shields.io/docker/pulls/devopscorner/laravel.svg?label=laravel%20container&logo=laravel)](https://hub.docker.com/r/devopscorner/laravel/)
![download all](https://img.shields.io/github/downloads/devopscorner/laravel-eks-deployment/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/laravel-eks-deployment.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/laravel-eks-deployment/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/laravel-eks-deployment)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/laravel-eks-deployment)
![forks](https://img.shields.io/github/forks/devopscorner/laravel-eks-deployment)
![stars](https://img.shields.io/github/stars/devopscorner/laravel-eks-deployment)
[![license](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)

---

## Version 1.4

- Refactoring laravel container with additional installation packages & libraries
- Added AWS-Cli v2 binary

---

## Version 1.4

- Refactoring laravel container with additional installation packages & libraries
- Added AWS-Cli v2 binary

---

## Version 1.3

- Revert phpfpm setup listening port to 9000 (default)
- Set docker-compose laravel bind port 8000 from expose 9000 (default)
- Set default path work directory laravel container to `/usr/share/nginx/laravel`
- Added container nginx `1.23-alpine` linked to laravel container

---

## Version 1.2

- Added docker image references for PHPFpm (`devopscorner/phpfpm`)
- Fixing listening port from 9000 to 8000
- Added docker-compose container hostname
- Added healthcheck for phpfpm container in port 8000
- Change docker configuration laravel to `devopscorner/laravel`


---

## Version 1.1

- Upgrade Laravel version 8.x (8.65) to 9.x (9.19 / 9.3.12)
- Added component Laravel debug with Laravel Telescope
- Added component Laravel authentification with Laravel Breeze
- Added container Alpine PHPFpm 7.4-fpm, 8.0-fpm & 8.1-fpm

---

## Version 1.0

- Refactoring Folder Structure
- Refactoring Terraform Scripts
  - Core
  - Resources
    - EKS
    - RDS
  - TFState
- Refactoring Makefile for simplicity running script
- Upgrade EKS version 1.22 from 1.19
- Added New Helm Template Global
- Added New Helm Values using `helmfile`
- Added Documentation for Laravel Terraform
  - Plan
  - Cost Review (`infracost`)
  - Security Analysis
    - `checkov`
    - `terrascan`
    - `tfsec`

---

## Version 0.2.5

- Refactoring Helm Template & Values
- Refresh Submodules Terraform Official & Terraform Community
- Fixing Makefile script for submodules
- Added modules RDS

---

## Version 0.2.4

- Refactoring manifest setup
- Refactoring EKS resources with VPC module
- Refactoring path S3 bucket

---

## Version 0.2.3

- Added Letsencrypt SSL configuration
- Update notes Step Deployment

---

## Version 0.2.2

- Refactoring helm template for secret & secret-prod
- Update docker-compose configuration for added Adminer (Database Administrator) tools
- Update docker ignore files

---

## Version 0.2.1

- Update laravel blade welcome template & docker-compose configuration
- Added cheatsheet maintenance database
- Added ignore files & folders

---

## Version 0.2

- Added Laravel Container
- Added HelmChart NGINX
- Added HelmChart Laravel

---

## Version 0.1.1

- Added Repository Submodule for Terraform Modules

---

## Version 0.1

- Initial commit for infra-laravel-deployment
