# Contract Selftest Checklist

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep Story IDs, branch names, commands, paths, status values, env vars, HTTP methods, JSON fields, SQL, Kafka topic names, and raw responses in their required technical form.

Story or Epic: `{STORY-X-XX | EPIC-X}`
Generated: `YYYY-MM-DD`

## Scope

- Source Story/Epic: `{path}`
- Related design docs: `{paths}`
- Push gate: `Required | Optional`
- Local change range: `{branch/upstream or commit range}`

## 本地未 push 改动的契约清单

| ID | Type | Contract | Required | Data Status | Human Result |
| --- | --- | --- | --- | --- | --- |
| HTTP-001 | HTTP | `POST /api/example` | yes | Prepared | 未勾选 |
| KAFKA-001 | Kafka | `topic.name` | yes | Prepared | 未勾选 |

生成规则：

- 每个 changed HTTP endpoint 至少生成一个独立 HTTP case。
- 每个 HTTP case 必须包含一个独立可复制的 `curl`。
- 如果同一个 endpoint 有多个关键验收场景，每个场景单独生成一个 case 和一个 `curl`。
- 不要用一个 shell 脚本批量调用多个 HTTP API 来替代逐接口验收。
- 数据准备脚本可以存在，但只能服务于 setup/cleanup，不能替代人工验收命令。

## 数据准备

| Asset | Purpose |
| --- | --- |
| `{path}` | seed data |

- Status: `Prepared | Preparation Failed | Manual Command Provided`
- Commands executed by assistant:
  - `{command}`
- Fallback command:
  - `{command}`

## Push Gate Rule

- Required cases must be checked as `符合预期` before push.
- `不符合预期` blocks push and the feedback determines whether to return to `gonna-arch`, `gonna-dev`, or `gonna-test`.
- Local commit does not require this checklist to be completed.
