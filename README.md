# Gonna

`gonna` means **Go Next with Native AI**.

It is an AI-native engineering framework for backend microservices built with
[go-zero](https://go-zero.dev/). The name reflects the project's direction:
take go-zero development to its next engineering workflow, where architecture,
planning, local environments, implementation, and testing can be assisted by
project-aware AI skills.

## What It Provides

`gonna` combines:

- go-zero service generation and runtime conventions.
- Project-level AI skills under `.agents/skills/`.
- go-zero reference knowledge from `.agents/ai-context/` and `.agents/skills/zero-skills/`.
- Architecture-first source documents under `docs/design/`.
- Epic, Story, and KANBAN planning under `docs/scrum/`.
- Local dependency and observability support under `deploy/local/`.

The goal is not to replace go-zero's native workflow. The goal is to make the
workflow more explicit, repeatable, and AI-readable, so a design document can be
turned into a structured go-zero microservice project with traceable decisions.

## Skill Chain

```text
gonna-arch -> gonna-plan -> gonna-env -> gonna-dev -> gonna-test -> future gonna-deploy
```

Each project skill has a focused role:

- `gonna-arch` turns PRDs, specifications, and design documents into go-zero architecture, service boundaries, contracts, scaffold plans, and environment contracts.
- `gonna-plan` splits architecture output into Epics, Stories, acceptance criteria, and KANBAN progress views.
- `gonna-env` prepares local dependencies, Docker Compose profiles, health checks, and observability wiring.
- `gonna-dev` implements Stories using go-zero conventions, goctl generation, ServiceContext wiring, and focused validation.
- `gonna-test` verifies acceptance criteria, API/RPC behavior, integration paths, and quality gates.

## Repository Layout

```text
.
|-- apis/              # REST API contract source files
|-- protos/            # RPC proto contract source files
|-- services/          # goctl generated go-zero services
|-- models/            # generated or shared data models
|-- pkg/               # stable cross-service packages
|-- deploy/local/      # local dependencies and observability
|-- docs/design/       # architecture source of truth
|-- docs/scrum/        # Epics, Stories, and planning views
`-- .agents/           # AI context and skills
```

## Quick Start

Initialize or refresh submodules first:

```bash
git submodule update --init --recursive
```

Then run the framework checks:

```bash
make tools-check
make generate
make tidy
make build
make test
```

Local environment:

```bash
make env-config
make env-up PROFILE=minimal
make env-ps
make env-down
```

## go-zero Boundary

Root-level `apis/` and `protos/` are contract sources. Generated services live under `services/*` and keep go-zero's native structure:

```text
services/{service}/
|-- etc/
|-- internal/
`-- {service}.go
```

Business logic belongs in generated `internal/logic`. Dependencies are wired through generated `internal/svc`.
