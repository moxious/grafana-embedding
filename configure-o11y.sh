helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<EOF
cluster:
  name: "testy"

externalServices:
  prometheus:
    host: "https://prometheus-prod-13-prod-us-east-0.grafana.net"
    basicAuth:
      username: "746141"
      password: "glc_eyJvIjoiNzgyMzM2IiwibiI6InRlc3R5MiIsImsiOiI0Njl6TTBQajQzUndUQ2pxQ3QyNjZLNmoiLCJtIjp7InIiOiJwcm9kLXVzLWVhc3QtMCJ9fQ=="

  loki:
    host: "https://logs-prod-006.grafana.net"
    basicAuth:
      username: "372040"
      password: "glc_eyJvIjoiNzgyMzM2IiwibiI6InRlc3R5MiIsImsiOiI0Njl6TTBQajQzUndUQ2pxQ3QyNjZLNmoiLCJtIjp7InIiOiJwcm9kLXVzLWVhc3QtMCJ9fQ=="

opencost:
  opencost:
    exporter:
      defaultClusterId: "testy"
    prometheus:
      external:
        url: "https://prometheus-prod-13-prod-us-east-0.grafana.net/api/prom"
EOF