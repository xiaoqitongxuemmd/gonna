# 环境契约 v1.0.0

版本：v1.0.0
创建时间：2026-05-28
更新时间：2026-05-28
状态：Draft

## 版本历史

| 版本 | 日期 | 变更 | 作者 |
| --- | --- | --- | --- |
| v1.0.0 | 2026-05-28 | 建立本地环境契约 | gonna |

## 运行时栈

| 组件 | 版本或约束 | 必需 | 说明 |
| --- | --- | --- | --- |
| Go | 1.26.3 | yes | 当前本地基线 |
| go-zero | 由 `go mod tidy` 解析 | yes | 运行时框架 |
| goctl | 1.10.1 | yes | 代码生成工具 |

## 本地依赖

| 依赖 | 镜像或版本 | Profile | 端口 | 用途 |
| --- | --- | --- | --- | --- |
| PostgreSQL | `postgres:16` | minimal | `5432` | 主关系型数据库基线 |
| Redis | `redis:7` | integration | `6379` | 缓存基线 |
| Kafka | `bitnami/kafka:3.7` | integration | `9092` | 事件和消息基线 |
| OpenTelemetry Collector | `otel/opentelemetry-collector-contrib:0.100.0` | observability | `4317`, `4318` | Trace 和 metrics 接入 |
| Prometheus | `prom/prometheus:v2.52.0` | observability | `9090` | Metrics 抓取 |
| Grafana | `grafana/grafana:10.4.2` | observability | `3000` | Dashboard 展示 |

## Profiles

- `minimal`: PostgreSQL
- `integration`: PostgreSQL、Redis、Kafka
- `observability`: PostgreSQL、Redis、Kafka、OpenTelemetry Collector、Prometheus、Grafana

## go-zero 配置映射

| 配置目标 | 本地值 | 说明 |
| --- | --- | --- |
| `services/gateway-api/etc/gateway-api.yaml` | API host 和 port | 由 goctl 生成 |
| `services/system-rpc/etc/system.yaml` | RPC listen address | 由 goctl 生成 |
| database config | `POSTGRES_*` | 当 Story 引入持久化时补充 |
| Redis config | `REDIS_PORT` | 当 Story 引入缓存时补充 |
| Kafka config | `KAFKA_PORT` | 当 Story 引入事件时补充 |
| telemetry endpoint | `OTEL_GRPC_PORT` 或 `OTEL_HTTP_PORT` | 当实现可观测性埋点时补充 |

## 健康检查

- Docker Compose config 必须通过校验。
- PostgreSQL 必须响应 `pg_isready`。
- 启用 Redis 时，Redis 必须响应 `redis-cli ping`。
- 启用 Kafka 时，Kafka broker 必须可连接。
- 启用 observability 时，OpenTelemetry Collector 端口必须可连接。
- 启用 observability 时，Prometheus 和 Grafana 必须可访问。

## 演进规则

- 当 feature 增加运行时依赖时，先更新本契约，再修改 `deploy/local/`。
- 当 feature 增加 metrics、traces 或 logs 时，更新本契约和可观测性架构。
- `gonna-env` 将本契约落地为本地环境文件。
