# 附录：新手终端命令速查表

这份速查表汇总了全书用到的所有核心命令，每条命令都标注了出处章节和用途。你可以把这页打印出来贴在电脑旁边，查起来很方便。

---

## OpenClaw 安装与管理

| 命令 | 用途 | 章节 |
|------|------|------|
| `npm install -g openclaw` | 安装 OpenClaw | Ch8 |
| `openclaw --version` | 查看 OpenClaw 版本 | Ch8 |
| `openclaw start` | 启动 OpenClaw | Ch8 |
| `openclaw stop` | 停止 OpenClaw | Ch8 |
| `openclaw restart` | 重启 OpenClaw | Ch8 |

## 技能管理

| 命令 | 用途 | 章节 |
|------|------|------|
| `clawhub --version` | 查看 clawhub 版本 | Ch13 |
| `clawhub search 关键词` | 搜索技能 | Ch13 |
| `clawhub install 技能名` | 安装技能 | Ch13 |
| `clawhub publish 技能名` | 发布自己的技能到 ClawHub | Ch18 |
| `rm -rf ~/.openclaw/skills/技能名` | 删除技能 | Ch13 |

## 文件与目录操作

下面的命令 macOS 和 Windows（PowerShell）基本通用。少数不同的地方我标出来了。

| 命令 | 用途 | 说明 |
|------|------|------|
| `ls`（macOS）/ `dir`（Windows） | 列出当前目录的文件 | 基础命令 |
| `ls -la`（macOS）/ `dir -Force`（Windows） | 列出所有文件（包含隐藏文件） | 看隐藏文件 |
| `cd 目录名` | 进入某个目录 | `cd ~` 回到主目录 |
| `mkdir -p 目录名`（macOS）/ `mkdir 目录名 -Force`（Windows） | 创建文件夹 | `-p`/`-Force` 自动创建父目录 |
| `rm 文件名`（macOS）/ `Remove-Item 文件名`（Windows） | 删除文件 | ⚠️ 删了无法恢复 |
| `cat 文件名`（macOS）/ `Get-Content 文件名`（Windows） | 查看文件内容 | 适合看短文件 |
| `open .`（macOS）/ `explorer .`（Windows） | 在 Finder/资源管理器 打开当前文件夹 | 很实用 |

> 💡 **好消息**：本书用到的大部分命令（`npm`、`node`、`clawhub`、`openclaw`、`code`、`docker`）在 macOS 和 Windows 里是完全一样的，不用区分。只有 `ls`、`rm`、`mkdir -p`、`cat` 这几个基础命令有差异。

## 查看隐藏文件

| 系统 | 方法 |
|------|------|
| macOS Finder | `Command + Shift + .`（按一下显示、再按隐藏） |
| macOS 终端 | `ls -la` 就能看到 |
| Windows 资源管理器 | 查看 → 显示隐藏的项目 |
| Windows PowerShell | `dir -Force` 就能看到 |

## 环境变量设置

```bash
# 临时设置（关掉终端就没了）
export TAVILY_API_KEY="你的Key"

# 永久设置（写入配置文件）
echo 'export TAVILY_API_KEY="你的Key"' >> ~/.zshrc
source ~/.zshrc
```

> 💡 **macOS 现在默认用 zsh**，所以写到 `~/.zshrc`。如果你用的是 bash，写到 `~/.bashrc`。

## Node.js 与 npm

| 命令 | 用途 | 章节 |
|------|------|------|
| `node --version` | 查看 Node.js 版本 | Ch7 |
| `npm --version` | 查看 npm 版本 | Ch7 |
| `npm install -g 包名` | 全局安装一个包 | Ch8 |

## Docker（进阶）

| 命令 | 用途 | 章节 |
|------|------|------|
| `docker run -d --name n8n -p 5678:5678 n8nio/n8n` | 安装并启动 n8n | Ch27 |
| `docker ps` | 查看正在运行的容器 | - |
| `docker stop 容器名` | 停止容器 | - |
| `docker start 容器名` | 启动容器 | - |

## 常用快捷操作

| 操作 | macOS | Windows |
|------|-------|---------|
| 打开终端 | `Command + Space` → 输入"终端" | `Win + R` → 输入"cmd" |
| 复制 | `Command + C` | `Ctrl + C` |
| 粘贴（终端） | `Command + V` | 右键 → 粘贴 |
| 中断当前命令 | `Ctrl + C` | `Ctrl + C` |
| 清屏 | `Command + K` 或 `clear` | `cls` |

## 关键配置文件速查

| 文件 | 位置 | 用途 |
|------|------|------|
| `openclaw.json` | `~/.openclaw/openclaw.json` | OpenClaw 核心配置（模型、定时任务等） |
| `SOUL.md` | `~/.openclaw/SOUL.md` | AI 性格设定 |
| `USER.md` | `~/.openclaw/USER.md` | 用户信息 |
| `SKILL.md` | `~/.openclaw/skills/技能名/SKILL.md` | 技能定义 |
| `.zshrc` | `~/.zshrc` | 终端环境配置 |

> 💡 **`~` 是什么？** `~` 代表你的"主目录"。在 macOS 上就是 `/Users/你的用户名/`，在 Windows 上就是 `C:\Users\你的用户名\`。

---

## 遇到问题怎么办？

1. 先看看第 28 章（出了问题怎么办）
2. 在终端敲 `openclaw --help` 看看帮助信息
3. 去 GitHub Issues 搜搜有没有人遇到过同样的问题
4. 实在搞不定，**把报错信息截图发到社区**，大家会帮你

---
