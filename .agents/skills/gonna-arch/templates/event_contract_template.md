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

## 兼容性审批

- 是否包含兼容性设计：yes/no
- 用户是否已明确批准：yes/no
- 批准依据：{对话、需求或设计引用}

未获得用户明确批准时，topic、key、消息字段、payload 结构、schema version、旧事件别名、fallback 消费和预留字段只能覆盖当前已确认意图，不得为了未来兼容默认添加。

## 投递与消费语义

- 投递语义：at-least-once | at-most-once | exactly-once
- 幂等键：{key}
- 重试策略：{strategy}
- 死信队列：{topic or none}

## 下游交接

- `gonna-deploy`: {本地消息系统依赖和部署输入}
- `gonna-dev`: {生产者和消费者实现}
- `gonna-test`: {事件验证场景}
