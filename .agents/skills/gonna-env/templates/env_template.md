# Local Environment Variables

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep environment variable names, config keys, commands, paths, ports, and protocol names in their required technical form.

Copy this guidance into `deploy/local/.env.example` or use it to create a project-specific local env file.

Do not commit real secrets.

```dotenv
POSTGRES_DB=gonna
POSTGRES_USER=gonna
POSTGRES_PASSWORD=gonna_password
POSTGRES_PORT=5432

REDIS_PORT=6379

KAFKA_PORT=9092

OTEL_GRPC_PORT=4317
OTEL_HTTP_PORT=4318

PROMETHEUS_PORT=9090

GRAFANA_PORT=3000
GRAFANA_USER=admin
GRAFANA_PASSWORD=admin
```

## go-zero Config Mapping

| Environment Variable | go-zero Config Target | Notes |
| --- | --- | --- |
| `POSTGRES_*` | `etc/{service}.yaml` database DSN | Adjust driver and DSN format to project code |
| `REDIS_PORT` | `etc/{service}.yaml` Redis config | Include host, type, pass, and key prefix as needed |
| `KAFKA_PORT` | `etc/{service}.yaml` Kafka brokers | Use `localhost:${KAFKA_PORT}` locally |
| `OTEL_GRPC_PORT` | tracing exporter endpoint | Use when service exports spans over OTLP gRPC |
| `OTEL_HTTP_PORT` | tracing exporter endpoint | Use when service exports spans over OTLP HTTP |
