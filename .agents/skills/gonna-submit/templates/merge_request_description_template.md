# Merge Request Description

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep commands, paths, branch names, commit SHAs, Story IDs, URLs, and status literals in their required technical form.

## Summary

- {change}
- {change}

## Scope

- Story or request: `{story or request}`
- Source branch: `{branch}`
- Target branch: `{branch}`

## Changes

| Area | Files | Description |
| --- | --- | --- |
| {area} | `{path}` | {description} |

## Validation Evidence

| Check | Result | Evidence |
| --- | --- | --- |
| `go test ./...` | pass/fail/not run | {evidence} |
| `go build ./...` | pass/fail/not run | {evidence} |
| Acceptance criteria | pass/fail/partial | {evidence} |

## Risk and Rollback

- Risk: {risk}
- Rollback: {rollback approach}

## Review Notes

- {note}

## DevOps Gate Inputs

- Requires CI: yes/no
- Requires integration tests: yes/no
- Requires migration review: yes/no
- Requires observability review: yes/no
- Known gate exceptions: {exceptions or none}
