# 安全架构 vX.Y.Z

版本：vX.Y.Z
创建时间：YYYY-MM-DD
更新时间：YYYY-MM-DD
状态：Draft | Approved | Implementing | Deprecated

## 文档治理

- 唯一信源：yes
- 来源文档：{PRD/规格/正式设计文档路径}
- 非正式参考：{临时/参考材料路径或 none}
- 下游消费者：`gonna-plan`、`gonna-dev`、`gonna-test`、`gonna-selftest`

## 概览

{说明认证、鉴权、租户、密钥和数据保护边界。}

## 身份认证

| 场景 | 机制 | 说明 |
| --- | --- | --- |
| {场景} | JWT/OAuth2/API Key | {说明} |

## 权限模型

| 角色 | 权限 | 资源 | 说明 |
| --- | --- | --- | --- |
| `{role}` | `{permission}` | `{resource}` | {说明} |

## 租户与隔离

- 租户标识：{tenant key}
- 数据隔离：{策略}
- 配置隔离：{策略}

## 密钥与敏感配置

- {secret}: {管理方式}

## 安全验证

- {测试或审计要求}
