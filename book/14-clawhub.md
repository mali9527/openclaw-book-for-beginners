# ClawHub 技能商店：怎么找、怎么装、怎么选

ClawHub 是 OpenClaw 官方的技能市场，就像手机上的应用商店，你需要什么功能搜一下，装了就能用。这一章教你怎么用。

## 第一步：安装 clawhub 命令行工具

如果你已经装过了，可以跳过这一步。如果没装，一条命令就能装上：

```bash
npm install -g clawhub
```

安装完验证一下：

```bash
clawhub --version
```

能输出版本号就是装好了。

## 搜索技能：怎么找到我想要的技能

搜索很简单：

```bash
find-skills 搜索关键词
```

其实 `find-skills` 就是包装了 `clawhub search`，所以这个命令等价于：

```bash
clawhub search 搜索关键词
```

比如你想要搜索 PDF 相关的技能：

```bash
find-skills pdf
```

它会给你列出所有匹配的技能，还有评分，评分越高越推荐。

## 安装技能：一条命令搞定

搜到了你想要的技能，记下它的 slug（就是技能名字），然后：

```bash
find-skills install 技能slug
```

比如我们安装 `tavily-search`：

```bash
find-skills install tavily-search
```

它会自动下载安装到你当前工作区的 `skills/` 目录下面，然后就能用了。

> 小知识：技能搜索路径优先级：`当前项目skills/` → `~/.openclaw/skills/` → 内置技能，所以你可以给不同项目装不同技能，很灵活。

## 怎么选技能？看评分

ClawHub 上的技能有社区评分，一般选**评分最高**的那个就错不了。

评分是根据社区使用评价算出来的，评分高说明大家用着都觉得好。

如果同一个功能有多个技能，选评分最高的，准没错。

## 安装完了怎么用？

一般技能装好之后，SKILL.md 会告诉你怎么用，需要配置什么环境变量（比如 API Key）。

大部分技能需要配置 API Key，一般步骤是：

1. 去对应的网站注册账号，拿 API Key
2. 在 OpenClaw 配置里加环境变量，或者放到 `.env` 文件里
3. 重启 OpenClaw 服务
4. 就能用了

技能的 SKILL.md 都会写清楚，跟着做就行。

## 我需要的技能找不到怎么办？

如果 ClawHub 上没有你想要的技能，可以：

1. 自己写一个，很简单，按照技能模板写就行
2. 去 GitHub 搜一搜，说不定有人已经写了
3. 让 OpenClaw 帮你写，它自己就能写技能

普通人一般不需要自己写，常用功能都有了。

## 常见问题

### Q: 安装失败了怎么办？

A: 一般是网络问题或者 ClawHub 速率限制，等一会儿再试一次就好了。

### Q: 怎么卸载技能？

A: 直接删掉 `skills/` 下面对应的技能文件夹就行了，没有复杂的命令。

### Q: 技能会更新吗？怎么更新？

A: 当然会更新，重新运行 `find-skills install 技能slug` 就能更新到最新版本。

## 小结

- ClawHub 就是 OpenClaw 的应用商店
- `find-skills 关键词` 搜索技能
- `find-skills install 技能名` 安装技能
- 选评分最高的一般不会错
- 装完跟着技能的 SKILL.md 配置就能用

下一章：我给你推荐 10 个普通人真正用得上的实用技能。

---
