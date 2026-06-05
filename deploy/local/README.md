# 本地部署

本目录为 `gonna` 提供基于 Docker Compose 的本地部署能力，用于统一组织依赖容器、开发中的 go-zero 微服务容器和可观测性组件。

Profiles:

- `minimal`: PostgreSQL
- `integration`: PostgreSQL、Redis、Kafka
- `observability`: PostgreSQL、Redis、Kafka、OpenTelemetry Collector、Prometheus、Grafana

## 命令

```bash
make deploy-config PROFILE=minimal
make deploy-up PROFILE=minimal
make deploy-ps PROFILE=minimal
make deploy-down PROFILE=minimal
```

使用 `.env.example` 作为本地部署配置参考。不要提交真实密钥。
