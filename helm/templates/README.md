# DevOpsCorner Helm Chart
Helm chart for DevOpsCorner services

## Prerequirements

- Helm
  ```
  ### Linux ###
  $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  $ chmod 700 get_helm.sh
  $ ./get_helm.sh

  ### MacOS ###
  $ brew install helm
  ```

- Helmfile
  ```
  $ wget https://github.com/roboll/helmfile/releases/download/v0.139.7/helmfile_linux_amd64
  $ chmod +x helmfile_linux_amd64
  $ sudo mv helmfile_linux_amd64 /usr/local/bin/helmfile
  ```

- Helm Plugins
  ```
  helm plugin install https://github.com/databus23/helm-diff
  helm plugin install https://github.com/hypnoglow/helm-s3.git
  ```

- Added Mandatory Repository
  ```
  helm repo add stable https://charts.helm.sh/stable
  helm repo update
  ```

## Helm Repository

- Check Repository Helm
  ```
  helm repo list
  ----
  NAME            URL
  stable          https://charts.helm.sh/stable
  ```

- Adding Repository Helm
  ```
  ### STAGING ###
  helm s3 init s3://devopscorner-helm-chart-staging/charts
  AWS_REGION=ap-southeast-1 helm repo add devopscorner-staging s3://devopscorner-helm-chart-staging/charts

  ### PRODUCTION ###
  helm s3 init s3://devopscorner-helm-chart/charts
  AWS_REGION=ap-southeast-1 helm repo add devopscorner-prod s3://devopscorner-helm-chart/charts

  helm repo update
  ```

## Testing Helm

- Testing the chart template
  ```
  helm template ./api -f api/values.yaml
  helm template ./backend -f backend/values.yaml
  helm template ./frontend -f frontend/values.yaml
  helm template ./svcrole -f svcrole/values.yaml
  ```

## Create Helm Template

- Create a zip package of helm chart
  ```
  helm package api
  helm package backend
  helm package frontend
  helm package svcrole
  ```

## Update Helm Template

- Push chart into private repository
  ```
  ### STAGING ###
  helm s3 push api-0.1.0.tgz devopscorner-staging --force
  helm s3 push backend-0.1.0.tgz devopscorner-staging --force
  helm s3 push frontend-0.1.0.tgz devopscorner-staging --force
  helm s3 push svcrole-0.1.0.tgz devopscorner-staging --force
  ---
  ### PRODUCTION ###
  helm s3 push api-0.1.0.tgz devopscorner-prod --force
  helm s3 push backend-0.1.0.tgz devopscorner-prod --force
  helm s3 push frontend-0.1.0.tgz devopscorner-prod --force
  helm s3 push svcrole-0.1.0.tgz devopscorner-prod --force
  ```

## Structure Helm Template

- Structure on services repo
```
_infra/
   dev/
      helmfile.yaml
      values/
            api/values.yaml
            backend/values.yaml
            svcrole/values.yaml
            frontend/values.yaml
```

## ECR Deployment

- ECR Login
  ```
  aws ecr get-login-password --region [AWS_REGION] | docker login --username AWS --password-stdin [ERC_PATH]
  ---
  aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin [AWS_ACCOUNT].dkr.ecr.ap-southeast-1.amazonaws.com
  ```

- ECR Build
  ```
  docker build [DOCKERFILE_PATH] -t [DOCKER_IMAGE_NAME]:[TAG]
  ---
  docker build . -t zeroc0d3/laravel-kubernetes:latest
  docker build /home/ubuntu/Dockerfile -t zeroc0d3/laravel-kubernetes:latest
  ```

- ECR Push
  ```
  docker tag [DOCKER_IMAGE_NAME]:[TAG] [ECR_PATH]/[DOCKER_IMAGE_NAME]:[TAG]
  docker push [ECR_PATH]/[DOCKER_IMAGE_NAME]:[TAG]
  ---
  docker tag devopscorner/laravel-kubernetes:latest [AWS_ACCOUNT].dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/laravel-kubernetes:latest
  docker push [AWS_ACCOUNT].dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/laravel-kubernetes:latest
  ```

- ECR Pull
  ```
  docker pull [ECR_PATH]/[DOCKER_IMAGE_NAME]:[TAG]
  ---
  docker pull [AWS_ACCOUNT].dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/laravel-kubernetes:latest
  ```
