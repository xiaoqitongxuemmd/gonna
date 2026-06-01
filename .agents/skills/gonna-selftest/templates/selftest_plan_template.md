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
