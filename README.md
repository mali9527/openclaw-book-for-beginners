# OpenClaw 小龙虾入门指南

> 🦞 给普通人的 OpenClaw 完整入门教程，全程通俗易懂，从零搭建你的个人 AI 助手

## 内容简介

这是一本面向**纯零基础普通人**的 OpenClaw 入门教程，你不需要编程基础，就能一步步搭建属于自己的 AI 助手。

## 项目结构

```
src/chapters/     ← 章节源文件（Markdown）
src/images/       ← 插图素材
templates/pdf/    ← PDF 排版配置
templates/html/   ← HTML 模板（计划中）
pub/pdf/          ← PDF 输出
scripts/          ← 构建脚本
docs/             ← 项目文档
```

## 阅读方式

1. **在线阅读**：直接在 GitHub 浏览 `src/chapters/` 下的各章节
2. **PDF 下载**：
   - [A4 电脑版](./pub/pdf/openclaw-book.pdf)
   - [手机版](./pub/pdf/openclaw-book-mobile.pdf)

## 目录

### 第一部分：AI 智能体基础
- [前言：为什么你需要一个"能干活"的AI助手](./src/chapters/01-preface.md)
- [什么是 AI 智能体？](./src/chapters/02-what-is-agent.md)
- [五个核心组件](./src/chapters/03-core-concepts.md)
- [为什么现在智能体火了？](./src/chapters/04-why-now.md)

### 第二部分：认识 OpenClaw
- [OpenClaw 到底是什么？](./src/chapters/05-what-is-openclaw.md)
- [OpenClaw 的架构](./src/chapters/06-architecture.md)
- [分层记忆系统](./src/chapters/07-memory-system.md)

### 第三部分：安装配置上手
- [准备工作](./src/chapters/08-prepare.md)
- [安装 OpenClaw](./src/chapters/09-install.md)
- [配置大模型](./src/chapters/10-config-model.md)
- [接入飞书](./src/chapters/11-feishu-integration.md)
- [设定 AI 性格](./src/chapters/12-personality.md)

### 第四部分：技能系统
- [技能是什么？](./src/chapters/13-what-is-skills.md)
- [ClawHub 技能商店](./src/chapters/14-clawhub.md)
- [15 个必装实用技能](./src/chapters/15-recommended-skills.md)

### 第五部分：实际场景和玩法
- [6 个开箱即用的场景](./src/chapters/16-entry-scenarios.md)
- [社区最有创意的 6 个玩法](./src/chapters/16.5-creative-cases.md)
- [5 个进阶玩法](./src/chapters/17-advanced-scenarios.md)
- [项目实战：用 OpenClaw 写一本书](./src/chapters/18-project实战.md)

### 第六部分：排错和安全
- [出了问题怎么办？](./src/chapters/19-troubleshooting.md)
- [安全第一](./src/chapters/20-security.md)
- [写在最后](./src/chapters/21-ending.md)

## 构建 PDF

```bash
# 一键构建所有版本
./scripts/build.sh

# 只生成 A4 PDF
./scripts/build.sh pdf

# 只生成手机版 PDF
./scripts/build.sh mobile
```

需要先安装：Pandoc、BasicTeX（见 [准备工作](./src/chapters/08-prepare.md)）。

## 许可证

MIT License

## 作者

**马力** · 资深产品经理、AI 研究者

🦞 本书由人类 + OpenClaw 协作完成

📖 抖音：**马力AI和商业思维**
