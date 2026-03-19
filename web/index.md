---
layout: home

hero:
  name: "OpenClaw 零基础入门"
  text: "给普通人的 AI 智能体实战指南"
  tagline: 从零开始，一步一步，让 AI 真正帮你干活。
  image:
    src: /images/cover/book-cover.png
    alt: OpenClaw 零基础入门
  actions:
    - theme: brand
      text: 📖 在线阅读（Web 版）
      link: /chapters/01-preface
    - theme: alt
      text: 📄 PDF（图书发行版）
      link: /downloads/openclaw-book.pdf
    - theme: alt
      text: 📱 PDF（手机优化版）
      link: /downloads/openclaw-book-mobile.pdf

features:
  - icon: 🧠
    title: 零基础也能懂
    details: 每个概念用大白话讲清楚，不懂技术也能跟着做。
  - icon: 🦞
    title: 手把手教
    details: 从安装到配置，每一步都有详细指导，照着做就能跑起来。
  - icon: 🎯
    title: 实战场景丰富
    details: 31 章内容，覆盖晨间简报、自媒体运营、数据分析、客户服务等真实场景。
  - icon: 🔒
    title: 隐私自己掌控
    details: 所有数据都在本地，不用交给第三方，用着放心。
---

<div class="author-section">
  <img src="/images/author/avatar.jpg" alt="马力" class="author-avatar" />
  <div class="author-info">
    <p class="author-name">马力</p>
    <p class="author-title">资深产品经理、AI 研究者、产业经济和商业思维研究者</p>
    <p class="author-social">抖音：<strong>马力AI和商业思维</strong></p>
  </div>
</div>

<style>
.author-section {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1.5rem;
  padding: 2.5rem 1rem;
  margin: 0 auto;
  max-width: 600px;
}

.author-avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid var(--vp-c-brand-1);
  box-shadow: 0 4px 12px rgba(114, 47, 55, 0.2);
  flex-shrink: 0;
}

.author-info {
  text-align: left;
}

.author-name {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--vp-c-text-1);
  margin: 0 0 0.3rem 0;
}

.author-title {
  font-size: 0.9rem;
  color: var(--vp-c-text-2);
  margin: 0 0 0.2rem 0;
}

.author-social {
  font-size: 0.9rem;
  color: var(--vp-c-text-2);
  margin: 0;
}

@media (max-width: 640px) {
  .author-section {
    flex-direction: column;
    text-align: center;
  }
  .author-info {
    text-align: center;
  }
}
</style>
