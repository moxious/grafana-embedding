const api = require("@opentelemetry/api");
const opentelemetry = require('@opentelemetry/sdk-node');

// 522677
// prod-us-east-0 (prod-us-east-0)
// glc_eyJvIjoiNzgyMzM2IiwibiI6Im90ZWwtdGVzdGluZy1vdGVsLXRlc3RpbmctbWluaXN2YyIsImsiOiIzMzQxMjd2YWw3aFZmOGpZTDhlWUhTUTAiLCJtIjp7InIiOiJwcm9kLXVzLWVhc3QtMCJ9fQ==
const endpoint = 'https://otlp-gateway-prod-us-east-0.grafana.net/otlp'

const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');

const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-proto');
const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-proto');
const { PeriodicExportingMetricReader } = require('@opentelemetry/sdk-metrics');

const headers = {
  Authorization: 'Basic NTIyNjc3OmdsY19leUp2SWpvaU56Z3lNek0ySWl3aWJpSTZJbTkwWld3dGRHVnpkR2x1WnkxdmRHVnNMWFJsYzNScGJtY3RiV2x1YVhOMll5SXNJbXNpT2lJek16UXhNamQyWVd3M2FGWm1PR3BaVERobFdVaFRVVEFpTENKdElqcDdJbklpT2lKd2NtOWtMWFZ6TFdWaGMzUXRNQ0o5ZlE9PQ==',
};

api.diag.setLogger(
  new api.DiagConsoleLogger(),
  api.DiagLogLevel.WARN
);

const sdk = new opentelemetry.NodeSDK({
  traceExporter: new OTLPTraceExporter({
    url: endpoint + '/v1/traces',    
    headers: headers,
  }),
  metricReader: new PeriodicExportingMetricReader({
    exporter: new OTLPMetricExporter({
      url: endpoint + '/v1/metrics',
      headers: headers,
      concurrencyLimit: 1, // an optional limit on pending requests
    }),
  }),
  instrumentations: [getNodeAutoInstrumentations()],
});
sdk.start();