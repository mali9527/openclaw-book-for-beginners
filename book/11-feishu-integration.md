# 接入飞书：国内用户首选，一步步来

OpenClaw 默认支持好多聊天渠道，但是我推荐国内用户用飞书，原因很简单：

- 飞书国内可以直接用，不需要科学上网
- 手机电脑都有客户端，你日常用起来方便
- OpenClav 原生就支持，不需要你额外装插件

这一章我带你一步步来，从创建应用到最后能用，保证你跟着走就能成。

## 第一步：飞书开发者后台创建应用

你跟着点就行了：

1. 打开飞书开发者后台：https://open.feishu.cn/app/，登录你的账号
2. 点击 **"创建企业自建应用"**
3. 填一下应用名称，比如就叫 `OpenClaw 助手`，上传一个头像（你喜欢就行）
4. 点击 **"创建"** 就好了

创建完了你就进入开发后台了，接下来我们拿几个关键信息。

## 第二步：复制 App ID 和 App Secret

左边菜单栏点击 **"凭证与基础信息"**，你就能看到：

- App ID
- App Secret

把这两个复制出来，找个地方存好，后面配置 OpenClaw 要用。

## 第三步：开通机器人能力

很简单：

1. 左边菜单点击 **"添加应用能力"**
2. 找到 **"机器人"** 这个卡片，点击"添加"
3. 好了，就这样

## 第四步：给机器人开权限

机器人要能收消息发消息，得开权限。左边菜单点击 **"权限管理"**，我们需要开这些权限：

### 必须开的，不开用不了：

- 获取单聊、群组消息 → `im:message` 或者 `im:message:readonly`
- 接收群聊消息 → `im.message.receive_v1`
- 接收单聊消息 → `im.message.receive_v1`
- 以应用身份发消息 → `im:message:send_as_bot`

### 如果你以后要读飞书文档、表格，还要开这些：

- 读文档 → `drive:file:read`
- 写文档 → `drive:file:write`
- 读表格 → `sheets:spreadsheet`

你可以现在一次性开好，后面用的时候不用再回来了。

### 嫌一个个点太慢？我给你复制

你点击"导入权限"，把我这段 JSON 复制进去就行了，一次性开好：

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

复制完了点"申请开通"就行，如果你是个人账号，你自己就是管理员，直接通过。

## 第五步：发布应用，这步必须做

你配置完权限，**一定要先发布应用**，不发布没法配置事件订阅。

1. 点击顶部 "版本管理与发布" → "创建版本"
2. 填个版本号，比如 `1.0.0`，说明随便写
3. 点"确认发布"，等状态变成"已发布"就行了

## 第六步：配置事件订阅，这步很重要

不配置这步，你发消息它收不到：

1. 左边菜单点击 **"事件与回调"**
2. 订阅方式选 **"使用长连接接收事件"**——这个太方便了，**不需要公网 IP**，我们本地电脑就能用，一定要选这个
3. 点击"添加事件"，搜一下勾选 **接收消息 (im.message.receive_v1)**
4. 点确定保存
5. 机器人回调配置也选长连接

完了你记得**重新发布一次应用**，改了配置要重新发布。

## 第七步：回到 OpenClaw 配置飞书

现在我们改 OpenClav 的配置文件，就是那个 `~/.openclaw/openclaw.json`，找到 `channels`，加上飞书配置：

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

把 `appId` 和 `appSecret` 换成你刚才复制的，机器人名字你喜欢什么就写什么。

改完保存，重启 OpenClav 服务。

## 第八步：配对完成就能用了

配置完了，你打开飞书，找到你的机器人，给它发一条消息。

它会回你一条消息，给你一个配对码，像是这样：

```
请在终端执行这个命令完成配对:
openclaw pairing approve feishu 123456
```

你打开终端，把这个命令复制进去跑一下，就配对好了。

然后你再发消息，它就能正常回你了！🎉

## 常见问题我帮你整理好了

### Q: 我发了消息，它没回我，怎么回事？

A: 你照着检查：
1. 应用发布了吗？没发布收不到消息
2. 事件订阅加了接收消息吗？
3. 权限都开对了吗？能发消息吗？
4. 配对完成了吗？第一次必须配对

### Q: 我没有公网 IP 能用吗？

A: 当然可以！我们用了长连接模式，是 OpenClaw 主动连飞书服务器，所以不需要你有公网 IP，家里电脑直接用。

### Q: 群聊能用吗？

A: 当然可以，你把机器人拉进群，要说话的时候@它就行了。默认模式只有配对过的用户能说话，很安全。

## 小结

我带你走了一遍，其实就是八步：

1. 飞书开发者后台创建应用 → 拿 App ID 和 App Secret
2. 开机器人能力 → 申请权限 → 发布
3. 事件订阅选长连接 → 添加接收消息
4. OpenClav 配置文件加配置 → 重启
5. 飞书发消息 → 终端配对 → 就能用了

这下你能在飞书上和 OpenClav 聊天了，下一章我们说，怎么给 OpenClav 设定性格，四个文件搞定专属人设。

---
