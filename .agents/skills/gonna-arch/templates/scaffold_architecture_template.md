# go-zero 脚手架架构 vX.Y.Z

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

{说明仓库布局和 go-zero 生成策略。}

## 仓库结构

```text
.
|-- apis/
|-- protos/
|-- services/
|-- models/
|-- pkg/
|-- deploy/
`-- docs/
```

## 目录职责

| 目录 | 职责 |
| --- | --- |
| `apis/` | REST API 契约源文件 |
| `protos/` | RPC proto 契约源文件 |
| `services/` | goctl 生成服务 |
| `models/` | 生成或共享模型 |
| `pkg/` | 稳定共享包 |

## goctl 生成计划

| 契约 | 输出目录 | 命令 |
| --- | --- | --- |
| `apis/{service}.api` | `services/{service}-api` | `goctl api go ...` |
| `protos/{service}.proto` | `services/{service}-rpc` | `goctl rpc protoc ...` |

## 手写边界

- `internal/logic`: {业务逻辑}
- `internal/svc`: {依赖注入}
- `internal/config`: {配置结构}
- `etc/*.yaml`: {运行配置}
- `pkg/`: {共享能力}

## 验证命令

```bash
go mod tidy
go build ./...
go test ./...
```
