# 接入飞书：国内用户首选，一步步来

OpenClaw 默认支持好多聊天渠道，我推荐国内用户用飞书，原因很简单：

- 飞书国内能直接用，不需要科学上网
- 手机电脑都有客户端，你平时用什么聊天就在哪里用，不用换APP
- OpenClaw 原生支持，不需要你额外装插件
- **最新版本 v2026.3.7 对飞书集成做了优化**，长连接更稳定，用起来更顺

这一章我带你一步步来，从创建应用到最后能用，保证你跟着走就能成。

## 第一步：飞书开发者后台创建应用

1. 打开飞书开发者后台：https://open.feishu.cn/app，登录你的账号
2. 点击 **"创建企业自建应用"**
3. 填一下应用名字，比如就叫 `OpenClaw 助手`，传一个你喜欢的头像
4. 点击 **"创建"** 就好了

创建完你就进入开发后台了，接下来我们拿几个关键信息。

## 第二步：复制 App ID 和 App Secret

左边菜单栏点击 **"凭证与基础信息"**，你就能看到：

- App ID
- App Secret

把这两个复制出来存好，后面配置 OpenClaw 要用。

## 第三步：开机器人能力

左边菜单栏点击 **"添加应用能力"**，找到 **"机器人"** 卡片，点添加就好了，搞定。

## 第四步：给机器人开权限

机器人要能收发消息，必须开权限。左边点击 **"权限管理"**，把这些权限开了：

### 必须开的核心权限：

- 获取单聊、群聊消息 ⇒ `im:message` 或者 `im:message:readonly`
- 接收群聊消息 ⇒ `im.message.receive_v1`
- 接收单聊消息 ⇒ `im.message.receive_v1`
- 以应用身份发消息 ⇒ `im:message:send_as_bot`

### 如果你以后要读写飞书文档/表格，顺便开了这些：

- 读文档 ⇒ `drive:file:read`
- 写文档 ⇒ `drive:file:write`
- 读表格 ⇒ `sheets:spreadsheet`

你要是现在不确定，直接把我给你这个 JSON 复制进去导入就行，一次性开好：

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

弄好了点**申请开通**，个人账号你自己就是管理员，直接通过。

## 第五步：发布应用，这步必须做

配好权限一定要发布，不发布没法配置事件订阅。

1. 点击顶部菜单栏 **"版本管理与发布"** → "创建版本"
2. 填个版本号，比如 `1.0.0`，说明随便写
3. 点确认发布，等状态变成**已发布**就好了

## 第六步：配置事件订阅，这步很重要

不配置这步，你发消息机器人收不到，一定要做。

1. 左边菜单栏点击 **"事件与回调"**
2. 订阅方式选择 **"使用长连接接收事件"** ✅ 一定要选这个
   - 好处就是**不需要你有公网 IP**，本地电脑就能用，太方便了，推荐所有人用这个
3. 点击"添加事件"，勾选 **接收消息 (im.message.receive_v1)**
4. 机器人回调也选长连接
5. 点保存，然后**重新发布一次**版本，让配置生效

## 第七步：回到 OpenClaw 配置飞书

现在我们改 OpenClaw 的配置文件，就是 `~/.openclaw/openclaw.json`，找到 `channels`，加上飞书配置：

```json
"channels": {
  "feishu": {
    "enabled": true,
    "domain": "feishu",
    "dmPolicy": "pairing",
    "mediaMaxMb": 30,
    "accounts": {
      "main": {
        "appId": "把这里替换成你的 App ID",
        "appSecret": "把这里替换成你的 App Secret",
        "botName": "OpenClaw 助手"
      }
    }
  }
}
```

把里面的 `appId` 和 `appSecret` 换成你刚才复制的，保存，然后**重启 OpenClav** 服务。

## 第八步：配对完成就能用了

配置重启完，你打开飞书找到你的机器人，发一条消息，它会回复你一个配对码，像是这样：

```
请在终端执行这条命令完成配对：
openclaw pairing approve feishu 123456
```

你复制到终端运行一下，就配对完成了。再发消息，机器人就能正常回复你了🎉

## 常见问题

### Q: 我发消息机器人没反应，哪里错了？
A: 你对照检查一下：
1. 你发布版本了吗？没发布收不到
2. 你加事件订阅了吗？没加收不到
3. 你改完配置重启 OpenClaw 了吗？
4. 你配对了吗？第一次必须配对

### Q: 需要公网 IP 吗？
A: **不需要**！我们用了长连接，是 OpenClaw 主动连飞书服务器，所以你在家用电脑就能跑，不用公网 IP。

### Q: 群聊能用吗？
A: 当然可以，你把机器人拉进群，说话的时候@它就好了。默认配对模式下，只有配对过的用户才能和它说话，安全。

## 小结

按照这个流程走，现在你已经能在飞书里用 OpenClav 了，最新版本优化了长连接，稳定性比以前更好了。

下一章：设定 AI 性格，四个文件搞定你的专属人设。

---
