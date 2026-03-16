# 办公效率技能：邮件、日历、文档、数据库

上一章讲了核心三件套，这一章我们来看**办公场景**——每天都在用的邮件、日历、文档、表格，怎么用 OpenClaw 自动化。

> 💻 **Windows 用户注意：** 这一章所有的 `clawhub install` 命令在 PowerShell 里都能直接用。配置文件路径 `~/.openclaw/` 对应 Windows 的 `%USERPROFILE%\.openclaw\`。

---

## 1. GOG —— Google 全家桶一键管理

如果你用 Gmail、Google 日历、Google Drive、Google Docs，装这一个就够了。

### 安装与配置

```bash
clawhub install gog
```

配置需要用 Google OAuth 授权（就是让 OpenClaw 有权限读写你的 Google 账号）：

1. 打开 [console.cloud.google.com](https://console.cloud.google.com)
2. 创建一个项目（免费的）
3. 启用 Gmail API、Calendar API、Drive API
4. 生成 OAuth 凭证，下载 `credentials.json`
5. 放到 `~/.openclaw/` 目录下

> ⚠️ **老实说，这个配置对普通人来说挺复杂的。** Google Cloud Console 全英文，界面很专业。如果你第一次接触，可能要花半小时折腾。**如果你暂时不用 Google 全家桶，完全可以先跳过这个技能**，用下面的 `email-management`（支持 QQ 邮箱、163 邮箱、Outlook）代替，配置简单 10 倍。
>
> 💡 **想挑战一下？** 直接对 OpenClaw 说"帮我查一下 GOG 技能的详细配置教程"，它会给你一步步的指导。

### 实战案例

> "帮我看看今天有什么新邮件，重要的标出来"
> 
> "帮我在下周三下午两点安排一个会议，标题是'产品评审'"
> 
> "帮我在 Google Drive 里找上周的周报"

---

## 2. email-management —— 邮件自动管理

不用 Gmail 的朋友，用这个。支持 Outlook、QQ 邮箱、163 邮箱等通过 IMAP 连接的邮箱。

### 安装与配置

```bash
clawhub install email-management
```

你需要在配置文件里填上你的邮箱 IMAP 信息：

```json
{
  "EMAIL_IMAP_HOST": "imap.qq.com",
  "EMAIL_IMAP_PORT": "993",
  "EMAIL_USERNAME": "你的邮箱地址",
  "EMAIL_PASSWORD": "你的授权码（不是登录密码）"
}
```

> 💡 **不知道加在配置文件哪里？** 直接对 AI 说："帮我配置 email-management 技能，我的邮箱是 xxx@qq.com，授权码是 xxx"，AI 会帮你把信息填到正确的位置，不用你自己改 JSON 文件。

> 💡 **什么是 IMAP？什么是授权码？** IMAP 就是"允许其他程序读取你邮箱"的一个功能。授权码是邮箱专门给第三方应用用的密码，和你的登录密码不一样，这样更安全。拿授权码的方法：打开你的邮箱设置 → 找"POP3/IMAP/SMTP" → 开启 IMAP → 生成授权码。QQ 邮箱、163 邮箱、Outlook 都支持，步骤大同小异。

### 实战案例

> "帮我看看今天邮箱有什么重要邮件"
>
> "那封张三发的邮件，帮我回复一下，就说下周可以"
> 
> "这周的垃圾邮件帮我退订了"

### 常见坑

- **连不上邮箱？** 90% 是因为授权码填错了（不是登录密码）
- **某些企业邮箱连不上？** 可能是公司 IT 关了 IMAP。问一下你们 IT 部门

---

## 3. weather —— 天气查询

做晨间简报的标配。免费不用 API Key，装上就能用。

### 安装

```bash
clawhub install weather
```

不需要配置，装完直接用。

### 实战案例

> "明天上海天气怎么样？需要带伞吗？"
>
> "帮我看看下周要去出差的那个城市一周天气"
>
> "这周末适合户外活动吗？"

---

## 4. notion —— Notion 笔记与任务管理

如果你用 Notion 记笔记、管理任务，装这个让 AI 直接操作 Notion。

### 安装与配置

```bash
clawhub install notion
```

需要生成 Notion Integration Token：
1. 打开 [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. 点击 "New integration"（新建集成），给它起个名字（比如"OpenClaw"）
3. 创建后你会看到一串以 `secret_` 开头的长字符串——复制它
4. 在你的 Notion 页面里，把这个 Integration "连接"进来：右上角三个点 → "连接" → 选你刚创建的

> 💡 **怎么把 Token 填到配置里？** 直接对 AI 说："帮我配置 Notion 技能，Token 是 secret_xxxx"，它会自动加进配置文件。

如果你想手动加，把下面这段加到 `~/.openclaw/openclaw.json` 里：

```json
{
  "NOTION_TOKEN": "secret_xxxxxxxx"
}
```

### 实战案例

> "帮我在 Notion 的待办列表里加一条：周五之前写完报告"
>
> "看看我 Notion 里这周还有哪些任务没完成"
> 
> "把今天搜到的这篇好文章存到我的 Notion 知识库里"

---

## 5. nano-pdf —— PDF 轻量编辑

不用打开 Adobe 那种大软件，告诉 AI 你要改什么，它帮你改。

### 安装

```bash
clawhub install nano-pdf
```

### 实战案例

> "帮我把这两份 PDF 合并成一份"
> 
> "帮我把这份 PDF 的前五页提取出来"
> 
> "把这份 PDF 转成 Word 格式"

---

## 6. database-query — 数据库查询（运营/财务刚需）🆕

> 💡 **这个技能适合谁？** 如果你在公司做运营、财务、数据分析，工作中需要从公司数据库里查数据，这个技能就太好用了。如果你不知道"数据库"是什么，那说明你目前用不上它，跳过就好。

这个技能让你用**自然语言查数据库**——不用写 SQL，告诉 AI 你想查什么，它帮你写查询、帮你跑、帮你出结果。

> 💡 **SQL 是什么？** SQL 是一种专门用来查数据库的语言。以前你想从数据库里查数据，必须先学会 SQL。有了这个技能，你只要说"帮我查上个月销售额最高的 10 个产品"，AI 会帮你把这句话翻译成 SQL，然后执行，最后把结果给你看。

### 安装与配置

```bash
clawhub install database-query
```

ClawHub 安装量超过 9.5 万——简直是运营和财务人员的救命工具。

你需要配置数据库连接信息：

```json
{
  "DB_TYPE": "mysql",
  "DB_HOST": "你的数据库地址",
  "DB_PORT": "3306",
  "DB_USER": "用户名",
  "DB_PASSWORD": "密码",
  "DB_NAME": "数据库名"
}
```

> ⚠️ **安全提示**：database-query 技能默认只有"读"权限（只能查数据不能改数据）。但还是建议你**用只读账号**连接数据库，这样更安全。

### 实战案例

> "帮我查一下上个月销售额最高的 10 个产品"
> 
> "今年每个月的新增用户数是多少？帮我画个趋势"
> 
> "把上季度的退货数据导出成 Excel 给我"

### 常见坑

- **连不上数据库？** 检查你的数据库是否允许远程连接
- **查询太慢？** 限制查询范围，比如加上时间范围
- **数据量太大？** 让 AI 先"数一下有多少条"，再决定怎么查

---

## Combo 组合技：办公自动化流水线

### 每日工作启动仪式

设置一个每天早上的定时任务，把以上技能串起来：

```json
"work-start": {
  "schedule": "0 9 * * 1-5",
  "prompt": "现在是工作日早上，请帮我做以下事情：1）查看今天天气 2）查看我的日程安排 3）查看邮箱重要邮件 4）查看 Notion 里今天的待办。整理成一份简报发给我。"
}
```

> 💡 `"0 9 * * 1-5"` 的意思是"工作日（周一到周五）每天早上 9 点"。

---

## 小结

| 技能 | 一句话 | 是否需要 API Key |
|------|--------|:---:|
| GOG | Google 全家桶管理 | 需要 OAuth |
| email-management | 邮件分类+回复 | 需要 IMAP 授权码 |
| weather | 天气查询 | 不需要 ✅ |
| notion | Notion 读写 | 需要 Token |
| nano-pdf | PDF 编辑 | 不需要 ✅ |
| database-query | 自然语言查数据库 | 需要数据库账号 |

下一章我们看看内容创作和数据分析相关的技能——DuckDB、数据分析师助手，这些是把 AI 变成你的"数据军师"的关键。

---
