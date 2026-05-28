# AI Workflows

## 1. New API Service

```
1. Ask requirements
2. Write .api spec file (follow patterns.md)
3. Show spec, get approval
4. goctl api go -api <file>.api -dir . --style go_zero
5. go mod tidy && go build ./...
6. Implement logic in internal/logic/
7. Generate tests
8. Generate README.md (service overview, API docs, usage examples)
9. Generate API.md (detailed endpoint documentation)
```

## 2. New RPC Service

```
1. Ask requirements
2. Write .proto file
3. Show proto, get approval
4. goctl rpc protoc <file>.proto --go_out=. --go-grpc_out=. --zrpc_out=. --style go_zero
5. go mod tidy && go build ./...
6. Implement methods in internal/logic/
7. Generate tests
8. Generate README.md (service overview, proto docs, usage examples)
9. Generate RPC.md (detailed method documentation)
```

## 3. Database Model

```
1. Get DB type and connection info
2. goctl model mysql datasource -url "<dsn>" -table "<table>" -dir ./model --style go_zero
3. Add to ServiceContext
4. Use in logic
```

## 4. Modify API

```
1. Edit .api file
2. goctl api validate -api <file>.api
3. goctl api go -api <file>.api -dir . --style go_zero
4. go mod tidy && go build ./...
5. Update logic
6. Update tests
```

## 5. Add Auth

```
1. Add JWT config to etc/<service>.yaml
2. Create login endpoint (generate token)
3. Add @server(jwt: Auth) to protected routes in .api
4. Re-generate: goctl api go -api <file>.api -dir . --style go_zero
5. Access userId from context in logic
```

## 6. Add Caching

```
1. Add cache config to etc/<service>.yaml
2. Re-generate model with -cache flag:
   goctl model mysql datasource -url "<dsn>" -table "<table>" -dir ./model -cache --style go_zero
3. Use cache.CacheConf in config
```

## 7. Add Validation

```
1. Add validate tags to types in .api spec
2. Add Validator to ServiceContext
3. Call Validator.StructCtx in logic
```

## Decision Matrix

| Request | Workflow |
|---------|----------|
| Create API | 1 + 7 |
| Add database | 3 + 6 |
| Protect endpoint | 5 |
| Modify API | 4 |
| Add RPC | 2 |
