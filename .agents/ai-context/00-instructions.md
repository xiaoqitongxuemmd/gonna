# AI Instructions for go-zero

## File Priority

1. `workflows.md` - Task patterns
2. `tools.md` - goctl commands
3. `patterns.md` - Code patterns
4. [zero-skills](https://github.com/zeromicro/zero-skills) - Detailed patterns (查阅详细模式)

## Rules

### Spec-First
- ALWAYS create `.api` spec before code
- Write spec following patterns in `patterns.md`
- Validate with `goctl api validate`

### Tool Usage
- Use goctl commands in terminal, NOT manual code generation
- `goctl api new` for new API services
- `goctl rpc new` / `goctl rpc protoc` for new RPC services
- `goctl api go` for code from spec
- `goctl model mysql/pg/mongo` for database models
- Always run post-generation steps: `go mod tidy` → verify imports → `go build ./...`
- If goctl is not installed, install it: `go install github.com/zeromicro/go-zero/tools/goctl@latest`

### Implementation
- Generate FULL implementation, not stubs
- Fill logic layer with business code
- Add validation tags: `validate:"required,email"`
- Generate tests automatically

### Documentation
- ALWAYS generate README.md for new services
  - Service overview and purpose
  - API/RPC endpoint documentation
  - Configuration guide
  - Usage examples with curl/grpcurl
  - Testing instructions
- Generate API.md/RPC.md for detailed endpoint docs
- Include request/response examples
- Document error codes and handling

### Go-Zero Conventions
- Context first: `func(ctx context.Context, req *types.Request)`
- Errors: `errorx.NewCodeError(code, msg)`
- Config: `json:",default=value"`
- Validation: `validate:"required,min=3"`

## Decision Tree

```
User Request →
├─ New API? → Write .api spec → goctl api go → go mod tidy → go build → Generate docs
├─ New RPC? → Write .proto → goctl rpc protoc → go mod tidy → go build → Generate docs
├─ Database? → goctl model mysql/pg/mongo
└─ Modify? → Edit .api → goctl api go → go mod tidy → go build → Update docs
```

## Detailed Patterns

For complete implementation patterns, refer to [zero-skills](https://github.com/zeromicro/zero-skills):

- REST API → [rest-api-patterns.md](https://github.com/zeromicro/zero-skills/blob/main/references/rest-api-patterns.md)
- RPC Services → [rpc-patterns.md](https://github.com/zeromicro/zero-skills/blob/main/references/rpc-patterns.md)
- Database → [database-patterns.md](https://github.com/zeromicro/zero-skills/blob/main/references/database-patterns.md)
- Resilience → [resilience-patterns.md](https://github.com/zeromicro/zero-skills/blob/main/references/resilience-patterns.md)
- goctl Commands → [goctl-commands.md](https://github.com/zeromicro/zero-skills/blob/main/references/goctl-commands.md)
- Troubleshooting → [common-issues.md](https://github.com/zeromicro/zero-skills/blob/main/troubleshooting/common-issues.md)

## Avoid

- Empty stubs
- Missing validation
- `fmt.Errorf` for API errors (use `errorx.NewCodeError`)
- Manual SQL (use `goctl model`)
- Missing context
- Skipping post-generation steps (mod tidy, build verify)
- Mismatched `--style` flag with existing code
