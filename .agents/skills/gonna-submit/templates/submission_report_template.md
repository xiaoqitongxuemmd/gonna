# Submission Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep commands, paths, branch names, commit SHAs, remotes, URLs, Story IDs, and status literals in their required technical form.

Generated: `YYYY-MM-DD`

## Result

Status: `Prepared | Committed | Pushed | Blocked`

## Scope

- Request or Story: `{request or STORY-X-XX}`
- Branch: `{branch}`
- Commit: `{sha or none}`
- Remote: `{remote or URL}`
- Target branch: `{branch}`

## Submitted Changes

| File | Change | Reason |
| --- | --- | --- |
| `{path}` | added/modified/deleted | {reason} |

## Commands Run

| Command | Result | Notes |
| --- | --- | --- |
| `git status --short` | {result} | {notes} |
| `git diff --stat` | {result} | {notes} |
| `git add ...` | {result} | {notes} |
| `git commit ...` | {result} | {notes} |
| `git push ...` | {result} | {notes} |

## Validation Evidence

| Evidence | Result | Notes |
| --- | --- | --- |
| Implementation report | present/missing | {notes} |
| Test report | present/missing | {notes} |
| Build/test commands | pass/fail/not run | {notes} |

## Handoff to DevOps

- MR/PR description: {path or inline}
- Gate risks: {risks}
- Required checks: {checks}
- Exceptions requested: {exceptions or none}
