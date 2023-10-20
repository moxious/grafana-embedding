#!/bin/bash

. .env

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm install my-otel-demo open-telemetry/opentelemetry-demo --values otel-demo/config.yaml

# kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080
