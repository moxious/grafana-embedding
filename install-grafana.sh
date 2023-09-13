#!/bin/bash

. .env

helm install grafana grafana/grafana --values config.yaml --wait

# 2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

#    grafana.default.svc.cluster.local

#    Get the Grafana URL to visit by running these commands in the same shell:
#      export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
#      kubectl --namespace default port-forward $POD_NAME 3000

export GRAFANA_PASSWORD=`kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo`

export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl expose pod $POD_NAME --name grafana-svc-http --port 3000

kubectl get svc grafana-svc-http
kubectl apply -f grafana-ingress-static-ip.yaml
