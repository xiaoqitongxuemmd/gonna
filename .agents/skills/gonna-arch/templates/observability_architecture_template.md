# 可观测性架构 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 概览

{说明 metrics、traces、logs 的目标和边界。}

## Signals

| Signal | 工具 | 用途 |
| --- | --- | --- |
| Metrics | Prometheus | {用途} |
| Traces | OpenTelemetry Collector + {backend} | {用途} |
| Logs | {backend} | {用途} |

## 服务埋点要求

| 服务 | Metrics | Traces | Logs |
| --- | --- | --- | --- |
| `{service}` | {指标} | {span} | {字段} |

## 关联字段

- `service.name`
- `deployment.environment`
- `service.version`
- `trace_id`
- `span_id`

## Dashboard 期望

- 服务延迟
- 错误率
- 请求吞吐
- RPC 延迟

## 本地环境交接

- `gonna-env`: {需要落地的 observability profile}
