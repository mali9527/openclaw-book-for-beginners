# 配置大模型：把你的 API Key 放对地方

如果你在初始化向导里已经配置好了模型，那这一章你可以跳过，或者随便看看了解一下配置文件结构。

如果你初始化的时候跳过了，或者想要添加更多模型，看完这一章你就会了。

## 配置文件在哪里

OpenClaw 的核心配置文件在这里：

```
~/.openclaw/openclaw.json
```

`~` 就是你的用户目录，macOS 就是 `/Users/你的用户名/.openclaw/openclaw.json`。

这个文件其实就是一个普通的 JSON 文件，你可以用任何文本编辑器打开它编辑，VS Code 打开就很好用。

## 配置文件结构

打开配置文件，你会看到一级 Key 就这几个：

```
meta     → 元数据，不用管
wizard   → 向导运行记录，不用管
auth     → 认证配置，不用改
models   → 模型配置，我们要改这里
agents   → AI 行为配置，我们要改这里
commands → 命令执行权限控制，一般不用改
session  → 会话配置，不用改
hooks    → 钩子配置，初始化的时候选好了
gateway  → 网关网络配置，一般不用改
```

我们要改的就是两个地方：`models` 和 `agents`。

## 添加一个新模型，一步步来

我举个例子，比如我们要添加阿里云百炼的模型，跟着做：

### 第一步：在 models.providers 添加你的模型信息

找到 `models` → `providers`，在这里添加一个新的 key（名字随便起，比如 `bailian`）：

```json
"models": {
  "mode": "merge",
  "providers": {
    // ... 这里已经有你之前配置的模型了 ...
    
    // 添加这一段，改成你自己的 API Key 和模型 ID
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

解释一下各个字段：

| 字段 | 作用 |
|------|------|
| `baseUrl` | 厂商的 API 地址，去厂商文档找就能找到 |
| `api` | API 格式，OpenClaw 支持几种常见格式，比如 `anthropic-messages` / `openai-chat` / `dashscope-messages` |
| `apiKey` | 你的 API Key 填这里 |
| `models` → `id` | 模型 ID，厂商那边叫什么就填什么 |
| `models` → `name` | 给模型起个友好的名字 |
| `models` → `reasoning` | 这个模型支持推理思考过程吗？支持填 true |
| `models` → `input` | 支持什么类型的输入，一般就是 `["text"]` |
| `models` → `cost` | 价格（每百万 tokens 多少钱），OpenClaw 用来统计花费 |
| `models` → `contextWindow` | 上下文窗口多大（多少 tokens） |
| `models` → `maxTokens` | 最大输出多少 tokens |

照着这个模板填就行了，格式别错（逗号括号别漏）。

### 第二步：在 agents.defaults 配置默认模型

添加完提供者和模型，还要告诉 OpenClaw 默认用哪个模型。找到 `agents` → `defaults` → `model`：

```json
"agents": {
  "defaults": {
    "model": {
      "primary": "bailian/qwen-plus"
    },
    "models": {
      "bailian/qwen-plus": {
        "alias": "通义千问"
      }
    }
  }
}
```

`primary` 填 `提供者ID/模型ID`，就是我们刚才写的 `bailian/qwen-plus`。然后在 `models` 里加一个别名，方便你用 `/model 通义千问` 切换。

### 第三步：保存，刷新配置

改完保存文件，然后你需要重启 OpenClaw 服务，或者在 WebUI 控制面点击"更新配置"，它就会重新加载配置了。

### 第四步：测试一下

配置加载完了，去聊天框输入：

```
/model
```

它会列出你所有配置好的模型，能看到你刚加的模型就是成功了。你输入 `/model bailian/qwen-plus` 就能切换过去，然后发个消息试试，能正常回复就是好了。

## 模型回退机制是什么？怎么配置

OpenClaw 有一个很好用的功能叫**模型回退**：如果主模型调用失败了（比如配额用完了，服务挂了），自动用备用模型。

怎么配置？在 `agents.defaults.model` 加一个 `fallbacks` 字段：

```json
"model": {
  "primary": "openai/gpt-4o",
  "fallbacks": ["anthropic/claude-3-sonnet", "bailian/qwen-plus"]
}
```

这样，如果 GPT-4o 挂了，自动试试 Claude，Claude 再不行自动试试通义千问，不容易掉链子，很贴心。

## 常见问题

### Q: 我配置了模型，但是不能用，怎么办？

A: 先检查这几点：
1. JSON 格式对不对？括号逗号配对了吗？可以用 JSON 校验工具网上查一下
2. API Key 对不对？有没有多复制空格？
3. baseUrl 对不对？有没有写错？
4. 重启 OpenClaw 了吗？改完配置要重启才能生效

### Q: 我能配置多个模型吗？

A: 当然可以，你可以配置好几个，平时用这个，那个便宜用那个，聊天里输入 `/model 模型名` 就能切换，很方便。

### Q: 我用本地模型可以吗？

A: 完全可以，只要你的本地模型提供了 OpenAI 兼容的 API，照着上面的模板配置就行，`baseUrl` 填你本地的地址。

## 小结

- 核心配置文件在 `~/.openclaw/openclaw.json`
- 添加模型只需要改两个地方：`models.providers` 加模型信息，`agents.defaults` 设默认模型
- 配置完重启服务，测试一下就能用
- 可以配置多个模型，也可以配置回退机制，高可用

下一章：国内用户最关心的，怎么接入飞书。

---
