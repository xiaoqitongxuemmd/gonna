---
id: "EPIC-{number}"
title: "{title}"
description: "{short description}"
status: "TODO"
priority: "P1"
layer: "APP_LAYER"
owner: ""
execution_order: 0
stories: []
dependencies: []
tags: []
source_docs: []
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
---

<!-- When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep YAML keys, IDs, status values, priority values, tags, paths, and technical identifiers in their required technical form. -->

# EPIC-{number}: {title}

## Overview

{Describe the end-to-end capability, accepted outcome, context, and value. Prefer a capability closure over a technical-layer bucket.}

## Capability Boundary

- Capability or delivery goal: {what can be accepted after this Epic}
- Primary contracts: {API/RPC/event/user workflow}
- Main data or state changes: {models, persistence, cache, status changes}
- Selftest surface: {HTTP/RPC/Kafka/DB/Redis contracts that should be human-verified}

## Scope

In scope:

- {item}

Out of scope:

- {item}

## Stories

- [ ] STORY-{number}-01: {story title}

<!-- A normal capability Epic should usually contain about 4 to 8 Stories. If this Epic has fewer than 4 Stories, explain why it is intentionally small instead of splitting by technical layer. -->

## Execution Order

- {dependency or sequence note}

## Acceptance Criteria

- [ ] All listed Stories are completed or explicitly cancelled.
- [ ] The capability can be verified as one coherent accepted state.
- [ ] Required documentation is updated.
- [ ] Validation evidence is recorded in the relevant Stories.

## Dependencies

- {dependency}

## Risks

| Risk | Impact | Mitigation |
| --- | --- | --- |
| {risk} | {impact} | {mitigation} |

## Source References

- {source document or design reference}
