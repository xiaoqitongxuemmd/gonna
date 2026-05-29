# YOLO Run Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep Story IDs, Epic IDs, status values, branch names, remotes, commit SHAs, commands, paths, and authorization mode names in their required technical form.

Generated: `YYYY-MM-DD`

## Summary

- Mode: `yolo-dev | yolo-submit | yolo-push`
- Scope: `{scope}`
- Result: `Completed | Partial | Blocked`
- Branch: `{branch}`
- Push target: `{remote/branch or none}`

## Story Results

| Story | Start Status | End Status | Commit | Result |
| --- | --- | --- | --- | --- |
| `STORY-X-XX` | TODO | COMPLETED | `{sha or none}` | {result} |

## Validation Evidence

| Story | Check | Result | Evidence |
| --- | --- | --- | --- |
| `STORY-X-XX` | `go test ./...` | pass/fail/not run | {evidence} |

## Files Updated

| Path | Reason |
| --- | --- |
| `{path}` | {reason} |

## Blockers

- {blocker or none}

## Handoff

- For `gonna-submit`: {submission notes}
- For future `gonna-devops`: {gate notes}
- Next action: {next action}
