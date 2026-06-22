# Fix Iteration Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep YAML keys, IDs, status values, paths, commands, branch names, commit SHAs, API/RPC fields, Kafka topics, and raw output in their required technical form.

Generated: `YYYY-MM-DD`
Mode: `yolo-commit`
Push: `Not pushed`

## Scope

- Selftest document: `{docs/scrum/selftest/...}`
- Original Epic/Story: `{EPIC-X | STORY-X-XX | unknown}`
- Fix Epic: `{EPIC-X}`
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
- Fix Epic:
  - `{path}`
- Added or updated Stories:
  - `{path}`

## YOLO Fix

- `gonna-yolo` mode: `yolo-commit`
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
- [ ] If all required cases are `符合预期`, ask `gonna-commit` to commit selftest evidence and push.
- [ ] If any required case is `不符合预期`, run `gonna-fix` again.

## Blockers

- `{blocker or none}`
