# Commit Plan

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep commands, paths, branch names, Story IDs, commit subjects, and status literals in their required technical form.

## Scope

- Request or Story: `{request or STORY-X-XX}`
- Branch: `{branch}`
- Commit type: `feat | fix | docs | test | chore | ci | refactor`
- Proposed subject: `{commit subject}`

## Files to Stage

| File | Reason | Source |
| --- | --- | --- |
| `{path}` | {reason} | user/dev/test/generated |

## Files Not Staged

| File | Reason |
| --- | --- |
| `{path}` | {reason} |

## Evidence

| Evidence | Status | Notes |
| --- | --- | --- |
| Implementation report | present/missing | {notes} |
| Test report | present/missing | {notes} |
| `go test ./...` | pass/fail/not run | {notes} |
| `go build ./...` | pass/fail/not run | {notes} |

## Risks

- {risk or none}

## Next Action

- {stage/commit/push/MR preparation}
