# 配置大模型：把你的 API Key 放对地方

如果你刚才初始化的时候已经配置好模型了，那这一章你可以跳过，直接看下一章就行了。如果你没配置，或者想再加个模型，看完这一章你就会了。

## 配置文件在哪里，你先找到它

OpenClaw 的核心配置文件就在这里：

```
~/.openclaw/openclaw.json
```

`~` 就是你的用户目录， macOS 就是 `/Users/你的用户名/.openclaw/openclaw.json`。这个文件就是一个普通的 JSON 文件，你用 VS Code 或者任何文本编辑器都能打开编辑，很方便。

## 这个配置文件里到底有什么

你打开一看，里面一级菜单就这几个，我给你说哪个我们需要改：

```
meta     → 元数据，不用管它
wizard   → 向导运行记录，不用管它
auth     → 认证配置，不用改
models   → 模型配置，**我们就要改这里**
agents   → AI 行为配置，**我们也要改这里**
commands → 命令权限控制，一般不用改
session  → 会话配置，不用管
hooks    → 钩子，你初始化的时候选好了
gateway  → 网关网络配置，一般不用改
```

所以我们改就是改两个地方：`models` 和 `agents`，就这么简单。

## 添加一个新模型，我一步步带你做

我给你举个实际例子，比如我们添加阿里云百炼的通义千问，你照着做就行：

### 第一步：在 `models.providers` 添加你的模型信息

找到 `models` → `providers`，在这里加一块就行了，我给你模板：

```json
"models": {
  "mode": "merge",
  "providers": {
    // ... 这里已经有你之前配置的模型了，不用动 ...
    
    // 👈 你把这块加进去，改成你自己的 API Key
    "bailian": {
      "baseUrl": "https://dashscope.aliyun.com/completion",
      "api": "dashscope-messages",
      "apiKey": "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "models": [
        {
          "id": "qwen-plus",
          "name": "通义千问 Plus",
          "reasoning": true,
          "input": ["text"],
          "cost": {
            "input": 0.08,
              "output": 0.2,
              "cacheRead": 0.01,
              "cacheWrite": 0.02
          },
          "contextWindow": 128000,
          "maxTokens": 4096
        }
      ]
    }
  }
}
```

我给你说每个字段是干嘛的，你照着填就行：

| 字段 | 干什么 |
|------|----------|
| `baseUrl` | 厂商给你的 API 地址，去它文档找就能找到 |
| `api` | API 格式，OpenClaw 支持几种常用的，比如 `anthropic-messages` / `openai-chat` / `dashscope-messages` |
| `apiKey` | 你的 API Key 填这里 |
| `models` → `id` | 模型 ID，厂商叫它什么你就填什么 |
| `models` → `name` | 给它起个好记的名字 |
| `models` → `reasoning` | 这个模型支持推理思考吗？支持就填 true |
| `models` → `input` | 支持什么类型的输入，一般就是 `["text"]` |
| `models` → `cost` | 价格，每百万 tokens 多少钱，OpenClaw 用来统计你花了多少钱 |
| `models` → `contextWindow` | 它上下文窗口多大，多少 tokens |
| `models` → `maxTokens`  | 最大输出多少 tokens |

照着模板填，注意一下**括号逗号别漏了**，JSON 格式错了就加载失败，你填完可以去网上找个"JSON 校验"工具检查一下，没问题再保存。

### 第二步：在 `agents.defaults` 配置默认模型

加好模型信息了，你还要告诉 OpenClav **默认用哪个模型**。找到 `agents` → `defaults` → `model`，改成这样：

```json
"agents": {
  "defaults": {
    "model": {
      "primary": "bailian/qwen-plus",
      "fallbacks": ["anthropic/claude-3-sonnet"]
    },
    "models": {
      "bailian/qwen-plus": {
        "alias": "通义千问"
      }
    }
  }
}
```

`primary` 就是 `你的提供者ID/模型ID`，我们刚才就是 `bailian/qwen-plus`，填上。然后在 `models` 里给它起个别名，以后你用 `/model 通义千问` 就能切换，很方便。

那个 `fallbacks` 是干嘛的？就是**模型回退**——如果主模型调用失败了（比如配额用完了，服务挂了），自动用备用模型，不容易掉链子，你可以加上。

### 第三步：保存，刷新配置

改完保存文件，你需要重启一下 OpenClaw 服务，或者在 WebUI 控制面板点一下"更新配置"，它就会重新加载配置了。

### 第四步：测试一下能不能用

配置加载完了，你打开聊天框输入：

```
/model
```

它就会给你列出所有配置好的模型，能看到你刚加的模型就是成功了。你输入 `/model 你的模型别名` 就能切过去，发个消息试试，能正常回复就是好了。

## 常见问题，你碰到了可以看看

### Q: 我配置完了，模型不能用，怎么回事？

A: 你按这个顺序检查：
1. JSON 格式对不对？是不是漏了逗号括号？你复制到网上JSON校验工具看一下，很容易找到错
2. API Key 对不对？是不是多复制了空格少复制了字母？
3. baseUrl 对不对？是不是写错了？
4. 你重启 OpenClaw 了吗？改完配置一定要重启才会生效

### Q: 我能配置多个模型吗？

A: 当然可以呀！你想配置几个就配置几个，平时用这个，那个便宜用那个，聊天里输入 `/model 模型名` 就能切，特别方便。

### Q: 我用本地模型可以吗？

A: 完全没问题！只要你的本地模型提供了 OpenAI 兼容的 API，你照着上面这个模板配置就行，`baseUrl` 填你本地的地址就好了。

## 小结

其实配置模型真的很简单：

- 核心配置文件就是 `~/.openclaw/openclaw.json`
- 加模型就是改两处：`models.providers` 加信息，`agents.defaults` 设默认
- 保存重启，测试一下就能用了
- 支持配置多个模型，还支持失败自动回退

好了，配置完了，下一章我们说最重要的——国内用户怎么接入飞书，一步步来。

---
