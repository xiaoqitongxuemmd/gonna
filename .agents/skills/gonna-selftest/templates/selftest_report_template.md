# Selftest Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep Story IDs, commands, paths, status values, commit SHAs, and raw responses in their required technical form.

Generated: `YYYY-MM-DD`

## Summary

- Story or Epic: `{STORY-X-XX | EPIC-X}`
- Result: `Allowed | Blocked`
- Required cases: `{count}`
- 符合预期: `{count}`
- 不符合预期: `{count}`
- 未勾选: `{count}`

## Case Results

| Case | Contract | Required | Human Result | Feedback |
| --- | --- | --- | --- | --- |
| HTTP-001 | `POST /api/example` | yes | 符合预期 | none |

## Data Assets

| Path | Status |
| --- | --- |
| `{path}` | Prepared |

## Push Gate

- Status: `Allowed | Blocked`
- Reason: {reason}

## Handoff

- To `gonna-arch`: {design-intent feedback or none}
- To `gonna-dev`: {implementation feedback or none}
- To `gonna-test`: {contract test update or none}
- To `gonna-submit`: {push gate status}
