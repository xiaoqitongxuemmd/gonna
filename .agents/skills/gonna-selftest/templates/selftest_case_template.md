# Contract Selftest Case

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep commands, paths, env vars, HTTP methods, JSON fields, SQL, Kafka topics, status values, and raw responses in their required technical form.

Case ID: `HTTP-XXX | RPC-XXX | KAFKA-XXX | DB-XXX | REDIS-XXX | JOB-XXX | WEBHOOK-XXX`
Required: `yes | no`

## 目标

{说明这个 case 验证的设计意图。}

## 契约对象

- Type: `HTTP | RPC | Kafka | DB | Redis | Job | Webhook`
- Contract: `{HTTP method and endpoint, proto method, topic, table, key, job name}`

## 输入

HTTP 必填：

- Method: `POST`
- URL: `http://localhost:{port}/{path}`
- Path params:

| Name | Value | Meaning |
| --- | --- | --- |
| `{name}` | `{value}` | {meaning} |

- Query params:

| Name | Value | Meaning |
| --- | --- | --- |
| `{name}` | `{value}` | {meaning} |

- Headers:

```text
Content-Type: application/json
Authorization: Bearer {token}
```

- Request:

```json
{}
```

Kafka 示例：

- Topic: `{topic}`
- Key: `{key}`
- Message fields:

| Field | Type | Required | Example | Meaning |
| --- | --- | --- | --- | --- |
| `{field}` | string | yes | `{value}` | {meaning} |

- Message:

```json
{}
```

## 输出

HTTP 必填：

- Expected status: `200`
- Expected response fields:

| Field | Type | Required | Expected | Meaning |
| --- | --- | --- | --- | --- |
| `{field}` | string | yes | `{value}` | {meaning} |

- Expected response:

```json
{}
```

Kafka Expected Effect:

```text
{consumer behavior, DB change, Redis change, log, or downstream event}
```

## 数据准备

- Status: `Prepared | Preparation Failed | Manual Command Provided`
- Generated assets:
  - `{path}`
- Prepared by assistant:
  - `{command and result}`
- Cleanup:
  - `{command}`

## 执行命令

HTTP 必填，每个 HTTP case 必须是一个独立可复制的 `curl`，不要用批量脚本、函数或循环替代：

```bash
curl -i -X POST 'http://localhost:{port}/{path}' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

Kafka 必填，每个 Kafka case 使用一个只覆盖当前 topic/message 的探针：

```bash
sh docs/scrum/selftest/assets/{story-id}/kafka_probe.sh
```

## 观察命令

```bash
{SQL, redis-cli, Kafka consumer, log check, or curl readback command}
```

## 人工验收

- [ ] 符合预期
- [ ] 不符合预期

### 不符合预期反馈

实际 request/event：

```text
{paste actual request/event if different}
```

实际 response/result：

```text
{paste actual response/result}
```

实际副作用：

```text
{paste observed DB/Redis/Kafka/log side effects}
```

设计偏差说明：

```text
{describe mismatch with intended design}
```

建议调整：

```text
{suggest architecture, implementation, or test adjustment}
```
