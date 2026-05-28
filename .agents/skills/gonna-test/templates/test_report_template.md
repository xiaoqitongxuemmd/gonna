# Test Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep IDs, result values, commands, paths, coverage targets, and raw output in their required technical form.

Story: `STORY-X-XX`
Result: `Pass | Conditional Pass | Fail`
Generated: `YYYY-MM-DD`

## Summary

- {summary}

## Commands and Results

| Command | Result | Notes |
| --- | --- | --- |
| `go test ./...` | {result} | {notes} |
| `go build ./...` | {result} | {notes} |

## Acceptance Criteria Verification

| Acceptance Criterion | Evidence | Result |
| --- | --- | --- |
| {criterion} | {evidence} | {result} |

## Coverage

| Metric | Target | Actual | Result |
| --- | --- | --- | --- |
| Logic layer unit coverage | >= 85% | {actual} | {result} |
| Critical business rule coverage | >= 90%, target 95% | {actual} | {result} |
| Overall unit coverage | >= 70% | {actual} | {result} |

## Defects

| ID | Severity | Summary | Status |
| --- | --- | --- | --- |
| {id} | {severity} | {summary} | {status} |

## Recommendation

`Pass | Conditional Pass | Fail`

Rationale:

- {reason}

## Follow-Up

- {item}
