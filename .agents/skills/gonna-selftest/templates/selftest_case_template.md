# Selftest Case

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep commands, paths, env vars, JSON fields, SQL, Kafka topics, status values, and raw responses in their required technical form.

Case ID: `CASE-XXX`
Required: `yes | no`
Result: `Pass | Fail | Needs Design Update | Not Run`

## 目标

{说明这个 case 验证的设计意图。}

## 契约对象

- Type: `REST API | RPC | Kafka | DB | Redis | Job | Webhook`
- Contract: `{endpoint, proto method, topic, table, key, job name}`

## 数据准备

- Status: `Prepared | Preparation Failed | Manual Command Provided`
- Generated assets:
  - `{path}`
- Prepared by assistant:
  - `{command and result}`
- Cleanup:
  - `{command}`

## 执行命令

```bash
{copy-paste command}
```

## 预期 Request 或 Event

```json
{}
```

## 预期 Response 或结果

```json
{}
```

## 副作用检查

```bash
{SQL, redis-cli, Kafka consumer, or log check command}
```

## 人工验收

- [ ] 我已确认数据准备状态可用于本 case
- [ ] 我已执行请求、RPC、消息或任务触发命令
- [ ] Response 或可观察结果符合预期
- [ ] 数据库、Redis、Kafka、日志或其他副作用符合预期
- [ ] 行为与我的设计意图一致

## 反馈

实际 Response 或结果：

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
