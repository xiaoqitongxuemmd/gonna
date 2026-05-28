# 数据层设计 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 概览

{说明数据所有权、存储选择和模型生成策略。}

## 数据所有权

| 数据域 | Owner 服务 | 存储 | 说明 |
| --- | --- | --- | --- |
| `{domain}` | `{service}` | PostgreSQL/Redis/MongoDB | {说明} |

## 表与模型

| 表 | 模型目录 | 主键 | 说明 |
| --- | --- | --- | --- |
| `{table}` | `models/{model}` | `{pk}` | {说明} |

## 缓存策略

| 数据 | Key | TTL | 失效策略 |
| --- | --- | --- | --- |
| {数据} | `{key}` | {ttl} | {策略} |

## 事务边界

- {事务场景}
- {一致性要求}

## goctl model 计划

```bash
goctl model mysql ddl -src {schema}.sql -dir models/{model} --style go_zero
```

## 验证要求

- {单元测试或集成测试}
