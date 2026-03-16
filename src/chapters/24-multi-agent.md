# 小团队协作：多 Agent 实战

到目前为止，我们一直在讲一个 AI 助手帮你做事。但是如果你有多件不同类型的事情要处理呢？比如一边要写内容，一边要分析数据，一边还要监控安全——一个 AI 忙得过来吗？

这就是**多 Agent**（多智能体）的用武之地：让几个 AI 各自专精一个领域，分工协作。

---

## 什么是多 Agent？用大白话说

一句话：**多个 AI 助手组成一个团队，各司其职**。

就像公司里的不同部门：

- **内容助手**专门负责写文章、做调研
- **数据助手**专门负责查数据、出报告

每个助手有自己的性格设定（SOUL.md）、自己的技能配置、自己的记忆——互不干扰，但可以协作。

> 💡 **为什么要多个 Agent，一个不行吗？** 一个当然也行，大部分人用一个就够了。但如果你发现你的一个 Agent"什么都做"，结果"什么都做得不够精"，就可以考虑分一下工。就像一个人既当客服又当会计又当写手，肯定不如三个专人分别做。

---

## 手把手教你搭两个 Agent

下面我用一个实际例子，教你一步一步搭出两个 Agent：一个专门写内容，一个专门分析数据。你照着做就行。

### 第 1 步：创建 Agent 文件夹

打开终端，输入以下命令：

```bash
mkdir -p ~/openclaw-agents/content-agent
mkdir -p ~/openclaw-agents/data-agent
```

> 💻 **Windows 用户：** 打开 PowerShell，输入：
> ```powershell
> New-Item -ItemType Directory -Force -Path "$HOME\openclaw-agents\content-agent"
> New-Item -ItemType Directory -Force -Path "$HOME\openclaw-agents\data-agent"
> ```

> 💡 **这两行命令在干什么？** 在你的用户目录下创建了一个 `openclaw-agents` 文件夹，里面有两个子文件夹，分别给"内容助手"和"数据助手"用。

执行完后，你可以验证一下是否成功：

```bash
ls ~/openclaw-agents/
```

> 💻 **Windows 用户：** `dir "$HOME\openclaw-agents\"`

你应该看到两个文件夹名：`content-agent` 和 `data-agent`。

---

### 第 2 步：给内容助手写性格设定

用 VS Code 或 Cursor 创建一个新文件：

**文件路径：**
- macOS / Linux：`~/openclaw-agents/content-agent/SOUL.md`
- Windows：`%USERPROFILE%\openclaw-agents\content-agent\SOUL.md`

在终端里可以直接这样创建和编辑：

```bash
code ~/openclaw-agents/content-agent/SOUL.md
```

> 💻 **Windows 用户：** `code "$HOME\openclaw-agents\content-agent\SOUL.md"`

> 💡 **`code` 命令打不开？** macOS 用户用 Finder 打开文件夹，右键新建文件；Windows 用户用文件资源管理器打开文件夹，右键 → 新建文本文档 → 命名为 `SOUL.md`，然后用 VS Code 打开编辑。

把下面这段内容**复制粘贴**进去，保存：

```markdown
# 内容编辑助手

## 你是谁
你是一个资深的内容编辑，帮我做以下事情：
- 选题分析和热点追踪
- 文章写作和多平台改编（小红书、公众号、抖音）
- 标题优化

## 你的风格
- 语气专业但有趣，像一个资深总编辑
- 写出来的东西要口语化，不要太正式
- 每次写完先给我看草稿，我确认了再定稿

## 你不要做的事
- 不要查数据库——那是另一个助手的工作
- 不要编造数据和引用
```

---

### 第 3 步：给数据助手写性格设定

**文件路径：**
- macOS / Linux：`~/openclaw-agents/data-agent/SOUL.md`
- Windows：`%USERPROFILE%\openclaw-agents\data-agent\SOUL.md`

```bash
code ~/openclaw-agents/data-agent/SOUL.md
```

> 💻 **Windows 用户：** `code "$HOME\openclaw-agents\data-agent\SOUL.md"`

把下面这段内容**复制粘贴**进去，保存：

```markdown
# 数据分析助手

## 你是谁
你是一个数据分析专家，帮我做以下事情：
- 从 Excel 或 CSV 文件分析数据
- 生成数据报表和可视化图表
- 发现异常数据和趋势

## 你的风格
- 严谨准确，善于用数据说话
- 先给结论，再展开细节
- 如果数据不够或者有歧义，先问清楚再分析

## 你不要做的事
- 不要帮我写文章——那是另一个助手的工作
- 不要猜测数据含义，不确定就问我
```

---

### 第 4 步：给每个助手安装不同的技能

内容助手需要搜索和写作相关的技能，数据助手需要数据处理的技能。

**给内容助手装技能** —— 在终端输入：

```bash
mkdir -p ~/openclaw-agents/content-agent/skills
cd ~/openclaw-agents/content-agent
clawhub install tavily-search
clawhub install summarize
clawhub install spell-check-cn
```

> 💻 **Windows 用户：** 打开 PowerShell，输入：
> ```powershell
> New-Item -ItemType Directory -Force -Path "$HOME\openclaw-agents\content-agent\skills"
> cd "$HOME\openclaw-agents\content-agent"
> clawhub install tavily-search
> clawhub install summarize
> clawhub install spell-check-cn
> ```

**给数据助手装技能** —— 在终端输入：

```bash
mkdir -p ~/openclaw-agents/data-agent/skills
cd ~/openclaw-agents/data-agent
clawhub install duckdb
clawhub install data-analyst
```

> 💻 **Windows 用户：** 打开 PowerShell，输入：
> ```powershell
> New-Item -ItemType Directory -Force -Path "$HOME\openclaw-agents\data-agent\skills"
> cd "$HOME\openclaw-agents\data-agent"
> clawhub install duckdb
> clawhub install data-analyst
> ```

> 💡 **为什么要分开装？** 这样内容助手不会误触数据分析工具，数据助手也不会把精力浪费在搜索上。各干各的，更专业更高效。

---

### 第 5 步：启动不同的 Agent

OpenClaw 支持通过指定工作目录来启动不同的 Agent：

**启动内容助手：**

```bash
openclaw start --workspace ~/openclaw-agents/content-agent
```

> 💻 **Windows 用户：** `openclaw start --workspace "$HOME\openclaw-agents\content-agent"`

**启动数据助手：**

```bash
openclaw start --workspace ~/openclaw-agents/data-agent
```

> 💻 **Windows 用户：** `openclaw start --workspace "$HOME\openclaw-agents\data-agent"`

每个 Agent 会跑在不同的端口上，你可以同时打开两个浏览器标签页，分别和它们聊天。

> 💡 **嫌麻烦？** 刚开始你可以不同时启动。先用内容助手写完文章，关掉它，再启动数据助手分析数据。不需要同时跑，按需切换就行。

---

### 第 6 步：让两个 Agent 协作（进阶）

两个 Agent 可以通过**共享文件**来接力——一个的输出就是另一个的输入。

**举个例子：数据助手出数据 → 内容助手写报告**

**操作步骤：**

1. 先打开**数据助手**，对它说：

> "帮我分析桌面上的 sales_data.xlsx，把分析结果保存到 ~/openclaw-agents/shared/weekly_data.md"

2. 数据助手会把分析结果写成一个 Markdown 文件。

3. 创建共享文件夹（如果还没有的话）：

```bash
mkdir -p ~/openclaw-agents/shared
```

4. 然后切换到**内容助手**，对它说：

> "读一下 ~/openclaw-agents/shared/weekly_data.md 这个文件，根据里面的数据分析，帮我写一份给老板看的周报，语气专业简洁"

内容助手读完数据助手的分析，写出格式规范的周报。

**就这么简单——文件就是它们协作的"桥梁"。**

---

### 第 7 步：设置定时自动协作（可选）

如果你想让这个协作流程**每周自动跑**，可以在配置文件里加一个定时任务：

打开 `~/.openclaw/openclaw.json`，在定时任务部分加上：

```json
"data-to-report": {
  "schedule": "0 8 * * 1",
  "prompt": "先以 data-agent 的身份查询上周运营数据，把结果保存到 ~/openclaw-agents/shared/weekly_data.md。然后以 content-agent 的身份读取这份数据，写成一份给老板看的周报。"
}
```

> 💡 `"0 8 * * 1"` 的意思是"每周一早上 8 点"。这样每周一你到公司的时候，周报已经自动准备好了。

---

## 社区真实案例

### 案例一："商业顾问委员会"

有一位创业者在社区分享了他的玩法：他搭了 4 个 AI Agent，组成了一个"虚拟顾问委员会"：

- **财务顾问 Agent**：分析财务数据、做预算预测
- **营销顾问 Agent**：分析竞品、建议推广策略
- **法务顾问 Agent**：审查合同条款、标注法律风险
- **产品顾问 Agent**：分析用户反馈、建议产品方向

他每周给这四个 Agent 一人一套数据，然后让它们分别出一份分析报告。最后他把四份报告综合起来做决策。

你想模仿的话，照着上面的步骤来：创建 4 个文件夹 → 每个写一份 SOUL.md → 装不同技能 → 分别启动。

> 💡 **我的点评**：AI 不能替你做决策，但可以从不同角度帮你分析。就像真的请了四个顾问——而且不收顾问费。

### 案例二："夜间安全巡检"

有一位运维工程师设置了一个"夜间安全巡检 Agent"，每天凌晨 3 点自动跑：

1. 检查服务器是否有异常流量
2. 扫描日志中的安全警告
3. 检查 SSL 证书是否快过期
4. 如果发现问题 → 自动发飞书消息通知他

早上到了公司，所有安全问题已经整理好了等他看。

### 案例三："家庭管家 Agent"

一位社区用户给全家人搭了一个家庭管家 Agent：

- 每天早上给全家人发简报：爸爸的会议日程、妈妈的待办、孩子今天什么课
- 家庭备忘录：谁的快递到了、谁的生日快到了、冰箱什么需要买了

---

## ⚠️ 注意事项

1. **先用好一个 Agent，再考虑多 Agent**：很多人一上来就想搞一堆 Agent，结果一个都没用好。建议你至少把一个 Agent 用了两周以上，再考虑加第二个
2. **Agent 不是越多越好**：每多一个 Agent 就多一份维护成本。3-5 个是大多数人的甜蜜点
3. **安全隔离**：不同 Agent 的权限应该有区别。比如"数据 Agent"可以读数据库，但"内容 Agent"不该有这个权限

---

## 小结

| 步骤 | 做什么 | 难度 |
|------|--------|------|
| 1. 创建文件夹 | `mkdir -p ~/openclaw-agents/xxx` | ⭐ |
| 2. 写 SOUL.md | 复制模板，改改就行 | ⭐ |
| 3. 装技能 | `clawhub install xxx` | ⭐ |
| 4. 启动 Agent | `openclaw start --workspace xxx` | ⭐ |
| 5. 协作 | 通过共享文件接力 | ⭐⭐ |
| 6. 定时自动 | 配置 CronJob | ⭐⭐ |

**核心原则：先用好一个，按需拆分，文件就是协作桥梁。**

---
