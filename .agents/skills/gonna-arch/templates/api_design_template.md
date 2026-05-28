# REST API 设计 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

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
