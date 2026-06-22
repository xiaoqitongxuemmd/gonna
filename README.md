# Gonna

`gonna` 的含义是 **Go Next with Native AI**。

它是一个基于 [go-zero](https://go-zero.dev/) 的 AI-native 后端微服务工程框架。这个名字表达的是项目方向：让 go-zero 开发进入下一代工程工作流，使架构、规划、本地部署、开发和测试都可以被具备项目上下文的 AI skill 辅助。

## 项目提供什么

`gonna` 组合了：

- go-zero 服务生成与运行时约定。
- 位于 `.agents/skills/` 的项目级 AI skill。
- 来自 `.agents/ai-context/` 和 `.agents/skills/zero-skills/` 的 go-zero 参考知识。
- 位于 `docs/design/` 的架构优先设计文档。
- 位于 `docs/scrum/` 的 Epic、Story 和 KANBAN 规划视图。
- 位于 `deploy/local/` 的本地 Docker Compose 部署、依赖容器、微服务容器和可观测性支持。

目标不是替代 go-zero 原生工作流，而是让这套工作流更显式、更可重复、更适合 AI 读取。这样，一份设计文档可以被逐步转化为结构化、可追踪决策的 go-zero 微服务工程。

## Skill 链路

```text
gonna-arch -> gonna-plan -> gonna-yolo -> gonna-deploy/gonna-dev/gonna-test/gonna-commit -> gonna-selftest -> gonna-fix
```

每个项目 skill 都有明确职责：

- `gonna-arch` 将 PRD、规格说明和设计文档转化为 go-zero 架构、服务边界、契约、脚手架规划和环境契约。
- `gonna-plan` 将架构输出拆分并落成 AI 可执行的 Epic、Story、验收标准、依赖顺序和 KANBAN 进展视图；Epic 优先表示可验收的能力闭环，API、model、logic、test、selftest 等 go-zero 工程边界通常下沉为 Story。
- `gonna-deploy` 准备本地 Docker Compose 部署，统一组织依赖容器、开发中的 go-zero 微服务容器、profiles、健康检查和可观测性接入。框架默认不提供线上部署能力；线上部署需要根据具体项目和团队规范特化。
- `gonna-dev` 基于 go-zero 约定、goctl 生成、ServiceContext 注入和聚焦验证来实现 Story。
- `gonna-test` 验证验收标准、API/RPC 行为、集成路径和质量门禁。
- `gonna-selftest` 根据本地未 push 的改动生成 HTTP、Kafka 等微服务输入输出契约自测清单，并准备数据库、Redis、Kafka 等测试数据；每个 required case 必须人工勾选 `符合预期` 才允许 push。
- `gonna-fix` 在人工自测出现 `不符合预期` 后，读取自测反馈，协调 `gonna-arch` 更新设计意图，协调 `gonna-plan` 创建或追加意图对齐修复 Epic/Story，再用 `gonna-yolo` 的 `yolo-commit` 模式修复并更新 selftest。
- `gonna-commit` 将已经实现并验证过的变更整理成可评审提交，包括 commit plan、commit message、MR 描述和 commit report。
- `gonna-yolo` 在用户明确授权的 yolo mode 下，按 `gonna-plan` 的 Story 自动驱动 `gonna-dev -> gonna-test -> gonna-commit` 迭代，并在硬停止条件出现时中止；它只记录编排状态和阻塞点，不替代 `gonna-dev` 的实现报告或 `gonna-test` 的测试报告。

## 使用前建议

在正式使用 `gonna-*` skill 前，建议团队先明确自己的工程协作规范，并写入项目 README、团队手册或仓库级说明中。尤其要先建立分支管理规范，避免 AI 在提交、rebase、push、多 remote 同步或 MR 准备时根据通用模板猜测团队流程。

建议至少明确：

- 主干分支、集成分支、功能分支或镜像分支分别叫什么。
- 每个本地分支应该跟踪哪个 remote branch。
- 新功能、修复、文档和框架调整分别从哪个分支创建。
- push 前是否必须 rebase，以及 rebase 到哪个上游分支。
- 是否允许 force push；如允许，是否只能使用 `--force-with-lease`。
- MR/PR 的 source branch 和 target branch 规则。
- 多 remote 场景下，同一改动是否需要同步到多个远端，以及同步顺序。

`gonna-commit` 只负责读取当前 Git 事实、遵循团队已经明确的分支规范、检查提交和 push 风险；它不应该在 skill 内部替团队发明固定的分支模型。若团队尚未建立分支管理规范，提交和 push 前应先停下来确认。

`gonna` 工程框架不内置通用 DevOps skill。CI/CD、合并门禁、发布策略、制品仓库、镜像标签、部署审批和回滚流程在不同项目和团队之间差异很大，应在具体项目中单独特化。

## gonna-yolo 使用示例

`gonna-yolo` 适合在已经有 `gonna-arch` 和 `gonna-plan` 产物后，授权 AI 按 Epic/Story 自动推进。示例：

```text
看下 epic-5 开发的 block 是不是已经解决，如果解决以 yolo-commit 模式继续推进到 epic-7，逐 Epic 本地提交，不 push；遇到测试失败、架构歧义、外部依赖阻塞时停止
```

这条指令表达了几个关键约束：

- 先检查 `EPIC-5` 的 blocker 是否解除，未解除则停止并说明原因。
- 使用 `yolo-commit` 授权模式，可以本地 commit，但不能 push。
- 从 `EPIC-5` 继续推进到 `EPIC-7`，按 `gonna-plan` 的 Story 依赖和 `execution_order` 执行。
- 每个 Epic 独立形成本地提交，方便回看和回滚。
- 遇到测试失败、架构歧义、外部依赖阻塞等硬停止条件时立即中止。
- 如遇阻塞，阻塞报告写入 `docs/scrum/blocker/`，Story 和 KANBAN 状态回写到 `docs/scrum/`。

## 自测与 push 门禁

`gonna-selftest` 用来避免 AI 对设计意图集体理解偏差。它会根据本地未 push 的改动生成可人工执行的契约输入输出清单，并尽量自动准备好所需数据。

自测文档包含：

- HTTP 契约：每个发生变更的接口都要单独列出 request、response，以及一个可复制执行的独立 `curl`；如果一个接口有多个关键验收场景，每个场景都要单独给 `curl`。
- Kafka 契约：topic、消息结构字段，以及用于收发观察效果的 shell probe。
- AI 生成并准备的数据资产，例如 `seed.sql`、`cleanup.sql`、`kafka_probe.sh`、`seed_redis.py`。
- 每个契约用例只有两个人工结果：`符合预期` 或 `不符合预期`。
- `不符合预期` 下方提供反馈区，用于记录实际 response、副作用、设计偏差和建议调整。
- 自测文档不能被一个批量执行 HTTP API 的 shell 脚本替代；脚本只能用于数据准备、清理、观察或单个 Kafka/RPC 探针。

规则：

- 本地 commit 不强制完成自测。
- `docs/scrum/selftest/**` 不能和开发代码、go-zero 生成代码、自动化测试或规划修复混在同一个提交里。
- push 前必须完成 required selftest case。
- 只有所有 required case 都勾选 `符合预期` 才允许 push。
- 任何 `不符合预期` 都会阻止 push，并交给 `gonna-fix` 编排设计更新、修复规划、yolo-commit 修复和 selftest 更新。

推荐闭环：

```text
yolo 开发完成 -> 自动化测试 -> 提交实现改动 -> 生成 selftest -> 人工自测
```

如果人工自测通过：

```text
提交 selftest 证据 -> push
```

如果人工自测不通过：

```text
不符合预期反馈 -> gonna-fix -> gonna-arch 更新设计意图 -> gonna-plan 创建或更新意图对齐修复 Epic
-> gonna-yolo 以 yolo-commit 修复 Story -> commit amend 到本地未 push 的 Epic 实现提交
-> gonna-selftest 更新自测文档 -> 再次人工自测
```

同一个意图偏差反复修改时，新的修复 Story 应继续追加到同一个意图对齐修复 Epic 中。`amend` 只适用于本地未 push 的 Epic 实现提交；已经 push 的提交不默认改写历史。

`gonna-fix` 的修复迭代报告写入 `docs/scrum/fix-reports/`。`gonna-yolo` 的阻塞报告写入 `docs/scrum/blocker/`。`docs/scrum/selftest/` 只保留人工契约自测文档和数据资产。

## 内嵌参考资料

以下上游项目已经作为普通仓库文件内嵌到本项目中，使 AI 辅助工作流保持自包含和稳定：

- `.agents/ai-context/`: [zeromicro/ai-context](https://github.com/zeromicro/ai-context)
- `.agents/skills/zero-skills/`: [zeromicro/zero-skills](https://github.com/zeromicro/zero-skills)

它们是本地 `gonna-*` skill 的参考输入。只有当项目明确希望采纳新的 go-zero 指导时，才应有意识地更新这些参考资料。

## 文档语言约定

面向人阅读的项目产出默认使用简体中文，包括 README、设计文档、Epic、Story、KANBAN、环境说明、实现报告、测试计划和测试报告。

skill、agent instructions、模板和内嵌 reference 这类框架指导材料可以使用英文。代码、命令、路径、配置键、API/RPC 字段、状态枚举和必要技术术语保持原始技术形式。

## 兼容性设计约束

所有 `gonna-*` skill 默认不得做兼容性设计。API/RPC 接口、Kafka 事件、数据库字段、Redis key、配置项、迁移策略、测试用例和 selftest 用例都只能覆盖当前已确认意图。

如果确实需要向后兼容、向前兼容、旧接口别名、版本化接口、fallback、adapter、双写、双读、预留字段、migration-only 字段或未来扩展字段，必须先说明原因、影响范围、具体要增加的字段或接口、成本风险，并获得用户明确同意后才能写入设计、计划、代码、测试或自测文档。

## 设计文档约定

`docs/design/` 中受版本管理的 `*_vX.Y.Z.md` 正式设计文档是项目整体架构唯一信源。`gonna-plan`、`gonna-dev`、`gonna-test`、`gonna-deploy`、`gonna-selftest` 和 `gonna-yolo` 都应以这些正式设计文档为准。

临时说明、参考材料、草稿、聊天摘要、截图、技术摘录或未按版本规则命名的文件，即使被临时放进 `docs/design/`，也不能直接被视为正式架构事实。它们只能作为 `gonna-arch` 的输入材料。

如果临时材料中的技术细节需要被采纳，必须先由 `gonna-arch` 同步到对应的正式版本化设计文档中，再交给规划、开发、测试或部署流程使用。不要让设计意图只停留在临时文档、实现报告、测试报告、blocker 或 fix report 里。

`docs/design/` 只应放当前项目已经通过 `gonna-arch` 生成并采纳的架构事实文档。初始仓库不预置 `*_vX.Y.Z.md` 设计文档。

`gonna-arch` 可产出的架构文档模板位于 `.agents/skills/gonna-arch/templates/`。当用户提供 PRD、规格说明或设计文档后，`gonna-arch` 再基于这些模板生成对应的 `docs/design/*_vX.Y.Z.md`。

## 仓库结构

```text
.
|-- apis/              # REST API 契约源文件
|-- protos/            # RPC proto 契约源文件
|-- services/          # goctl 生成的 go-zero 服务
|-- models/            # 生成或共享的数据模型
|-- pkg/               # 稳定的跨服务共享包
|-- deploy/local/      # 本地 Docker Compose 部署、依赖容器、微服务容器与可观测性
|-- docs/design/       # 架构事实来源
|-- docs/scrum/        # Epic、Story 和规划视图
|-- docs/scrum/selftest/     # 人工契约自测文档和数据资产
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

本地部署：

```bash
make deploy-config
make deploy-up PROFILE=minimal
make deploy-ps
make deploy-down
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
