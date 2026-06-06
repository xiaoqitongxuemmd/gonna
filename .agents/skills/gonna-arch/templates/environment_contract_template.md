# 部署与环境契约 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 文档治理

- 唯一信源：yes
- 来源文档：{PRD/规格/正式设计文档路径}
- 非正式参考：{临时/参考材料路径或 none}
- 下游消费者：`gonna-plan`、`gonna-deploy`、`gonna-dev`、`gonna-test`

## 概览

{说明本地 Docker Compose 部署、开发调试、集成测试所需环境；线上部署需由具体项目按团队规范另行特化。}

## 运行时栈

| 组件 | 版本或约束 | 必需 | 说明 |
| --- | --- | --- | --- |
| Go | {version} | yes | {说明} |
| go-zero | {version} | yes | {说明} |
| goctl | {version} | yes | {说明} |

## 本地部署依赖

| 依赖 | 镜像或版本 | Profile | 端口 | 用途 |
| --- | --- | --- | --- | --- |
| PostgreSQL | `postgres:{version}` | minimal | `5432` | {用途} |

## 本地微服务容器

| 服务 | 类型 | 构建或镜像 | Profile | 端口 | 说明 |
| --- | --- | --- | --- | --- | --- |
| `{service}` | API/RPC | `{build or image}` | minimal | `{port}` | {说明} |

## Profiles

- `minimal`: {依赖}
- `integration`: {依赖}
- `observability`: {依赖}

## go-zero 配置映射

| 配置路径 | 环境变量 | 说明 |
| --- | --- | --- |
| `services/{service}/etc/{service}.yaml` | `{KEY}` | {说明} |

## 健康检查

- {依赖}: {检查命令或方式}

## 演进规则

- 当 feature 增加运行时依赖或微服务容器部署需求时，先更新本契约，再由 `gonna-deploy` 落地。
