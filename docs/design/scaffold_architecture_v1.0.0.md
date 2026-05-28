# 脚手架架构 v1.0.0

版本：v1.0.0
创建时间：2026-05-28
更新时间：2026-05-28
状态：Draft

## 版本历史

| 版本 | 日期 | 变更 | 作者 |
| --- | --- | --- | --- |
| v1.0.0 | 2026-05-28 | 建立 go-zero monorepo 脚手架基线 | gonna |

## 概览

本文档定义 `gonna` 的基础仓库结构。`gonna` 是一个面向 go-zero 后端微服务开发的 AI-native 工程框架。

仓库采用 monorepo 布局。契约源文件位于根目录，goctl 生成的 go-zero 服务工程位于 `services/` 下。

## 仓库结构

```text
.
|-- apis/
|-- protos/
|-- services/
|   |-- gateway-api/
|   `-- system-rpc/
|-- models/
|-- pkg/
|-- deploy/
|   `-- local/
|-- docs/
|   |-- design/
|   `-- scrum/
|-- .agents/
|-- Makefile
|-- go.mod
`-- README.md
```

## 目录职责

| 目录 | 职责 |
| --- | --- |
| `apis/` | REST API 契约源文件，由 `goctl api go` 消费 |
| `protos/` | RPC proto 契约源文件，由 `goctl rpc protoc` 消费 |
| `services/` | 生成后的 go-zero API 和 RPC 服务工程 |
| `models/` | 架构决策需要共享时放置生成或共享的数据模型 |
| `pkg/` | 低业务耦合、稳定的跨服务共享包 |
| `deploy/local/` | 本地依赖、Docker Compose profiles 和可观测性配置 |
| `docs/design/` | 架构事实来源 |
| `docs/scrum/` | Epic、Story、KANBAN 和规划产物 |
| `.agents/` | AI 上下文、go-zero 参考资料和项目 skill |

## go-zero 服务边界

`services/` 下的每个服务都保留 go-zero 生成结构：

```text
services/{name}/
|-- etc/
|-- internal/
|   |-- config/
|   |-- handler/
|   |-- logic/
|   |-- svc/
|   `-- types/
`-- {name}.go
```

RPC 服务在 goctl 未生成时可以没有 `handler` 和 `types`。

## 生成命令

```bash
goctl api go -api apis/gateway.api -dir services/gateway-api --style go_zero
goctl rpc protoc protos/system.proto --go_out=services/system-rpc --go-grpc_out=services/system-rpc --zrpc_out=services/system-rpc --style go_zero
```

生成后执行：

```bash
go mod tidy
go build ./...
go test ./...
```

## 手写实现边界

生成样板代码应由 goctl 维护。手写实现应聚焦在：

- `internal/logic`
- `internal/svc`
- `internal/config`
- `etc/*.yaml`
- 测试
- `pkg/` 下稳定的共享包

## Skill 交接

- `gonna-arch` 负责维护这份脚手架架构。
- `gonna-plan` 消费它来创建 Epic 和 Story。
- `gonna-env` 消费环境契约来准备本地依赖。
- `gonna-dev` 在生成服务边界内实现 Story。
- `gonna-test` 验证验收标准和质量门禁。
