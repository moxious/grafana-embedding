#!/bin/bash

. .env

# https://artifacthub.io/packages/helm/grafana/grafana-agent
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

kubectl create configmap agent-config-river --from-file=config.river=agent/config.river

helm install agent grafana/grafana-agent --values agent/config.yaml