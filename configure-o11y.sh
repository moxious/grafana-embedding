. .env

helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<EOF
cluster:
  name: "testy"

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
      defaultClusterId: "testy"
    prometheus:
      external:
        url: "$PROM_ENDPOINT"
EOF