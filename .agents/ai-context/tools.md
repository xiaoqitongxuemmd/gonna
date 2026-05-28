# goctl Tools

## Prerequisites

```bash
# Check goctl
which goctl && goctl --version

# Install if missing
go install github.com/zeromicro/go-zero/tools/goctl@latest
```

## create_api_service
Create REST API service with goctl
```bash
mkdir -p <output_dir> && cd <output_dir>
goctl api new <service_name> --style go_zero
go mod tidy
go build ./...
```

## create_rpc_service
Create gRPC service with goctl
```bash
mkdir -p <output_dir> && cd <output_dir>
goctl rpc new <service_name> --style go_zero
go mod tidy
go build ./...
```

Or from existing proto:
```bash
goctl rpc protoc <file>.proto --go_out=. --go-grpc_out=. --zrpc_out=. --style go_zero
go mod tidy
go build ./...
```

## generate_api_from_spec
Generate code from .api file
```bash
goctl api go -api <file>.api -dir . --style go_zero
go mod tidy
go build ./...
```
Safe to re-run — won't overwrite handler/logic files with custom code.

## generate_model
Generate database model from table

**MySQL (live DB):**
```bash
goctl model mysql datasource \
  -url "user:pass@tcp(host:3306)/db" \
  -table "<table>" -dir ./model --style go_zero
```

**MySQL (DDL file):**
```bash
goctl model mysql ddl -src <file>.sql -dir ./model --style go_zero
```

**With cache:** add `-cache` flag to any command above.

**PostgreSQL:**
```bash
goctl model pg datasource \
  -url "postgres://user:pass@host:5432/db?sslmode=disable" \
  -table "<table>" -dir ./model --style go_zero
```

**MongoDB:**
```bash
goctl model mongo -type <TypeName> -dir ./model --style go_zero
```

## validate_api_spec
Validate .api syntax
```bash
goctl api validate -api <file>.api
```

## analyze_project
Understand existing project structure
```bash
# List API routes
goctl api doc -dir .

# Check project file structure
find . -name "*.api" -o -name "*.proto" -o -name "*.go" | head -50
```

## generate_config_template
See [goctl-commands.md](https://github.com/zeromicro/zero-skills/blob/main/references/goctl-commands.md#6-config-templates) in zero-skills for config templates.

## generate_template
See [goctl-commands.md](https://github.com/zeromicro/zero-skills/blob/main/references/goctl-commands.md#7-deployment-templates) in zero-skills for Dockerfile, Kubernetes, and Docker Compose templates.

## Post-Generation Checklist

After EVERY goctl generation:
1. `[ ! -f go.mod ] && go mod init <module>` — init module if needed
2. `go mod tidy` — resolve dependencies
3. Verify imports match go.mod module path
4. `go build ./...` — confirm code compiles
5. Check `--style` flag matches existing file naming convention
