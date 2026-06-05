---
name: gonna-deploy
description: Use this skill when the user asks to create, update, run, or verify local deployment assets for this ai-native go-zero microservice framework project. It provides local deployment through Docker Compose, organizing dependency containers and development microservice containers together.
version: 1.0.0
license: MIT
---

# Deploy Skill

This skill materializes local deployment contracts for `gonna`: Docker Compose files, dependency containers, go-zero microservice containers, local env files, go-zero config mapping, observability wiring, health checks, and local deployment runbooks.

The generic `gonna` framework does not provide online deployment, production release, CI/CD, or DevOps behavior because those rules vary heavily by project and team. If a project needs online deployment, create project-specific architecture, instructions, and skills outside this default local deployment skill.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the deployment materialization layer:

- `gonna-arch`: defines technical stack, deployment/environment contract, and observability architecture
- `gonna-plan`: turns architecture into Epics and Stories
- `gonna-deploy`: materializes local Docker Compose deployment
- `gonna-dev`: implements go-zero services that can be containerized and run by the local deployment
- `gonna-test`: validates services using the local deployment

## When to Use

Use this skill for:

- Creating or updating local Docker Compose deployment plans
- Organizing local dependency containers and development microservice containers in one Compose topology
- Adding go-zero API/RPC service containers for services under `services/`
- Adding database, cache, queue, service discovery, or object storage dependency containers
- Adding Kafka, Redis, MySQL, PostgreSQL, MongoDB, etcd, MinIO, or similar local services
- Adding OpenTelemetry Collector, Prometheus, Grafana, Jaeger, Tempo, or Loki for observability
- Mapping local dependency values to go-zero `etc/*.yaml` config
- Creating or updating `.env` guidance for local deployment
- Defining local deployment profiles such as `minimal`, `integration`, `observability`, and service-specific profiles
- Verifying container health, network connectivity, and sample service startup
- Producing local deployment runbooks or healthcheck reports
- Updating local deployment when a feature adds infrastructure dependencies or new microservices
- Updating local deployment assets when a project-specific online deployment workflow requires local parity inputs

If the required stack, service list, or local deployment target is unclear, ask `gonna-arch` to produce or update the deployment/environment contract first. Do not choose major infrastructure technologies or online deployment platforms inside this generic skill.

## Inputs

Prefer one of these inputs:

- `docs/design/environment_contract_vX.Y.Z.md`
- `docs/design/observability_architecture_vX.Y.Z.md`
- `gonna-arch` technical stack decision
- `gonna-arch` go-zero scaffold plan
- `gonna-dev` implementation needs
- `gonna-test` integration or observability needs
- Existing `deploy/local/`, `docker-compose*.yaml`, `.env*`, or `etc/*.yaml` files
- Existing service directories under `services/`

When input is incomplete, produce a deployment proposal and clearly mark assumptions.

## Language Policy

Produce human-facing deployment output in Simplified Chinese by default. This includes local deployment plans, `deploy/local/README.md`, deployment runbooks, healthcheck reports, observability notes, dependency explanations, and user-facing summaries.

Keep Docker image names, service names, ports, environment variable names, config keys, paths, commands, and protocol names in their required technical form. Skill instructions, templates, and low-level config files may remain in English when that is the natural technical format.

## Internal References

Use these project resources as internal references:

- `.agents/skills/gonna-arch/SKILL.md` for deployment/environment contract expectations
- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/database-patterns.md` for database, Redis, cache, and model configuration
- `.agents/skills/zero-skills/references/rpc-patterns.md` for etcd/service discovery and RPC dependencies
- `.agents/skills/zero-skills/references/resilience-patterns.md` for local testing of timeout, retry, rate limit, and circuit breaker behavior
- `.agents/skills/zero-skills/troubleshooting/common-issues.md` for debugging go-zero runtime issues

The user should not need to invoke these references directly.

## Output Modes

Choose the smallest useful mode.

### 1. Local Deployment Plan

Use when the user asks what local deployment, dependencies, or service containers are needed.

Produce:

- Required services
- Development microservices
- Optional services
- Profiles
- Ports
- Credentials placeholders
- Volumes
- go-zero config mapping
- Health checks
- Open questions

### 2. Local Compose Deployment Scaffold

Use when the user asks to create or update local deployment files.

Create or update:

- `deploy/local/docker-compose.yaml`
- `deploy/local/.env.example`
- `deploy/local/README.md`
- Optional observability config files under `deploy/local/observability/`
- Optional Dockerfiles or service build references for development microservices when the project has not already defined them

Use templates in:

- `.agents/skills/gonna-deploy/templates/docker_compose_template.yaml`
- `.agents/skills/gonna-deploy/templates/env_template.md`
- `.agents/skills/gonna-deploy/templates/observability_config_template.md`

### 3. Healthcheck and Debug Report

Use when the user asks to verify local deployment status.

Produce:

- Container status
- Connection checks
- go-zero config checks
- Observability target checks
- Failed dependency diagnosis
- Next actions

Use:

- `.agents/skills/gonna-deploy/templates/healthcheck_report_template.md`

## Local Deployment Profiles

Use profiles to avoid starting unnecessary services.

### minimal

For focused local development and debugging.

Typical services:

- Current Story dependencies only
- Current target microservice
- One database if required
- Redis only if required

### integration

For service integration and `gonna-test` integration checks.

Typical services:

- Database
- Redis
- Kafka or message broker
- etcd if go-zero RPC service discovery is required
- Object storage if required
- Target API/RPC services that participate in the integration scenario

### observability

For tracing, metrics, logs, and local debugging.

Typical services:

- OpenTelemetry Collector
- Prometheus
- Grafana
- Jaeger or Tempo
- Loki when log aggregation is required
- All integration dependencies needed by the target service
- Target API/RPC services with observability enabled

## Local Compose Service Rules

Do not add dependencies or service containers because they are popular. Add them because the deployment contract, architecture design, Story, implementation, or test scenario needs them.

For every dependency container, define:

- Purpose
- Required profile
- Docker image and version constraint
- Port mapping
- Credentials placeholder
- Volume requirement
- Health check
- go-zero config mapping

For every go-zero microservice container, define:

- Service name and type: API, RPC, job, worker, consumer, or other
- Source directory under `services/`
- Build context and Dockerfile, or a prebuilt image reference
- Runtime command or entrypoint
- Config file mounted or baked into the image
- Required dependency containers and `depends_on` health checks
- Exposed ports when needed
- Profile membership
- Log, metrics, and trace settings when observability is enabled

Use version-pinned images where practical. Avoid `latest` in durable project files.

Do not commit real secrets. Use examples and placeholders.

## go-zero Config Mapping

For each service dependency, map local values to go-zero config.

Examples:

- Database DSN to `etc/{service}.yaml`
- Redis host, type, pass, and key prefix
- Kafka broker list and topic names
- etcd hosts for zrpc service discovery
- OpenTelemetry collector endpoint
- Prometheus scrape endpoint
- Log level and trace correlation fields

Inspect existing `etc/*.yaml` files before editing or recommending exact fields.

## Online Deployment Boundary

Local Docker Compose deployment is the default. Do not create Kubernetes, Helm, Terraform, cloud, production, staging, or CI/CD deployment assets by default.

Do not add online deployment assets from this generic skill. When a project needs online deployment, require a project-specific workflow or skill that defines:

- Target platform
- Environment names
- Image registry and tag strategy
- Secret management
- Runtime config source
- Network and ingress rules
- Observability requirements
- Rollback and release gate expectations

This local deployment skill may provide Docker Compose parity notes for those project-specific workflows, but it must not author the online deployment implementation itself.

## Observability Rules

When observability is requested, define:

- What metrics should be exposed
- Where Prometheus should scrape
- Where traces should be exported
- How logs should include trace IDs
- Which Grafana dashboards are expected
- Which sample request should produce observable signals

For go-zero services, prefer explicit service name, environment, and version labels.

Do not assume the exact go-zero telemetry config shape without inspecting the current code and config.

## Healthcheck Rules

A local deployment is ready when required checks pass:

- Docker Compose config is valid
- Required containers are running or healthy
- Database connection works
- Redis ping works when Redis is required
- Kafka broker is reachable and topics can be listed or created when Kafka is required
- etcd is reachable when zrpc discovery is required
- OpenTelemetry Collector is reachable when observability is enabled
- Prometheus targets are up when Prometheus is enabled
- Grafana is reachable when Grafana is enabled
- The target go-zero service starts with local config
- A sample request produces expected logs, traces, or metrics when observability is enabled

If a check cannot run, explain why and list the residual risk.

## Safe Execution

Prefer planning and file generation before starting services.

When asked to run local deployment:

- Inspect existing compose files first.
- Avoid overwriting user customizations.
- Use `docker compose config` before `docker compose up`.
- Use profile-specific startup when possible.
- Do not remove volumes or data unless the user explicitly asks.
- Do not access production systems.

## Local Deployment Plan Format

When answering without writing files, use this format:

```markdown
## Local Deployment Plan

### Source Contract

- `{path or summary}`

### Profiles

| Profile | Services | Purpose |
| --- | --- | --- |
| minimal | {services} | {purpose} |
| integration | {services} | {purpose} |
| observability | {services} | {purpose} |

### Microservices

| Service | Type | Build/Image | Profile | Ports | Purpose |
| --- | --- | --- | --- | --- | --- |
| `{service}` | API/RPC | `{build or image}` | minimal | `{port}` | {purpose} |

### Dependencies

| Service | Image | Profile | Ports | Purpose |
| --- | --- | --- | --- | --- |
| postgres | postgres:{version} | minimal | 5432:5432 | Primary database |

### go-zero Config Mapping

| Config | Value Source | Description |
| --- | --- | --- |
| `etc/{service}.yaml` | `{ENV_VAR}` | {description} |

### Health Checks

- {check}

### Open Questions

- {question}
```

## Handoff

When local deployment files are ready:

- `gonna-dev` uses them to run and debug services.
- `gonna-test` uses them for integration and observability verification.
- `gonna-submit` may include local deployment changes in the submission scope when requested.
