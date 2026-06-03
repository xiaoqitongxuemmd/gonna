# RPC 契约 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 概览

{说明 RPC 服务职责、调用方和内部契约边界。}

## Proto 文件

| 文件 | 服务 | 说明 |
| --- | --- | --- |
| `protos/{service}.proto` | `{service}-rpc` | {说明} |

## RPC 方法

| 方法 | 请求 | 响应 | 调用方 | 说明 |
| --- | --- | --- | --- | --- |
| `{Method}` | `{Request}` | `{Response}` | `{caller}` | {说明} |

## 消息定义

```proto
message {Request} {
  string field = 1;
}
```

## 兼容性审批

- 是否包含兼容性设计：yes/no
- 用户是否已明确批准：yes/no
- 批准依据：{对话、需求或设计引用}

未获得用户明确批准时，RPC 方法、message 字段、field tag、reserved 字段、旧消息别名、版本化服务和 fallback 行为只能覆盖当前已确认意图，不得为了未来兼容默认添加。

## 服务发现与配置

- 服务发现：etcd/direct
- 超时：{timeout}
- 重试：{retry policy}

## goctl 计划

```bash
goctl rpc protoc protos/{service}.proto --go_out=services/{service}-rpc --go-grpc_out=services/{service}-rpc --zrpc_out=services/{service}-rpc --style go_zero
```
