---
id: "STORY-{epic_number}-{story_number}"
epic_id: "EPIC-{epic_number}"
title: "{title}"
description: "{short description}"
status: "TODO"
priority: "P1"
story_points: 3
assignee: ""
start_date: ""
target_date: ""
completed_date: ""
dependencies: []
tags: []
source_docs: []
design_refs: []
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
---

<!-- When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep YAML keys, IDs, status values, priority values, tags, paths, and technical identifiers in their required technical form. -->

# STORY-{epic_number}-{story_number}: {title}

## Value

As a {role}, I want {capability}, so that {outcome}.

## Scope

In scope:

- {item}

Out of scope:

- {item}

## Acceptance Criteria

- [ ] {criterion}
- [ ] {criterion}
- [ ] {criterion}

## Implementation Notes

- go-zero specs:
  - `{api or proto path}`
- Generated code boundary:
  - `{generated files or directories}`
- Manual implementation boundary:
  - `{logic, svc, config, model, tests}`

## Validation Plan

- [ ] `go mod tidy`
- [ ] `go build ./...`
- [ ] {focused test or manual verification}

## Dependencies

- {dependency}

## Risks

| Risk | Impact | Mitigation |
| --- | --- | --- |
| {risk} | {impact} | {mitigation} |

## Source References

- {source document or design reference}
