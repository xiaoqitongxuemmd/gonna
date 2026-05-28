# go-zero AI Context

English | [简体中文](#简体中文)

Transform any AI coding assistant into a go-zero expert with one prompt.

## One-Prompt Setup

Just tell your AI assistant:

```
Set up go-zero AI tools for this project from https://github.com/zeromicro/ai-context
```

Your AI will automatically:
1. Detect which AI tool you're using (Claude Code, Cursor, Copilot, Windsurf)
2. Install the appropriate configuration
3. Set up zero-skills knowledge base

## What Gets Installed

This prompt sets up a two-layer AI assistance system:

```
┌─────────────────────────────────────────────────────────────┐
│                     AI Assistant                            │
│  (Claude Code, GitHub Copilot, Cursor, Windsurf)           │
└────────────┬─────────────────────┬──────────────────────────┘
             │                     │
             ├─ Workflow Layer ────┤
             │  ai-context         │  "What to do" - Quick decisions
             │  (~5KB)             │  Loaded for every interaction
             │                     │
             └─ Knowledge Layer ───┘
                zero-skills          "How & Why" - Detailed patterns
                (~40KB)              + goctl command reference
                                     Loaded when needed
```

The AI runs `goctl` directly in the terminal for code generation — no separate tools or servers needed.

| Component | Purpose | Size | Repository |
|-----------|---------|------|------------|
| **ai-context** | Workflow instructions, decision trees | ~5KB | [zeromicro/ai-context](https://github.com/zeromicro/ai-context) |
| **zero-skills** | Comprehensive patterns, best practices, goctl reference | ~45KB | [zeromicro/zero-skills](https://github.com/zeromicro/zero-skills) |

## Manual Setup

If you prefer manual installation, choose your AI tool:

### Claude Code

```bash
# Install ai-context (workflow instructions)
git submodule add https://github.com/zeromicro/ai-context.git .claude/ai-context

# Install zero-skills (knowledge base + goctl reference)
git submodule add https://github.com/zeromicro/zero-skills.git .claude/skills/zero-skills
```

### GitHub Copilot

```bash
# Add ai-context as submodule
git submodule add https://github.com/zeromicro/ai-context.git .github/ai-context

# Create symlink for Copilot
ln -s ai-context/00-instructions.md .github/copilot-instructions.md

# Add zero-skills for reference
git submodule add https://github.com/zeromicro/zero-skills.git .ai-context/zero-skills
```

### Cursor

```bash
# Add ai-context as rules directory
git submodule add https://github.com/zeromicro/ai-context.git .cursorrules

# Add zero-skills for reference
git submodule add https://github.com/zeromicro/zero-skills.git .ai-context/zero-skills
```

Cursor automatically reads all `.md` files in `.cursorrules` directory.

### Windsurf

```bash
# Add ai-context as rules directory
git submodule add https://github.com/zeromicro/ai-context.git .windsurfrules

# Add zero-skills for reference
git submodule add https://github.com/zeromicro/zero-skills.git .ai-context/zero-skills
```

## After Setup

Once installed, your AI assistant can:

**Generate Services:**
```
Create a user management API with CRUD operations
```

**Apply Patterns:**
```
Add rate limiting and circuit breaker to my API
```

**Troubleshoot Issues:**
```
Why am I getting "http: named cookie not present" error?
```

**Follow Best Practices:**
```
Review my handler code for go-zero anti-patterns
```

## Updating

Keep your AI context up to date:

```bash
# Update all submodules at once
git submodule update --remote --recursive

# Or update individually
git submodule update --remote .github/ai-context  # Copilot
git submodule update --remote .cursorrules        # Cursor
git submodule update --remote .windsurfrules      # Windsurf
git submodule update --remote .ai-context/zero-skills
git submodule update --remote .claude/skills/zero-skills
```

## How It Works

### ai-context (This Repo)

Provides lightweight workflow instructions:
- **Decision trees**: When to use API vs RPC
- **File priority**: Which files to read first
- **Tool usage**: How to use goctl commands
- **Quick patterns**: Common code snippets

### zero-skills

Provides comprehensive knowledge:
- **REST API patterns**: Handler → Logic → Model architecture
- **RPC patterns**: Service discovery, load balancing
- **Database patterns**: SQL, MongoDB, Redis, caching
- **Resilience patterns**: Circuit breaker, rate limiting
- **goctl commands**: Complete reference for all goctl operations, post-generation steps, templates
- **Troubleshooting**: Common errors and solutions

### How Code Generation Works

The AI runs `goctl` directly in the terminal — the same tool go-zero developers use manually:

```bash
# AI writes .api spec → runs goctl → fixes imports → builds
goctl api go -api user.api -dir . --style go_zero
go mod tidy
go build ./...
```

No separate MCP server or binary needed. Just `goctl` and Go.

## Feature Comparison

| Feature | Claude Code | Cursor | Copilot | Windsurf |
|---------|-------------|--------|---------|----------|
| ai-context | ✅ Auto-load | ✅ Via rules | ✅ Via instructions | ✅ Via rules |
| zero-skills | ✅ Native skills | ✅ Reference | ✅ Reference | ✅ Reference |
| goctl code gen | ✅ Terminal | ✅ Terminal | ✅ Terminal | ✅ Terminal |
| Subagent workflows | ✅ | ❌ | ❌ | ❌ |

## Requirements

- Go 1.19+
- goctl (install: `go install github.com/zeromicro/go-zero/tools/goctl@latest`)
- Git

## Related Projects

- [go-zero](https://github.com/zeromicro/go-zero) - The framework
- [zero-skills](https://github.com/zeromicro/zero-skills) - Knowledge base

## License

MIT License - Same as go-zero framework

---

# 简体中文

将任何 AI 编程助手变成 go-zero 专家，只需一个提示。

## 一键安装

只需告诉你的 AI 助手：

```
Set up go-zero AI tools for this project from https://github.com/zeromicro/ai-context
```

AI 会自动：
1. 检测你使用的 AI 工具（Claude Code、Cursor、Copilot、Windsurf）
2. 安装相应的配置
3. 设置 zero-skills 知识库

## 安装内容

这个提示会设置一个两层 AI 辅助系统：

```
┌─────────────────────────────────────────────────────────────┐
│                     AI 助手                                  │
│  (Claude Code, GitHub Copilot, Cursor, Windsurf)           │
└────────────┬─────────────────────┬──────────────────────────┘
             │                     │
             ├─ 工作流层 ──────────┤
             │  ai-context         │  "做什么" - 快速决策
             │  (~5KB)             │  每次交互都加载
             │                     │
             └─ 知识层 ────────────┘
                zero-skills          "如何和为什么" - 详细模式
                (~45KB)              + goctl 命令参考
                                     需要时加载
```

AI 在终端中直接运行 `goctl` 生成代码——无需额外工具或服务器。

| 组件 | 用途 | 大小 | 仓库 |
|------|------|------|------|
| **ai-context** | 工作流指令、决策树 | ~5KB | [zeromicro/ai-context](https://github.com/zeromicro/ai-context) |
| **zero-skills** | 完整模式、最佳实践、goctl 参考 | ~45KB | [zeromicro/zero-skills](https://github.com/zeromicro/zero-skills) |

## 手动安装

如果你喜欢手动安装，选择你的 AI 工具：

### Claude Code

```bash
# 安装 ai-context（工作流指令）
git submodule add https://github.com/zeromicro/ai-context.git .claude/ai-context

# 安装 zero-skills（知识库 + goctl 参考）
git submodule add https://github.com/zeromicro/zero-skills.git .claude/skills/zero-skills
```

### GitHub Copilot

```bash
# 添加 ai-context 作为子模块
git submodule add https://github.com/zeromicro/ai-context.git .github/ai-context

# 创建 Copilot 符号链接
ln -s ai-context/00-instructions.md .github/copilot-instructions.md

# 添加 zero-skills 作为参考
git submodule add https://github.com/zeromicro/zero-skills.git .ai-context/zero-skills
```

### Cursor

```bash
# 添加 ai-context 作为规则目录
git submodule add https://github.com/zeromicro/ai-context.git .cursorrules

# 添加 zero-skills 作为参考
git submodule add https://github.com/zeromicro/zero-skills.git .ai-context/zero-skills
```

Cursor 自动读取 `.cursorrules` 目录中的所有 `.md` 文件。

### Windsurf

```bash
# 添加 ai-context 作为规则目录
git submodule add https://github.com/zeromicro/ai-context.git .windsurfrules

# 添加 zero-skills 作为参考
git submodule add https://github.com/zeromicro/zero-skills.git .ai-context/zero-skills
```

## 安装后

安装完成后，你的 AI 助手可以：

**生成服务：**
```
创建一个包含 CRUD 操作的用户管理 API
```

**应用模式：**
```
给我的 API 添加限流和熔断
```

**排查问题：**
```
为什么我会收到 "http: named cookie not present" 错误？
```

**遵循最佳实践：**
```
检查我的 handler 代码是否存在 go-zero 反模式
```

## 更新

保持 AI 上下文最新：

```bash
# 一次更新所有子模块
git submodule update --remote --recursive

# 或单独更新
git submodule update --remote .github/ai-context  # Copilot
git submodule update --remote .cursorrules        # Cursor
git submodule update --remote .windsurfrules      # Windsurf
git submodule update --remote .ai-context/zero-skills
git submodule update --remote .claude/skills/zero-skills
```

## 工作原理

### ai-context（本仓库）

提供轻量级工作流指令：
- **决策树**：何时使用 API vs RPC
- **文件优先级**：优先读取哪些文件
- **工具使用**：如何使用 goctl 命令
- **快速模式**：常用代码片段

### zero-skills

提供完整知识：
- **REST API 模式**：Handler → Logic → Model 架构
- **RPC 模式**：服务发现、负载均衡
- **数据库模式**：SQL、MongoDB、Redis、缓存
- **弹性模式**：熔断器、限流
- **goctl 命令**：所有 goctl 操作的完整参考、生成后步骤、模板
- **故障排查**：常见错误和解决方案

### 代码生成方式

AI 在终端中直接运行 `goctl`——与 go-zero 开发者手动使用的工具相同：

```bash
# AI 编写 .api 规范 → 运行 goctl → 修复导入 → 构建
goctl api go -api user.api -dir . --style go_zero
go mod tidy
go build ./...
```

无需额外的 MCP 服务器或二进制文件。只需 `goctl` 和 Go。

## 功能对比

| 功能 | Claude Code | Cursor | Copilot | Windsurf |
|------|-------------|--------|---------|----------|
| ai-context | ✅ 自动加载 | ✅ 通过规则 | ✅ 通过指令 | ✅ 通过规则 |
| zero-skills | ✅ 原生技能 | ✅ 引用 | ✅ 引用 | ✅ 引用 |
| goctl 代码生成 | ✅ 终端 | ✅ 终端 | ✅ 终端 | ✅ 终端 |
| 子代理工作流 | ✅ | ❌ | ❌ | ❌ |

## 环境要求

- Go 1.19+
- goctl（安装：`go install github.com/zeromicro/go-zero/tools/goctl@latest`）
- Git

## 相关项目

- [go-zero](https://github.com/zeromicro/go-zero) - 框架本身
- [zero-skills](https://github.com/zeromicro/zero-skills) - 知识库

## 许可证

MIT License - 与 go-zero 框架相同
