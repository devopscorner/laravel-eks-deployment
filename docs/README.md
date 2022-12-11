# Infra Laravel Deployment

![all contributors](https://img.shields.io/github/contributors/devopscorner/laravel-eks-deployment)
![tags](https://img.shields.io/github/v/tag/devopscorner/laravel-eks-deployment?sort=semver)
![issues](https://img.shields.io/github/issues/devopscorner/laravel-eks-deployment)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/laravel-eks-deployment)
![forks](https://img.shields.io/github/forks/devopscorner/laravel-eks-deployment)
![stars](https://img.shields.io/github/stars/devopscorner/laravel-eks-deployment)
[![License: CC BY-NC 4.0](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)](https://img.shields.io/github/license/devopscorner/laravel-eks-deployment)

Laravel Kubernetes (EKS) Deployment Tools

---

## INDEX

- Terraform Plan Inventory
  - [Terraform Plan - Core Staging](terraform-plan-core-staging.md)
  - [Terraform Plan - Core Prod](terraform-plan-core-prod.md)
  - [Terraform Plan - EKS Staging](terraform-plan-eks-staging.md)
  - [Terraform Plan - EKS Prod](terraform-plan-eks-prod.md)
  - [Terraform Security Analysis - Core Staging](terraform-security-analysis-core-staging.md)
  - [Terraform Security Analysis - Core Prod](terraform-security-analysis-core-prod.md)
  - [Terraform Security Analysis - EKS Staging](terraform-security-analysis-eks-staging.md)
  - [Terraform Security Analysis - EKS Prod](terraform-security-analysis-eks-prod.md)
  - [Terraform Infra Costing - Core Staging](terraform-infracost-core-staging.md)
  - [Terraform Infra Costing - Core Prod](terraform-infracost-core-prod.md)
  - [Terraform Infra Costing - EKS Staging](terraform-infracost-eks-staging.md)
  - [Terraform Infra Costing - EKS Prod](terraform-infracost-eks-prod.md)

- Terraform State Inventory
  - [Core Infrastructure Staging](terraform-state-core-infra-staging.md)
  - [Core Infrastructure Prod](terraform-state-core-infra-prod.md)
  - [EKS Staging](terraform-state-eks-staging.md)
  - [EKS Production](terraform-state-eks-prod.md)

- Terraform Docs Generator with `terraform-docs`, download [this](https://github.com/terraform-docs/terraform-docs/) binary
  - [Terraform Infra Core](README-Terraform-Infra-Core.md)
    ```
    cd terraform/environment/providers/aws/infra/core

    touch ../../../../../../docs/README-Terraform-Infra-Core.md

    terraform-docs markdown table --output-file ../../../../../../docs/README-Terraform-Infra-Core.md --output-mode inject .
    ```

  - [Terraform Infra TFState](README-Terraform-Infra-TFState.md)
    ```
    cd terraform/environment/providers/aws/infra/tfstate

    touch ../../../../../../docs/README-Terraform-Infra-TFState.md

    terraform-docs markdown table --output-file ../../../../../../docs/README-Terraform-Infra-TFState.md --output-mode inject .
    ```

  - [Terraform Infra Resources Budget](README-Terraform-Infra-Resources-Budget.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/budget

    touch ../../../../../../../docs/README-Terraform-Infra-Resources-Budget.md

    terraform-docs markdown table --output-file ../../../../../../../docs/README-Terraform-Infra-Resources-Budget.md --output-mode inject .
    ```

  - [Terraform Infra Resources EKS Laravel](README-Terraform-Infra-Resources-EKS-Laravel.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/eks

    touch ../../../../../../../docs/README-Terraform-Infra-Resources-EKS-Laravel.md

    terraform-docs markdown table --output-file ../../../../../../../docs/README-Terraform-Infra-Resources-EKS-Laravel.md --output-mode inject .
    ```

  - [Terraform Infra Resources RDS LaravelDB](README-Terraform-Infra-Resources-RDS-LaravelDB.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/rds/laraveldb

    touch ../../../../../../../../docs/README-Terraform-Infra-Resources-RDS-LaravelDB.md

    terraform-docs markdown table --output-file ../../../../../../../../docs/README-Terraform-Infra-Resources-RDS-LaravelDB.md --output-mode inject .
    ```
