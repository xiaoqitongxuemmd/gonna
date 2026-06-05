GOCTL ?= $(shell command -v goctl 2>/dev/null || echo $(HOME)/go/bin/goctl)
PROFILE ?= minimal
COMPOSE_FILE ?= deploy/local/docker-compose.yaml
export PATH := $(HOME)/go/bin:/opt/homebrew/bin:$(PATH)

.PHONY: tools-check tools-install generate tidy fmt build test docker-check deploy-config deploy-up deploy-down deploy-ps deploy-logs

tools-check:
	@go version
	@$(GOCTL) --version

tools-install:
	go install github.com/zeromicro/go-zero/tools/goctl@latest

generate:
	$(GOCTL) api validate -api apis/gateway.api
	$(GOCTL) api go -api apis/gateway.api -dir services/gateway-api --style go_zero
	$(GOCTL) rpc protoc protos/system.proto --go_out=services/system-rpc --go-grpc_out=services/system-rpc --zrpc_out=services/system-rpc --style go_zero

tidy:
	go mod tidy

fmt:
	go fmt ./...

build:
	go build ./...

test:
	go test ./...

docker-check:
	@command -v docker >/dev/null 2>&1 || (echo "docker is required for local deployment commands" && exit 1)
	@docker compose version >/dev/null

deploy-config: docker-check
	docker compose -f $(COMPOSE_FILE) --profile $(PROFILE) config

deploy-up: docker-check
	docker compose -f $(COMPOSE_FILE) --profile $(PROFILE) up -d

deploy-down: docker-check
	docker compose -f $(COMPOSE_FILE) --profile $(PROFILE) down

deploy-ps: docker-check
	docker compose -f $(COMPOSE_FILE) --profile $(PROFILE) ps

deploy-logs: docker-check
	docker compose -f $(COMPOSE_FILE) --profile $(PROFILE) logs -f
