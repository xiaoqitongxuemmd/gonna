# Scaffold Architecture v1.0.0

Version: v1.0.0
Created: 2026-05-28
Updated: 2026-05-28
Status: Draft

## Version History

| Version | Date | Changes | Author |
| --- | --- | --- | --- |
| v1.0.0 | 2026-05-28 | Initial go-zero monorepo scaffold baseline | gonna |

## Overview

This document defines the baseline repository structure for `gonna`, an ai-native engineering framework for go-zero based backend microservices.

The repository uses a monorepo layout. Contract source files live at the root level, while generated go-zero service projects live under `services/`.

## Repository Layout

```text
.
|-- apis/
|-- protos/
|-- services/
|   |-- gateway-api/
|   `-- system-rpc/
|-- models/
|-- pkg/
|-- deploy/
|   `-- local/
|-- docs/
|   |-- design/
|   `-- scrum/
|-- .agents/
|-- Makefile
|-- go.mod
`-- README.md
```

## Directory Responsibilities

| Directory | Responsibility |
| --- | --- |
| `apis/` | REST API contract source files consumed by `goctl api go` |
| `protos/` | RPC proto contract source files consumed by `goctl rpc protoc` |
| `services/` | Generated go-zero API and RPC service projects |
| `models/` | Generated or shared data models when architecture decides they are shared |
| `pkg/` | Stable cross-service packages with low business coupling |
| `deploy/local/` | Local dependencies, Docker Compose profiles, and observability config |
| `docs/design/` | Architecture source of truth |
| `docs/scrum/` | Epic, Story, KANBAN, and planning artifacts |
| `.agents/` | AI context, go-zero references, and project skills |

## go-zero Service Boundary

Each service under `services/` preserves go-zero generated structure:

```text
services/{name}/
|-- etc/
|-- internal/
|   |-- config/
|   |-- handler/
|   |-- logic/
|   |-- svc/
|   `-- types/
`-- {name}.go
```

RPC services omit handler and types when goctl does not generate them.

## Generation Commands

```bash
goctl api go -api apis/gateway.api -dir services/gateway-api --style go_zero
goctl rpc protoc protos/system.proto --go_out=services/system-rpc --go-grpc_out=services/system-rpc --zrpc_out=services/system-rpc --style go_zero
```

After generation:

```bash
go mod tidy
go build ./...
go test ./...
```

## Manual Implementation Boundary

Generated boilerplate should remain owned by goctl. Manual implementation should focus on:

- `internal/logic`
- `internal/svc`
- `internal/config`
- `etc/*.yaml`
- tests
- stable shared packages under `pkg/`

## Skill Handoff

- `gonna-arch` owns this scaffold architecture.
- `gonna-plan` consumes it to create Epic and Story work.
- `gonna-env` consumes environment contracts for local dependencies.
- `gonna-dev` implements Stories inside generated service boundaries.
- `gonna-test` validates acceptance criteria and quality gates.
