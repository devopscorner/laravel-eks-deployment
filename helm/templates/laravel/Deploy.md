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

- Install NGINX-Ingress
  ```
  helm install nginx-ingress stable/nginx-ingress --set controller.publishService.enabled=true -n laravel-app
  ```

- Apply Cert Manager
  ```
  kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.crds.yaml
  ```

- Create Namespace for Cert Manager
  ```
  kubectl create namespace cert-manager
  ```

- Install Cert Manager
  ```
  helm repo add jetstack https://charts.jetstack.io
  helm install cert-manager --version v1.6.1 --namespace cert-manager jetstack/cert-manager
  ```

- Apply Ingress & SSL
  ```
  kubectl apply -f ingress.yaml -n laravel-app
  kubectl apply -f production_issuer.yaml -n laravel-app
  ```

- Validate Nginx Ingress Controller
  ```
  kubectl get service nginx-ingress-controller -n laravel-app
  ---
  NAME                       TYPE           CLUSTER-IP       EXTERNAL-IP                                      PORT(S)                      AGE
  nginx-ingress-controller   LoadBalancer   10.100.146.218   a60fec***3296.ap-southeast-1.elb.amazonaws.com   80:31932/TCP,443:31919/TCP   38m
  ```

- Check Pods
  ```
  kubectl get pods -n laravel-app
  NAME                                            READY   STATUS    RESTARTS   AGE
  cm-acme-http-solver-q28bv                       1/1     Running   0          16m
  laravel-kubernetes-lamp-5896f8c99c-vszgr        2/2     Running   0          3h25m
  mariadb-0                                       1/1     Running   0          17h
  nginx-ingress-controller-6d998555d4-8tmb8       1/1     Running   0          41m
  nginx-ingress-default-backend-c5449fb44-wpx9r   1/1     Running   0          41m
  ```

- Migrate Database
  ```
  kubectl exec laravel-kubernetes-lamp-5896f8c99c-vszgr -n laravel-app -- php artisan migrate --force
  ---
  Defaulted container "httpdphp" out of: httpdphp, mysql, init-chown-mysql (init)
  Migration table created successfully.
  Migrating: 2014_10_12_000000_create_users_table
  Migrated:  2014_10_12_000000_create_users_table (24.40ms)
  Migrating: 2014_10_12_100000_create_password_resets_table
  Migrated:  2014_10_12_100000_create_password_resets_table (22.69ms)
  Migrating: 2019_08_19_000000_create_failed_jobs_table
  Migrated:  2019_08_19_000000_create_failed_jobs_table (17.95ms)
  Migrating: 2019_12_14_000001_create_personal_access_tokens_table
  Migrated:  2019_12_14_000001_create_personal_access_tokens_table (28.77ms)
  ```

- Setup SSL for Doamin In Route53:
  ```
  +-------------------------------+-------+----------------+----------------+----------------------------------------------------------+
  | Record Name                   |  Type | Routing Policy | Differentiator | Value/Route traffic to                                   |
  +-------------------------------+-------+----------------+----------------+----------------------------------------------------------+
  | devopscorner.online           |   A   | Simple         |   -            | dualstack.a60fec***3296.ap-southeast-1.elb.amazonaws.com |
  | develop.devopscorner.online   |   A   | Simple         |   -            | dualstack.a60fec***3296.ap-southeast-1.elb.amazonaws.com |
  +-------------------------------+-------+----------------+----------------+----------------------------------------------------------+
