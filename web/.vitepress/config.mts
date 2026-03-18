import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'OpenClaw 零基础入门',
  description: '给普通人的 AI 智能体实战指南',
  lang: 'zh-CN',
  base: '/openclaw-book-for-beginners/',
  ignoreDeadLinks: true,

  head: [
    ['meta', { name: 'author', content: '马力' }],
    ['meta', { name: 'keywords', content: 'OpenClaw, AI, 智能体, 入门, 零基础' }],
  ],

  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '开始阅读', link: '/chapters/01-preface' },
      { text: '作者', link: '/chapters/00-preface' },
    ],

    sidebar: [
      {
        text: '📖 开篇',
        items: [
          { text: '自序', link: '/chapters/00-preface' },
          { text: '前言', link: '/chapters/01-preface' },
        ]
      },
      {
        text: '🧠 第一部分：认识 AI 智能体',
        collapsed: false,
        items: [
          { text: '什么是 AI 智能体？', link: '/chapters/02-what-is-agent' },
          { text: '五个核心组件', link: '/chapters/03-core-concepts' },
        ]
      },
      {
        text: '🦞 第二部分：认识 OpenClaw',
        collapsed: false,
        items: [
          { text: 'OpenClaw 是什么？', link: '/chapters/04-what-is-openclaw' },
          { text: '架构：电话总机', link: '/chapters/05-architecture' },
          { text: '分层记忆系统', link: '/chapters/06-memory-system' },
        ]
      },
      {
        text: '🔧 第三部分：安装配置',
        collapsed: false,
        items: [
          { text: '准备工作', link: '/chapters/07-prepare' },
          { text: '安装 OpenClaw', link: '/chapters/08-install' },
          { text: '配置大模型', link: '/chapters/09-config-model' },
          { text: '接入飞书', link: '/chapters/10-feishu-integration' },
          { text: '设定 AI 性格', link: '/chapters/11-personality' },
        ]
      },
      {
        text: '⚡ 第四部分：技能系统',
        collapsed: true,
        items: [
          { text: '技能是什么？', link: '/chapters/12-what-is-skills' },
          { text: 'ClawHub 技能商店', link: '/chapters/13-clawhub' },
          { text: '核心三件套', link: '/chapters/14-core-skills' },
          { text: '办公效率技能', link: '/chapters/15-office-skills' },
          { text: '内容与数据技能', link: '/chapters/16-content-data-skills' },
          { text: '进阶技能', link: '/chapters/17-advanced-skills' },
          { text: '自己写技能', link: '/chapters/18-write-your-own-skill' },
        ]
      },
      {
        text: '🎯 第五部分：实用场景',
        collapsed: true,
        items: [
          { text: '8 个实用场景', link: '/chapters/19-entry-scenarios' },
          { text: '6 个创意玩法', link: '/chapters/20-creative-cases' },
          { text: '项目实战', link: '/chapters/21-project实战' },
        ]
      },
      {
        text: '🚀 第六部分：进阶实战',
        collapsed: true,
        items: [
          { text: '自媒体自动化', link: '/chapters/22-self-media-automation' },
          { text: '知识管理系统', link: '/chapters/23-knowledge-management' },
          { text: '多 Agent 协作', link: '/chapters/24-multi-agent' },
          { text: '数据分析自动化', link: '/chapters/25-data-analysis' },
          { text: '客户服务系统', link: '/chapters/26-customer-service' },
          { text: 'n8n 工作流', link: '/chapters/27-n8n-workflows' },
        ]
      },
      {
        text: '🛡️ 第七部分：安全与进阶',
        collapsed: true,
        items: [
          { text: '故障排除', link: '/chapters/28-troubleshooting' },
          { text: '安全指南', link: '/chapters/29-security' },
          { text: '写在最后', link: '/chapters/30-ending' },
          { text: '命令速查表', link: '/chapters/31-appendix-cheatsheet' },
        ]
      },
    ],

    footer: {
      message: '作者：马力 ｜ 抖音：马力AI和商业思维',
      copyright: '© 2026 马力. All rights reserved.'
    },

    search: {
      provider: 'local'
    },

    outline: {
      label: '本章目录',
      level: [2, 3]
    },

    docFooter: {
      prev: '上一章',
      next: '下一章'
    },
    
    darkModeSwitchLabel: '深色模式',
    sidebarMenuLabel: '目录',
    returnToTopLabel: '回到顶部',
  },

  markdown: {
    lineNumbers: true,
  },
})
