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
gonna-arch -> gonna-plan -> gonna-yolo -> gonna-env/gonna-dev/gonna-test/gonna-selftest/gonna-submit -> future gonna-devops -> future gonna-deploy
```

每个项目 skill 都有明确职责：

- `gonna-arch` 将 PRD、规格说明和设计文档转化为 go-zero 架构、服务边界、契约、脚手架规划和环境契约。
- `gonna-plan` 将架构输出拆分并落成 AI 可执行的 Epic、Story、验收标准、依赖顺序和 KANBAN 进展视图。
- `gonna-env` 准备本地依赖、Docker Compose profiles、健康检查和可观测性接入。
- `gonna-dev` 基于 go-zero 约定、goctl 生成、ServiceContext 注入和聚焦验证来实现 Story。
- `gonna-test` 验证验收标准、API/RPC 行为、集成路径和质量门禁。
- `gonna-selftest` 生成 push 前由人执行的契约自测文档，并准备数据库、Redis、Kafka 等测试数据；每个 required case 必须人工勾选 `Pass` 才允许 push。
- `gonna-submit` 将已经实现并验证过的变更整理成可评审提交，包括 commit plan、commit message、MR 描述和 submission report。
- `gonna-yolo` 在用户明确授权的 yolo mode 下，按 `gonna-plan` 的 Story 自动驱动 `gonna-dev -> gonna-test -> gonna-submit` 迭代，并在硬停止条件出现时中止。

## gonna-yolo 使用示例

`gonna-yolo` 适合在已经有 `gonna-arch` 和 `gonna-plan` 产物后，授权 AI 按 Epic/Story 自动推进。示例：

```text
看下 epic-5 开发的 block 是不是已经解决，如果解决以 submit 模式继续推进到 epic-7，逐 Epic 本地提交，不 push；遇到测试失败、架构歧义、外部依赖阻塞时停止
```

这条指令表达了几个关键约束：

- 先检查 `EPIC-5` 的 blocker 是否解除，未解除则停止并说明原因。
- 使用 `yolo-submit` 授权模式，可以本地 commit，但不能 push。
- 从 `EPIC-5` 继续推进到 `EPIC-7`，按 `gonna-plan` 的 Story 依赖和 `execution_order` 执行。
- 每个 Epic 独立形成本地提交，方便回看和回滚。
- 遇到测试失败、架构歧义、外部依赖阻塞等硬停止条件时立即中止。
- 执行报告写入 `docs/run/`，Story 和 KANBAN 状态回写到 `docs/scrum/`。

## 自测与 push 门禁

`gonna-selftest` 用来避免 AI 对设计意图集体理解偏差。它会为 Story 或 Epic 生成可人工执行的契约自测文档，并尽量自动准备好所需数据。

自测文档包含：

- 可复制执行的 `curl`、`grpcurl`、Kafka producer、SQL、Redis 检查等命令。
- AI 生成并准备的数据资产，例如 `seed.sql`、`cleanup.sql`、`produce_kafka_event.py`、`seed_redis.py`。
- 每个测试用例的人工验收勾选项。
- 每个测试用例的结果：`Pass | Fail | Needs Design Update | Not Run`。
- 反馈区，用于记录实际 response、副作用、设计偏差和建议调整。

规则：

- 本地 commit 不强制完成自测。
- push 前必须完成 required selftest case。
- 只有所有 required case 都是 `Pass` 才允许 push。
- `Fail` 会回到 `gonna-dev` 或 `gonna-test` 修复。
- `Needs Design Update` 会回到 `gonna-arch` 更新设计文档。

## 内嵌参考资料

以下上游项目已经作为普通仓库文件内嵌到本项目中，使 AI 辅助工作流保持自包含和稳定：

- `.agents/ai-context/`: [zeromicro/ai-context](https://github.com/zeromicro/ai-context)
- `.agents/skills/zero-skills/`: [zeromicro/zero-skills](https://github.com/zeromicro/zero-skills)

它们是本地 `gonna-*` skill 的参考输入。只有当项目明确希望采纳新的 go-zero 指导时，才应有意识地更新这些参考资料。

## 文档语言约定

面向人阅读的项目产出默认使用简体中文，包括 README、设计文档、Epic、Story、KANBAN、环境说明、实现报告、测试计划和测试报告。

skill、agent instructions、模板和内嵌 reference 这类框架指导材料可以使用英文。代码、命令、路径、配置键、API/RPC 字段、状态枚举和必要技术术语保持原始技术形式。

## 设计文档约定

`docs/design/` 只放当前项目已经通过 `gonna-arch` 生成并采纳的架构事实文档。初始仓库不预置 `*_vX.Y.Z.md` 设计文档。

`gonna-arch` 可产出的架构文档模板位于 `.agents/skills/gonna-arch/templates/`。当用户提供 PRD、规格说明或设计文档后，`gonna-arch` 再基于这些模板生成对应的 `docs/design/*_vX.Y.Z.md`。

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
|-- docs/run/          # yolo 自动执行报告
|-- docs/selftest/     # 人工契约自测文档和数据资产
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
