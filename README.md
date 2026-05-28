# gonna

`gonna` is an ai-native engineering framework for go-zero based backend microservices.

It combines:

- go-zero service generation and runtime conventions
- project-level AI skills under `.agents/skills/`
- architecture-first source documents under `docs/design/`
- Epic and Story planning under `docs/scrum/`
- local dependency and observability support under `deploy/local/`

## Skill Chain

```text
gonna-arch -> gonna-plan -> gonna-env -> gonna-dev -> gonna-test -> future gonna-deploy
```

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
