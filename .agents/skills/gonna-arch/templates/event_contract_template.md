# 事件契约 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 概览

{说明事件驱动范围、消息系统和一致性边界。}

## Topic 清单

| Topic | 生产者 | 消费者 | 用途 | 保留策略 |
| --- | --- | --- | --- | --- |
| `{topic}` | `{producer}` | `{consumer}` | {用途} | {策略} |

## 事件模型

```json
{
  "event_id": "{uuid}",
  "event_type": "{event_type}",
  "occurred_at": "{timestamp}",
  "payload": {}
}
```

## 投递与消费语义

- 投递语义：at-least-once | at-most-once | exactly-once
- 幂等键：{key}
- 重试策略：{strategy}
- 死信队列：{topic or none}

## 下游交接

- `gonna-env`: {本地消息系统依赖}
- `gonna-dev`: {生产者和消费者实现}
- `gonna-test`: {事件验证场景}
