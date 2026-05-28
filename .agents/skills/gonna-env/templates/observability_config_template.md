# Observability Config Template

Use this as a planning template before creating concrete files under `deploy/local/observability/`.

## OpenTelemetry Collector

Expected file:

```text
deploy/local/observability/otel-collector.yaml
```

Expected responsibilities:

- Receive OTLP gRPC on `4317`
- Receive OTLP HTTP on `4318`
- Export traces to the selected local trace backend
- Export metrics to Prometheus or expose a Prometheus scrape endpoint

## Prometheus

Expected file:

```text
deploy/local/observability/prometheus.yaml
```

Expected scrape targets:

- go-zero API services
- go-zero RPC services
- OpenTelemetry Collector metrics endpoint

## Grafana

Expected dashboards:

- Service latency
- Error rate
- Request throughput
- RPC latency
- Kafka consumer lag when Kafka is used
- Database connection pool metrics when exposed

## Trace and Log Correlation

Services should include these fields when possible:

- `service.name`
- `deployment.environment`
- `service.version`
- `trace_id`
- `span_id`
