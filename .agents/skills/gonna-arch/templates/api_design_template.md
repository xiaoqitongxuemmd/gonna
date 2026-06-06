# REST API 设计 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 文档治理

- 唯一信源：yes
- 来源文档：{PRD/规格/正式设计文档路径}
- 非正式参考：{临时/参考材料路径或 none}
- 下游消费者：`gonna-plan`、`gonna-dev`、`gonna-test`、`gonna-selftest`

## 概览

{说明 REST API 范围、目标用户和网关边界。}

## API 契约文件

| 文件 | 服务 | 说明 |
| --- | --- | --- |
| `apis/{service}.api` | `{service}-api` | {说明} |

## 路由设计

| 方法 | 路径 | 鉴权 | 请求 | 响应 | 说明 |
| --- | --- | --- | --- | --- | --- |
| GET | `/path` | yes/no | `{Request}` | `{Response}` | {说明} |

## 请求与响应模型

```go
type {Request} {
    Field string `json:"field"`
}
```

## 兼容性审批

- 是否包含兼容性设计：yes/no
- 用户是否已明确批准：yes/no
- 批准依据：{对话、需求或设计引用}

未获得用户明确批准时，请求字段、响应字段、header、状态码、错误码、版本化路径、旧接口别名、fallback 行为和预留字段只能覆盖当前已确认意图，不得为了未来兼容默认添加。

## 错误与状态码

| 场景 | HTTP 状态码 | 错误码 | 说明 |
| --- | --- | --- | --- |
| {场景} | 400 | `{code}` | {说明} |

## 中间件与治理

- 鉴权：{策略}
- 限流：{策略}
- 日志：{字段}
- Trace：{传播方式}

## goctl 计划

```bash
goctl api go -api apis/{service}.api -dir services/{service}-api --style go_zero
```
