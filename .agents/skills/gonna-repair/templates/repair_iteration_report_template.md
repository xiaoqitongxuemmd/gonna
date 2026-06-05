# Repair Iteration Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep YAML keys, IDs, status values, paths, commands, branch names, commit SHAs, API/RPC fields, Kafka topics, and raw output in their required technical form.

Generated: `YYYY-MM-DD`
Mode: `yolo-submit`
Push: `Not pushed`

## Scope

- Selftest document: `{docs/scrum/selftest/...}`
- Original Epic/Story: `{EPIC-X | STORY-X-XX | unknown}`
- Repair Epic: `{EPIC-X}`
- Branch: `{branch}`

## Failing Selftest Cases

| Case | Contract | Classification | Feedback Summary |
| --- | --- | --- | --- |
| `{HTTP-001}` | `{POST /path}` | `{Design intent mismatch | Implementation bug | Test gap | Selftest issue | Environment issue}` | `{summary}` |

## Architecture Handling

- `gonna-arch` used: `yes | no`
- Updated design docs:
  - `{path}`
- Design decisions:
  - `{decision}`

## Planning Handling

- `gonna-plan` used: `yes`
- Repair Epic:
  - `{path}`
- Added or updated Stories:
  - `{path}`

## YOLO Repair

- `gonna-yolo` mode: `yolo-submit`
- Stories executed:
  - `{STORY-X-XX}`
- Validation evidence:
  - `{command/result/report}`
- Local commits:
  - `{sha or amended commit}`

## Selftest Update

- `gonna-selftest` used: `yes`
- Updated selftest docs:
  - `{path}`
- Updated selftest assets:
  - `{path}`
- Selftest artifacts committed: `no | draft only | accepted evidence`

## Remaining User Action

- [ ] Run the updated human selftest.
- [ ] Mark each required case as `符合预期` or `不符合预期`.
- [ ] If all required cases are `符合预期`, ask `gonna-submit` to commit selftest evidence and push.
- [ ] If any required case is `不符合预期`, run `gonna-repair` again.

## Blockers

- `{blocker or none}`
