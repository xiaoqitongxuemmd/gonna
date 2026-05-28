---
name: gonna-plan
description: Use this skill when the user asks to split architecture output, PRDs, specifications, design documents, or go-zero implementation handoffs into Epics, Stories, acceptance criteria, planning phases, sprint-ready backlog, KANBAN, or progress tracking artifacts for this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# Planning Skill

This skill turns architecture and design intent into planned work. It is responsible for Epic and Story decomposition, acceptance criteria, dependencies, sprint planning, and progress tracking. It is not responsible for architecture design, code implementation, testing execution, or deployment execution.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development. It is expected to integrate skills for architecture, planning, development, testing, and deployment.

Use this skill as the planning layer:

- `gonna-arch`: source documents and design intent to go-zero architecture and implementation handoff
- `gonna-plan`: architecture handoff to Epics, Stories, acceptance criteria, and sprint-ready backlog
- `gonna-dev`: Stories to implementation tasks and code changes
- future `test`: Stories to verification plans and test evidence
- future `deploy`: release and deployment planning

## When to Use

Use this skill for:

- Splitting a go-zero implementation handoff into Epics and Stories
- Creating or updating `docs/scrum/prd/epic-*.md`
- Creating or updating `docs/scrum/story/story-*.md`
- Writing acceptance criteria for implementation Stories
- Planning phases or Sprint scope
- Producing a progress KANBAN from Epic and Story status
- Reviewing Story readiness before development
- Tracking Story state from TODO to COMPLETED
- Producing a backlog from PRD, specification, technical design, or `specx`-authored documents

If the source document has not yet been mapped to go-zero architecture, use `.agents/skills/gonna-arch/SKILL.md` first. If the user explicitly asks to split the source document directly, perform a lightweight architecture extraction before writing planning items.

## Inputs

Prefer one of these inputs:

- `gonna-arch` Architecture Analysis
- `gonna-arch` go-zero Scaffold Plan
- `gonna-arch` go-zero Implementation Handoff
- PRD or product requirements
- Technical design or architecture document
- API or data model draft
- Existing Epic or Story files

When input is incomplete, state assumptions and open questions rather than inventing hidden requirements.

## Internal go-zero References

When splitting go-zero implementation work, use these references as needed so Stories align with real engineering boundaries:

- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/goctl-commands.md` for generation boundaries
- `.agents/skills/zero-skills/references/rest-api-patterns.md` for REST API Stories
- `.agents/skills/zero-skills/references/rpc-patterns.md` for RPC Stories
- `.agents/skills/zero-skills/references/database-patterns.md` for model, cache, and persistence Stories
- `.agents/skills/zero-skills/references/resilience-patterns.md` for rate limit, circuit breaker, timeout, retry, and degradation Stories

The user should not need to invoke `zero-skills` directly.

## Output Modes

Choose the smallest useful mode.

### 1. Planning Breakdown

Use for planning in conversation before writing files.

Produce:

- Epic list
- Story list under each Epic
- Acceptance criteria per Story
- Dependencies and sequencing
- Suggested priority
- Estimated size
- Risks and open questions

### 2. Versioned Work Items

Use when the user wants files created or updated.

Create or update:

- `docs/scrum/prd/epic-{epic_number}-{short-name}.md`
- `docs/scrum/story/story-{epic_number}-{story_number}-{short-name}.md`

Use the templates in:

- `.agents/skills/gonna-plan/templates/epic_template.md`
- `.agents/skills/gonna-plan/templates/story_template.md`

### 3. Sprint Plan

Use when the user asks for iteration planning.

Produce:

- Sprint goal
- Selected Stories
- Excluded Stories
- Dependencies and blockers
- Capacity assumptions
- Definition of done
- Validation plan

### 4. Progress KANBAN

Use when the user asks for project progress, work status, or a KANBAN board.

Produce or update:

- `docs/scrum/KANBAN.md`

Use the template in:

- `.agents/skills/gonna-plan/templates/kanban_template.md`

The KANBAN must be derived from Epic and Story source files. Do not invent status data. If source files do not exist yet, produce a proposed KANBAN from the current breakdown and mark it as proposed.

## Single Source of Truth

For planning and progress tracking, source files are authoritative:

- Epic source files: `docs/scrum/prd/epic-*.md`
- Story source files: `docs/scrum/story/story-*.md`

Derived views such as `docs/scrum/KANBAN.md`, `docs/scrum/DASHBOARD.md`, or `docs/scrum/metadata.json` are optional. Do not treat derived views as authoritative when they conflict with Epic or Story files.

If derived views exist, update source files first, then regenerate or update views.

## KANBAN Rules

KANBAN columns use the same Story status values:

- `TODO`
- `IN_PROGRESS`
- `IN_REVIEW`
- `TESTING`
- `BLOCKED`
- `COMPLETED`
- `CANCELLED`

When generating a KANBAN:

1. Read Story files from `docs/scrum/story/`.
2. Group Stories by `status`.
3. Sort by priority, then Epic number, then Story number.
4. Include Story ID, title, priority, points, assignee, and target date when present.
5. Include a short summary with total Stories, completed Stories, blocked Stories, and completion rate.
6. If Epic files exist, include Epic progress based on their Stories.

If no Story files exist, produce a proposed KANBAN using the current planning breakdown and state that it is not yet source-backed.

## Epic Rules

Epic IDs use:

```text
EPIC-{number}
```

Epic files use:

```text
docs/scrum/prd/epic-{number}-{short-name}.md
```

Required Epic metadata:

```yaml
---
id: "EPIC-{number}"
title: "{title}"
description: "{short description}"
status: "TODO"
priority: "P1"
layer: "APP_LAYER"
owner: ""
start_date: ""
target_date: ""
completed_date: ""
stories: []
dependencies: []
tags: []
source_docs: []
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
---
```

Allowed `status` values:

- `TODO`
- `IN_PROGRESS`
- `IN_REVIEW`
- `TESTING`
- `COMPLETED`
- `BLOCKED`
- `CANCELLED`

Allowed `priority` values:

- `P0`: urgent or blocking
- `P1`: high priority
- `P2`: normal priority
- `P3`: low priority

Recommended `layer` values:

- `INFRA`
- `DATA_LAYER`
- `SERVICE_LAYER`
- `APP_LAYER`
- `CROSS_LAYER`
- `AI_NATIVE`
- `DEVEX`
- `DEPLOYMENT`
- `TESTING`

## Story Rules

Story IDs use:

```text
STORY-{epic_number}-{story_number}
```

Story numbers are two digits and scoped to the Epic:

```text
STORY-1-01
STORY-1-02
STORY-2-01
```

Story files use:

```text
docs/scrum/story/story-{epic_number}-{story_number}-{short-name}.md
```

Required Story metadata:

```yaml
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
```

Every Story must include:

- User value or engineering value
- Scope
- Acceptance criteria
- Implementation notes
- Validation plan
- Dependencies
- Risks
- Source document references

## Decomposition Rules

Use INVEST as a guide:

- Independent enough to implement without hidden cross-team coupling
- Negotiable where details can be refined during implementation
- Valuable to the project, developer workflow, or system capability
- Estimable with visible scope
- Small enough for one to five working days when possible
- Testable with clear acceptance criteria

For go-zero work, prefer Stories around concrete generated or hand-written boundaries:

- API spec creation or update
- RPC proto creation or update
- Model generation and persistence wiring
- ServiceContext dependency injection
- Logic implementation
- Middleware and auth integration
- Config and bootstrap wiring
- Tests and validation
- Deployment or local development setup
- Documentation and usage examples

Avoid Stories that mix too many layers unless the user asks for a thin vertical slice.

## Numbering Workflow

Before creating a new Story:

1. Identify the target Epic.
2. Inspect existing `docs/scrum/story/story-{epic_number}-*.md` files.
3. Use the next available two-digit Story number.
4. Keep filename, metadata `id`, title, and Epic `stories` list consistent.

Before creating a new Epic:

1. Inspect existing `docs/scrum/prd/epic-*.md` files.
2. Use the next available Epic number unless the user requests a specific number.
3. Keep filename and metadata `id` consistent.

If numbering conflicts exist, report them before creating new work items.

## Status Workflow

Use this status flow:

```text
TODO -> IN_PROGRESS -> IN_REVIEW -> TESTING -> COMPLETED
```

Any active Story can move to:

```text
BLOCKED
```

Cancelled work moves to:

```text
CANCELLED
```

Only mark a Story `COMPLETED` when acceptance criteria are satisfied and validation evidence exists. Evidence can include local build output, test output, review notes, or explicit user confirmation.

Do not require production access or production database checks by default. If production evidence is necessary, ask for explicit approval and scope first.

## Readiness Checklist

A Story is ready for development when:

- It has an Epic
- It has acceptance criteria
- It has source document or design references
- Dependencies are listed
- Scope is small enough to implement
- Validation steps are clear
- go-zero generation and manual implementation boundaries are clear

## Epic and Story Breakdown Format

When answering without writing files, use this format:

```markdown
## Planning Breakdown

### Epics

| Epic | Priority | Layer | Goal |
| --- | --- | --- | --- |
| EPIC-1 | P1 | APP_LAYER | Create user API service |

### Stories

| Story | Epic | Priority | Points | Goal |
| --- | --- | --- | --- | --- |
| STORY-1-01 | EPIC-1 | P1 | 3 | Define user API spec |

### Dependencies

- STORY-1-01 before STORY-1-02

### Open Questions

- Question 1
```

## KANBAN Format

When answering without writing files, use this format:

```markdown
## Progress KANBAN

Source: docs/scrum/story/
Generated: YYYY-MM-DD

### Summary

| Metric | Value |
| --- | --- |
| Total Stories | 0 |
| Completed | 0 |
| Blocked | 0 |
| Completion Rate | 0% |

### TODO

| Story | Priority | Points | Assignee | Target | Title |
| --- | --- | --- | --- | --- | --- |

### IN_PROGRESS

| Story | Priority | Points | Assignee | Target | Title |
| --- | --- | --- | --- | --- | --- |

### IN_REVIEW

| Story | Priority | Points | Assignee | Target | Title |
| --- | --- | --- | --- | --- | --- |

### TESTING

| Story | Priority | Points | Assignee | Target | Title |
| --- | --- | --- | --- | --- | --- |

### BLOCKED

| Story | Priority | Points | Assignee | Target | Title |
| --- | --- | --- | --- | --- | --- |

### COMPLETED

| Story | Priority | Points | Assignee | Target | Title |
| --- | --- | --- | --- | --- | --- |
```

## Handoff to Future Skills

When Epic and Story files are ready:

- Development work should use `.agents/skills/gonna-dev/SKILL.md`.
- Test planning and evidence should use future `test` skill instructions.
- Release and deployment planning should use future `deploy` skill instructions.

Until those skills exist, include implementation, validation, and deployment notes inside each Story.
