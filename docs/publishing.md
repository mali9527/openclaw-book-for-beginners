# 发布指南

本文档说明如何构建、验证和发布《OpenClaw 零基础入门》的各个版本。

---

## 发布渠道总览

| 渠道 | 地址 | 触发方式 |
|------|------|----------|
| **Web 在线版** | https://mali9527.github.io/openclaw-book-for-beginners/ | push 到 master 自动部署 |
| **PDF 标准版** | 网站首页"PDF（图书发行版）"按钮 | push 时 CI 自动构建 |
| **PDF 手机版** | 网站首页"PDF（手机优化版）"按钮 | push 时 CI 自动构建 |
| **GitHub 仓库** | https://github.com/mali9527/openclaw-book-for-beginners | push 即更新 |

---

## 自动发布流程（推荐）

每次 push 到 `master` 分支，GitHub Actions 自动完成以下步骤：

```
push 代码 → CI 安装 LaTeX → 合并章节 → 构建两个 PDF
    → 同步章节/图片到 Web → 构建 VitePress → 部署 GitHub Pages
```

**你只需要做一件事：push 代码。** 其他全自动。

### 典型发布流程

```bash
# 1. 编辑章节内容
vim src/chapters/XX-chapter-name.md

# 2. 提交并推送
git add -A
git commit -m "update: 修改了第 XX 章内容"
git push

# 3. 等待 5-10 分钟，自动部署完成
# 查看进度：https://github.com/mali9527/openclaw-book-for-beginners/actions
```

### CI 构建耗时参考

| 步骤 | 耗时 |
|------|------|
| 安装 LaTeX 和 Pandoc | ~2 分钟 |
| 构建两个 PDF | ~3 分钟 |
| 构建 VitePress | ~1 分钟 |
| 部署 GitHub Pages | ~1 分钟 |
| **总计** | **~7 分钟** |

---

## 本地构建

### 前置依赖

```bash
# macOS 安装
brew install pandoc
brew install --cask mactex   # XeLaTeX（约 4GB）
brew install node            # Node.js 20+
```

### 构建命令

```bash
# 合并章节（PDF 构建的前置步骤）
./scripts/build.sh merge

# 生成 B5 标准版 PDF
./scripts/build.sh pdf

# 生成手机版 PDF
./scripts/build.sh mobile

# 全部构建（merge + pdf + mobile）
./scripts/build.sh all

# 构建 Web 版（本地）
./scripts/build.sh web
```

### 本地预览 Web 版

```bash
cd web && npx vitepress dev
# 浏览器打开 http://localhost:5173/openclaw-book-for-beginners/
```

---

## PDF 排版配置

### 文件说明

| 文件 | 用途 |
|------|------|
| `templates/pdf/metadata.yaml` | B5 标准版元数据（标题、作者、纸张尺寸等） |
| `templates/pdf/metadata-mobile.yaml` | 手机版元数据（9×16cm 纸张） |
| `templates/pdf/book-style.tex` | 标准版 LaTeX 排版样式 |
| `templates/pdf/mobile-style.tex` | 手机版 LaTeX 排版样式 |

### 本地 vs CI 字体差异

| 环境 | 中文字体 | 等宽字体 |
|------|----------|----------|
| macOS 本地 | PingFang SC（系统默认） | Menlo |
| CI (Ubuntu) | Noto Sans CJK SC | DejaVu Sans Mono |

> 如需保持本地和 CI 排版完全一致，可在本地安装 Noto Sans CJK SC 字体并修改 metadata.yaml。

---

## Web 版配置

### 关键文件

| 文件 | 用途 |
|------|------|
| `web/index.md` | 首页内容（三个入口按钮 + 作者信息） |
| `web/.vitepress/config.mts` | 站点配置（导航栏、侧边栏、SEO） |
| `web/.vitepress/theme/index.mts` | 自定义主题（PDF 下载链接修复） |
| `web/.vitepress/theme/style.css` | 自定义样式 |
| `web/package.json` | 依赖管理 |

### 图片路径规则

- **章节插图**：源文件用 `../images/XX/filename.png`，构建时自动转换为 `./images/XX/filename.png`
- **首页封面**：存放在 `web/public/images/cover/`，用 `/images/cover/book-cover.png` 引用
- **作者头像**：存放在 `web/public/images/author/`，用 `/images/author/avatar.jpg` 引用
- **PDF 下载**：存放在 `web/public/downloads/`

### 添加新章节到 Web 版

1. 在 `src/chapters/` 创建新章节 Markdown 文件
2. 在 `scripts/build.sh` 的 `CHAPTER_FILES` 数组中添加文件名
3. 在 `web/.vitepress/config.mts` 的 `sidebar` 中添加对应条目
4. push 即自动生效

---

## 故障排查

### CI 构建失败

1. 打开 [Actions 页面](https://github.com/mali9527/openclaw-book-for-beginners/actions)
2. 点击失败的 Run，查看哪一步出错
3. 常见问题：
   - **Build PDFs 失败**：检查 LaTeX 语法错误（通常是章节中有未转义的特殊字符）
   - **Build VitePress 失败**：SSR 渲染错误（已用 `|| true` 容忍，但 dist 必须生成）
   - **Sync 失败**：检查图片文件是否存在

### 本地构建失败

```bash
# 检查 Pandoc 版本
pandoc --version

# 检查 XeLaTeX
xelatex --version

# 检查 Node.js
node --version  # 需要 20+
```

---

## 版本管理建议

- 日常内容更新直接 push，CI 自动处理
- 重要版本节点（如定稿、大改版）建议打 Git Tag：`git tag v1.0 && git push --tags`
- PDF 文件不进入 Git（已在 `.gitignore` 中配置），由 CI 每次重新构建
