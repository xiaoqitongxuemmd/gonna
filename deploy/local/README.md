# 本地环境

本目录为 `gonna` 提供本地依赖和可观测性支持。

Profiles:

- `minimal`: PostgreSQL
- `integration`: PostgreSQL、Redis、Kafka
- `observability`: PostgreSQL、Redis、Kafka、OpenTelemetry Collector、Prometheus、Grafana

## 命令

```bash
make env-config PROFILE=minimal
make env-up PROFILE=minimal
make env-ps PROFILE=minimal
make env-down PROFILE=minimal
```

使用 `.env.example` 作为本地配置参考。不要提交真实密钥。
