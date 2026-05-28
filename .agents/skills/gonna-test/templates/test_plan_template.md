# Test Plan

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep IDs, test layer names, commands, paths, coverage targets, and API/RPC names in their required technical form.

Story: `STORY-X-XX`
Scope: `{scope}`

## Source References

- Story: `{path}`
- Design: `{path}`
- API/RPC contract: `{path}`

## Acceptance Criteria Mapping

| Acceptance Criterion | Test Layer | Test Case | Expected Result |
| --- | --- | --- | --- |
| {criterion} | UT/API/RPC/Integration/Acceptance | {case} | {expected} |

## Quality Gates

| Gate | Target |
| --- | --- |
| Acceptance criteria coverage | 100% |
| Changed API/RPC contract coverage | 100% |
| Logic layer unit coverage | >= 85% |
| Critical business rule coverage | >= 90%, target 95% when practical |
| Overall unit coverage | >= 70% |
| `go test ./...` | pass |
| `go build ./...` | pass |

## Test Cases

### Unit Tests

- {test case}

### API Contract Tests

- {test case}

### RPC Contract Tests

- {test case}

### Integration Tests

- {test case}

### Acceptance Tests

- {test case}

## Test Data and Idempotency

- Setup: {setup}
- Cleanup: {cleanup}
- Isolation strategy: {strategy}

## Open Questions

- {question}
