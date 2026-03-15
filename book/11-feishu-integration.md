# 接入飞书：国内用户首选，一步步来

OpenClaw 默认支持很多聊天渠道，但是国内用户推荐用飞书，因为：

- 飞书国内可以直接用，不需要科学上网
- 手机端电脑端都有客户端，用起来方便
- OpenClaw 已经内置飞支持，不用额外装插件

这一章我们一步步来，从创建应用到完成配对，保证你能看懂。

## 第一步：在飞书开发者后台创建应用

1. 打开飞书开发者后台：https://open.feishu.cn/app/，登录你的账号
2. 点击 **"创建企业自建应用"**
3. 填写应用名称：比如 `OpenClaw 助手`，上传一个头像（你喜欢就行）
4. 点击 **"创建"**

创建完了会进入开发后台，接下来我们要拿几个东西。

## 第二步：拿 App ID 和 App Secret

在左侧导航栏，点击 **"凭证与基础信息"**，你会看到：

- App ID
- App Secret

把这两个复制保存好，后面配置 OpenClaw 要用。

## 第三步：开通机器人能力

1. 左侧导航栏点击 **"添加应用能力"**
2. 找到 **"机器人"** 卡片，点击"添加"
3. 好了，这就够了

## 第四步：配置权限

机器人要能接收和发送消息，需要申请权限。左侧导航栏点击 **"权限管理"**，需要开通这些权限：

### 必须开的核心权限：

- 获取单聊、群组消息 `im:message` 或者 `im:message:readonly`
- 接收群聊消息 `im.message.receive_v1`
- 接收单聊消息 `im.message.receive_v1`
- 以应用的身份发消息 `im:message:send_as_bot`

### 如果你后续需要读写飞书文档/表格，还要开这些：

- 读取文档 `drive:file:read`
- 写入文档 `drive:file:write`
- 读取表格 `sheets:spreadsheet`

你可以现在一次性开好，也可以后面用到再开。

### 批量导入权限（更快）

如果你觉得一个个点太慢，可以点击"导入权限"，把下面这个 JSON 复制进去：

```json
{
  "scopes": {
    "tenant": [
      "aily:file:read",
      "aily:file:write",
      "application:application.app_message_stats.overview:readonly",
      "application:application:self_manage",
      "bot:menu:write",
      "cardkit:card:write",
      "contact:user.employee_id:readonly",
      "corehr:file:download",
      "docs:document.content:read",
      "event:ip_list",
      "im:chat",
      "im:chat.access_event.bot_p2p_chat:read",
      "im:chat.members:bot_access",
      "im:message",
      "im:message.group_at_msg:readonly",
      "im:message.group_msg",
      "im:message.p2p_msg:readonly",
      "im:message:readonly",
      "im:message:send_as_bot",
      "im:resource",
      "sheets:spreadsheet",
      "wiki:wiki:readonly"
    ],
    "user": [
      "aily:file:read",
      "aily:file:write",
      "im:chat.access_event.bot_p2p_chat:read"
    ]
  }
}
```

复制完点击"申请开通"就好了，等待管理员审批（如果你是个人帐号，自己就是管理员，直接通过）。

## 第五步：第一次发布应用

配置完权限，必须先发布应用，不然没法配置事件订阅。

1. 点击顶部 **"版本管理与发布"** → "创建版本"
2. 填写版本号，比如 `1.0.0`，更新说明随便写
3. 点击"确认发布"
4. 等状态变成"已发布"就可以下一步了

## 第六步：配置事件订阅

这一步很重要，不配置收不到消息。

1. 左侧导航栏点击 **"事件与回调"**
2. 订阅方式选择 **"使用长连接接收事件"**（WebSocket 模式），这个适合本地部署，不需要公网 IP，推荐！
3. 点击"添加事件"，搜索勾选 **接收消息 (im.message.receive_v1)**
4. 点击确定保存
5. 同样，在"机器人回调配置"那里也选长连接

然后重新发布一次应用（版本更新一下就行）。

## 第七步：在 OpenClaw 配置飞书

现在我们回到 OpenClaw，修改配置文件 `~/.openclaw/openclaw.json`，找到 `channels`，添加飞书配置：

```json
"channels": {
  "feishu": {
    "enabled": true,
    "domain": "feishu",
    "dmPolicy": "pairing",
    "mediaMaxMb": 30,
    "accounts": {
      "main": {
        "appId": "替换成你的 App ID",
        "appSecret": "替换成你的 App Secret",
        "botName": "OpenClaw 助手"
      }
    }
  }
}
```

把 `appId` 和 `appSecret` 替换成你刚才从飞书开发者后台拿到的，`botName` 改成你想要的机器人名字。

改完保存，重启 OpenClaw 服务。

## 第八步：配对就能用了

配置完了，打开飞书，找到你的机器人，发一条消息给它。

它会回复你一个配对码，类似这样：

```
请在终端执行这个命令完成配对:
openclaw pairing approve feishu 123456
```

你打开终端，把这个命令复制进去运行，就完成配对了。

然后你再发消息，机器人就能正常回复了！🎉

## 常见问题

### Q: 我发消息机器人没回复怎么办？

A: 检查这几点：
1. 应用发布了吗？没发布收不到事件
2. 事件订阅勾选了接收消息吗？
3. 权限申请了吗？能发消息吗？
4. 配对完成了吗？第一次需要配对

### Q: 我需要公网 IP 吗？

A: 不需要！因为我们用了**长连接模式**，OpenClaw 主动连接飞书服务器，所以不需要公网 IP，本地电脑就能用，太方便了。

### Q: 群聊能用吗？

A: 可以，你把机器人拉进群，然后在群里@它就能用了。在默认 `pairing` 模式下，只有配对过的用户能和它说话，安全。

## 小结

一步步下来，你现在已经能在飞书里和 OpenClaw 聊天了：

1. 飞书开发者后台创建应用 → 拿 App ID/App Secret
2. 开机器人能力 → 申请权限 → 发布
3. 事件订阅选长连接 → 添加接收消息事件
4. OpenClaw 配置文件加飞书配置 → 重启
5. 飞书发消息 → 终端配对 → 就能用了

下一章：设定 AI 性格，四个文件搞定专属人设。

---
