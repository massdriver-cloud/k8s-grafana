## AWS EKS Grafana Deployment

Grafana is an open-source platform for monitoring and observability. It allows you to query, visualize, alert, and understand your metrics no matter where they are stored. This guide helps you manage Grafana deployed on AWS EKS.

### Design Decisions

- **Cloud-Agnostic Configuration**: The module supports AWS, Azure, and GCP, enabling flexibility in deploying Grafana on different cloud providers.
- **Helm Integration**: Utilizes Helm charts for Grafana deployment, ensuring a consistent, repeatable, and automated setup.
- **Massdriver Helm Values**: Integrates Massdriver-specific configurations to streamline the deployment process for applications using Massdriver's infrastructure.

### Runbook

#### Grafana Pod is Not Running

Check the status of pods in your namespace to identify any issues with the Grafana pod.

```sh
kubectl get pods -n <namespace>
```

Look for the Grafana pod and check its status. If it shows `CrashLoopBackOff` or `Error`, further investigation is needed.

#### Checking Pod Logs

If your Grafana pod is not running correctly, check the logs to identify the issue.

```sh
kubectl logs <pod-name> -n <namespace>
```

Inspect the logs for any errors or warnings that might indicate why the pod is failing.

#### Helm Release Issues

If the Helm release fails or Grafana is not deployed as expected, you can check the Helm release status.

```sh
helm status <release-name> -n <namespace>
```

Verify the status and look for any errors in the output.

#### AWS CLI to Check EKS Cluster

Ensure your EKS cluster is healthy and all nodes are functioning properly.

```sh
aws eks describe-cluster --name <cluster-name> --region <region>
```

Check the response for cluster status and health.

#### Kubernetes Configurations Issues

Validate your Kubernetes configurations and ensure your kubeconfig is correctly set up.

```sh
kubectl config view
```

Review the output and ensure your context is correctly pointing to the intended cluster.

#### Redis Connection Issues

If Grafana is using Redis as a data source and you are experiencing connectivity issues, check the Redis server status.

```sh
redis-cli -h <redis-host> -p <redis-port> ping
```

You should expect to see `PONG` if the Redis server is up and running.

#### Database Connectivity Issues

For MySQL/PostgreSQL issues, verify the connection from within your Kubernetes cluster.

For MySQL:

```sh
kubectl run -i --tty --rm debug --image=mysql:5.7 --restart=Never -- mysql -h <mysql-host> -u <user> -p<password> -e "SHOW DATABASES;"
```

For PostgreSQL:

```sh
kubectl run -i --tty --rm debug --image=postgres:11 --restart=Never -- psql -h <postgres-host> -U <user> -c "\l"
```

Ensure that you can see the expected databases listed in the output.



