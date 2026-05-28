# Gonna

`gonna` 的含义是 **Go Next with Native AI**。

它是一个基于 [go-zero](https://go-zero.dev/) 的 AI-native 后端微服务工程框架。这个名字表达的是项目方向：让 go-zero 开发进入下一代工程工作流，使架构、规划、本地环境、开发和测试都可以被具备项目上下文的 AI skill 辅助。

## 项目提供什么

`gonna` 组合了：

- go-zero 服务生成与运行时约定。
- 位于 `.agents/skills/` 的项目级 AI skill。
- 来自 `.agents/ai-context/` 和 `.agents/skills/zero-skills/` 的 go-zero 参考知识。
- 位于 `docs/design/` 的架构优先设计文档。
- 位于 `docs/scrum/` 的 Epic、Story 和 KANBAN 规划视图。
- 位于 `deploy/local/` 的本地依赖和可观测性支持。

目标不是替代 go-zero 原生工作流，而是让这套工作流更显式、更可重复、更适合 AI 读取。这样，一份设计文档可以被逐步转化为结构化、可追踪决策的 go-zero 微服务工程。

## Skill 链路

```text
gonna-arch -> gonna-plan -> gonna-env -> gonna-dev -> gonna-test -> future gonna-deploy
```

每个项目 skill 都有明确职责：

- `gonna-arch` 将 PRD、规格说明和设计文档转化为 go-zero 架构、服务边界、契约、脚手架规划和环境契约。
- `gonna-plan` 将架构输出拆分为 Epic、Story、验收标准和 KANBAN 进展视图。
- `gonna-env` 准备本地依赖、Docker Compose profiles、健康检查和可观测性接入。
- `gonna-dev` 基于 go-zero 约定、goctl 生成、ServiceContext 注入和聚焦验证来实现 Story。
- `gonna-test` 验证验收标准、API/RPC 行为、集成路径和质量门禁。

## 内嵌参考资料

以下上游项目已经作为普通仓库文件内嵌到本项目中，使 AI 辅助工作流保持自包含和稳定：

- `.agents/ai-context/`: [zeromicro/ai-context](https://github.com/zeromicro/ai-context)
- `.agents/skills/zero-skills/`: [zeromicro/zero-skills](https://github.com/zeromicro/zero-skills)

它们是本地 `gonna-*` skill 的参考输入。只有当项目明确希望采纳新的 go-zero 指导时，才应有意识地更新这些参考资料。

## 文档语言约定

面向人阅读的项目产出默认使用简体中文，包括 README、设计文档、Epic、Story、KANBAN、环境说明、实现报告、测试计划和测试报告。

skill、agent instructions、模板和内嵌 reference 这类框架指导材料可以使用英文。代码、命令、路径、配置键、API/RPC 字段、状态枚举和必要技术术语保持原始技术形式。

## 仓库结构

```text
.
|-- apis/              # REST API 契约源文件
|-- protos/            # RPC proto 契约源文件
|-- services/          # goctl 生成的 go-zero 服务
|-- models/            # 生成或共享的数据模型
|-- pkg/               # 稳定的跨服务共享包
|-- deploy/local/      # 本地依赖与可观测性
|-- docs/design/       # 架构事实来源
|-- docs/scrum/        # Epic、Story 和规划视图
`-- .agents/           # AI 上下文与 skill
```

## 快速开始

运行框架检查：

```bash
make tools-check
make generate
make tidy
make build
make test
```

本地环境：

```bash
make env-config
make env-up PROFILE=minimal
make env-ps
make env-down
```

## go-zero 边界

根目录下的 `apis/` 和 `protos/` 是契约源文件。生成后的服务位于 `services/*`，并保持 go-zero 原生结构：

```text
services/{service}/
|-- etc/
|-- internal/
`-- {service}.go
```

业务逻辑应放在生成服务的 `internal/logic` 中，依赖通过生成服务的 `internal/svc` 注入。
