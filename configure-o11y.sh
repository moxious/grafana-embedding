. .env

kubectl create namespace k8s-o11y

helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "k8s-o11y" --create-namespace --values - <<EOF
cluster:
  name: "$CLUSTER"

grafana-agent:
  crds:
    create: false

externalServices:
  prometheus:
    host: "$PROM_ENDPOINT"
    basicAuth:
      username: "$PROM_USERNAME"
      password: "$PROM_PASSWORD"

  loki:
    host: "$LOGS_ENDPOINT"
    basicAuth:
      username: "$LOGS_USERNAME"
      password: "$LOGS_PASSWORD"

opencost:
  opencost:
    exporter:
      defaultClusterId: "$CLUSTER"
    prometheus:
      external:
        url: "$PROM_ENDPOINT"
EOF