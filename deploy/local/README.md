# Local Environment

This directory contains local dependency and observability support for `gonna`.

Profiles:

- `minimal`: PostgreSQL
- `integration`: PostgreSQL, Redis, Kafka
- `observability`: PostgreSQL, Redis, Kafka, OpenTelemetry Collector, Prometheus, Grafana

## Commands

```bash
make env-config PROFILE=minimal
make env-up PROFILE=minimal
make env-ps PROFILE=minimal
make env-down PROFILE=minimal
```

Use `.env.example` as local guidance. Do not commit real secrets.
