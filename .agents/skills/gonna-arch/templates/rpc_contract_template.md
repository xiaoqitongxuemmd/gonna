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

## 服务发现与配置

- 服务发现：etcd/direct
- 超时：{timeout}
- 重试：{retry policy}

## goctl 计划

```bash
goctl rpc protoc protos/{service}.proto --go_out=services/{service}-rpc --go-grpc_out=services/{service}-rpc --zrpc_out=services/{service}-rpc --style go_zero
```
