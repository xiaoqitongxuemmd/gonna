# 服务层架构 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 文档治理

- 唯一信源：yes
- 来源文档：{PRD/规格/正式设计文档路径}
- 非正式参考：{临时/参考材料路径或 none}
- 下游消费者：`gonna-plan`、`gonna-deploy`、`gonna-dev`、`gonna-test`

## 概览

{说明服务层职责、拆分原则和调用关系。}

## 服务清单

| 服务 | 类型 | 目录 | 职责 | Owner |
| --- | --- | --- | --- | --- |
| `{service}` | API/RPC/Job | `services/{service}` | {职责} | {负责人} |

## 服务职责边界

### `{service}`

- 负责：{职责}
- 不负责：{非职责}
- 上游：{调用方}
- 下游：{被调用服务或依赖}

## 调用关系

| 调用方 | 被调用方 | 协议 | 用途 | 超时 |
| --- | --- | --- | --- | --- |
| `{caller}` | `{callee}` | HTTP/gRPC/Event | {用途} | {超时} |

## 配置与依赖注入

- `internal/config`: {配置项}
- `internal/svc`: {依赖注入项}

## 下游交接

- `gonna-dev`: {服务生成和手写实现边界}
- `gonna-test`: {服务交互验证点}
