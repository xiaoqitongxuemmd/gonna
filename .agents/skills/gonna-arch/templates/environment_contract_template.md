# 环境契约 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 概览

{说明本地开发、调试和集成测试所需环境。}

## 运行时栈

| 组件 | 版本或约束 | 必需 | 说明 |
| --- | --- | --- | --- |
| Go | {version} | yes | {说明} |
| go-zero | {version} | yes | {说明} |
| goctl | {version} | yes | {说明} |

## 本地依赖

| 依赖 | 镜像或版本 | Profile | 端口 | 用途 |
| --- | --- | --- | --- | --- |
| PostgreSQL | `postgres:{version}` | minimal | `5432` | {用途} |

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

- 当 feature 增加运行时依赖时，先更新本契约，再由 `gonna-env` 落地。
