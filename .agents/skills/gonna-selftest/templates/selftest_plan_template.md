# Selftest Plan

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep Story IDs, commands, paths, status values, env vars, JSON fields, SQL, and topic names in their required technical form.

Story or Epic: `{STORY-X-XX | EPIC-X}`
Generated: `YYYY-MM-DD`

## Scope

- Source Story/Epic: `{path}`
- Related design docs: `{paths}`
- Push gate: `Required | Optional`

## Required Cases

| Case | Contract | Required | Data Status | Result |
| --- | --- | --- | --- | --- |
| CASE-001 | REST API | yes | Prepared | Not Run |

## Generated Assets

| Asset | Purpose |
| --- | --- |
| `{path}` | seed data |

## Data Preparation Summary

- Status: `Prepared | Preparation Failed | Manual Command Provided`
- Commands executed by assistant:
  - `{command}`
- Fallback command:
  - `{command}`

## Push Gate Rule

- Required cases must be marked `Pass` before push.
- `Fail` blocks push and returns to `gonna-dev` or `gonna-test`.
- `Needs Design Update` blocks push and returns to `gonna-arch`.
