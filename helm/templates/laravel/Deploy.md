## Laravel Helm Deployment

- Edit Secrets
  ```
  vi secrets.yaml
  ```

- Deploy Laravel Pods
  ```
  helm install laravel-kubernetes -f values.yaml -f secrets.yaml stable/lamp -n laravel-app
  ```

- Rollout Deployment
  ```
  kubectl -n laravel-app rollout restart deployment laravel-kubernetes-lamp
  ```

- Helm Upgrade
  ```
  helm upgrade laravel-kubernetes -f values.yaml -f helm/secrets-prod.yaml stable/lamp -n laravel-app
  ```