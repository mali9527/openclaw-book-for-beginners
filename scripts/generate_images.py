#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import locale
import os as _os
# 修复 Python 3.9 在某些终端下的中文编码问题
_os.environ.setdefault("PYTHONIOENCODING", "utf-8")
try:
    locale.setlocale(locale.LC_ALL, '')
except locale.Error:
    pass
"""
OpenClaw 入门书 - 插图自动生成脚本
使用 Google Nano Banana 2.0 (gemini-3.1-flash-image-preview) 生成书籍插图

首次使用:
  1. 安装依赖: pip install google-genai Pillow
  2. 在项目根目录创建 .env 文件，写入: GOOGLE_API_KEY=你的key
  3. 生成全部插图: python scripts/generate_images.py

其他用法:
  生成单章插图: python scripts/generate_images.py --chapter 03
  列出所有插图: python scripts/generate_images.py --list
  输出引用代码: python scripts/generate_images.py --refs
"""

import argparse
import os
import sys
from pathlib import Path

# 自动从 .env 文件加载 API Key（无需手动 export）
def load_env():
    env_path = Path(__file__).resolve().parent.parent / ".env"
    if env_path.exists():
        for line in env_path.read_text().splitlines():
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                key, _, value = line.partition("=")
                os.environ.setdefault(key.strip(), value.strip())

load_env()

# ============================================================
# 插图配置：每章需要的插图、提示词、文件名
# 你只需要修改这里就能增删插图
# ============================================================

IMAGE_SPECS = {
    "03": [
        {
            "filename": "five-components.png",
            "prompt": (
                "A clean, modern infographic illustration showing 5 core components of an AI agent, "
                "arranged in a horizontal layout with cute icons: "
                "1) a brain icon labeled '大脑' (reasoning), "
                "2) a notebook icon labeled '笔记本' (memory), "
                "3) a reference book icon labeled '参考书' (RAG), "
                "4) a robotic hand icon labeled '手' (MCP tools), "
                "5) a recipe book icon labeled '菜谱' (skills). "
                "Flat design style, pastel colors, white background, suitable for a tech book. "
                "Chinese labels. No text other than the labels."
            ),
            "description": "五大核心组件示意图",
        },
    ],
    "05": [
        {
            "filename": "gateway-architecture.png",
            "prompt": (
                "A clean architectural diagram showing a 'Gateway' (labeled '电话总机') in the center, "
                "connecting a user on the left (with chat apps like 飞书, Telegram icons) "
                "to AI services on the right (brain icon for LLM, file icon for memory, "
                "toolbox icon for MCP tools, book icon for skills). "
                "Flat design, pastel blue and white color scheme, suitable for a tech book illustration. "
                "Arrows showing data flow. Chinese labels."
            ),
            "description": "Gateway 电话总机架构图",
        },
    ],
    "06": [
        {
            "filename": "memory-layers.png",
            "prompt": (
                "An illustration showing 3 layers of AI memory as stacked notebooks of different thickness: "
                "top layer is a thin sticky note labeled '短期记忆' (short-term), "
                "middle layer is a medium notebook labeled '长期记忆' (long-term), "
                "bottom layer is a thick reference book labeled '知识库' (knowledge base). "
                "Cute cartoon style, pastel colors, white background. Chinese labels."
            ),
            "description": "分层记忆示意图",
        },
    ],
    "08": [
        {
            "filename": "openclaw-home-dir.png",
            "prompt": (
                "A cute illustration of a cartoon lobster (小龙虾) living inside a house-shaped folder structure. "
                "The house has rooms labeled: '大脑设置' (openclaw.json), '书房' (knowledge), "
                "'工具箱' (skills), '办公室' (workspace). "
                "Flat design, warm colors, white background, suitable for a beginner tech book."
            ),
            "description": "小龙虾的家 - 目录结构示意图",
        },
    ],
    "12": [
        {
            "filename": "tool-vs-skill.png",
            "prompt": (
                "A side-by-side comparison illustration: "
                "Left side shows individual kitchen tools (pan, spatula, knife) labeled '工具 (Tools)'. "
                "Right side shows a complete recipe card with numbered steps labeled '技能 (Skills)'. "
                "An arrow connects them with text '组合'. "
                "Clean flat design, pastel colors, white background. Chinese labels."
            ),
            "description": "工具 vs 技能对比图",
        },
    ],
    "19": [
        {
            "filename": "morning-briefing.png",
            "prompt": (
                "A smartphone screen showing a morning briefing message from an AI assistant: "
                "weather icon with '晴 25°C', calendar icon with '3个会议', "
                "news icon with '今日要闻', todo icon with '5项待办'. "
                "Clean modern UI design, soft gradient background, Chinese text labels."
            ),
            "description": "晨间简报效果示意图",
        },
    ],
    "22": [
        {
            "filename": "content-workflow.png",
            "prompt": (
                "A horizontal 5-step workflow diagram for content creation automation: "
                "Step 1 '选题' (lightbulb icon), Step 2 '调研' (magnifying glass), "
                "Step 3 '初稿' (document icon), Step 4 '改编' (edit icon), "
                "Step 5 '分发' (share icon). "
                "Connected by arrows, numbered circles, flat design, gradient blue-purple palette. "
                "Chinese labels."
            ),
            "description": "自媒体 5 步流程图",
        },
    ],
    "29": [
        {
            "filename": "security-shield.png",
            "prompt": (
                "An illustration of a cute cartoon lobster (小龙虾) holding a shield and standing guard "
                "in front of a computer, protecting it from dark shadowy threats trying to approach. "
                "The shield has a lock icon on it. "
                "Cartoon style, warm protective feeling, white background."
            ),
            "description": "安全防护概念图",
        },
    ],
}

# ============================================================
# 生成逻辑
# ============================================================

ROOT_DIR = Path(__file__).resolve().parent.parent
IMAGES_DIR = ROOT_DIR / "src" / "images"

# Nano Banana 2.0 model ID
MODEL_ID = "gemini-3.1-flash-image-preview"


def ensure_dirs():
    """确保所有章节的图片目录存在"""
    for chapter in IMAGE_SPECS:
        (IMAGES_DIR / chapter).mkdir(parents=True, exist_ok=True)


def list_all_images():
    """列出所有计划生成的插图"""
    total = 0
    for chapter, specs in sorted(IMAGE_SPECS.items()):
        print(f"\n📂 第 {chapter} 章:")
        for spec in specs:
            exists = (IMAGES_DIR / chapter / spec["filename"]).exists()
            status = "✅ 已生成" if exists else "⬜ 待生成"
            print(f"   {status}  {spec['filename']}  —  {spec['description']}")
            total += 1
    print(f"\n共 {total} 张插图")


def generate_image(chapter: str, spec: dict, force: bool = False):
    """使用 Nano Banana 2.0 生成单张图片"""
    output_path = IMAGES_DIR / chapter / spec["filename"]

    if output_path.exists() and not force:
        print(f"   ⏭️  跳过（已存在）: {spec['filename']}")
        return True

    try:
        from google import genai
        from google.genai import types

        client = genai.Client()

        response = client.models.generate_content(
            model=MODEL_ID,
            contents=spec["prompt"],
            config=types.GenerateContentConfig(
                response_modalities=["IMAGE", "TEXT"],
                # 图书印刷级别，使用 1K 分辨率（平衡质量和速度）
            ),
        )

        # 从响应中提取图片
        for part in response.candidates[0].content.parts:
            if part.inline_data is not None:
                image_data = part.inline_data.data
                with open(output_path, "wb") as f:
                    f.write(image_data)
                print(f"   ✅ 已生成: {spec['filename']}  ({output_path.stat().st_size // 1024}KB)")
                return True

        print(f"   ❌ 未返回图片: {spec['filename']}")
        return False

    except Exception as e:
        print(f"   ❌ 生成失败: {spec['filename']} — {e}")
        return False


def generate_chapter(chapter: str, force: bool = False):
    """生成某一章的所有插图"""
    if chapter not in IMAGE_SPECS:
        print(f"❌ 第 {chapter} 章没有配置插图")
        return

    specs = IMAGE_SPECS[chapter]
    print(f"\n🎨 第 {chapter} 章 — {len(specs)} 张插图:")

    for spec in specs:
        generate_image(chapter, spec, force)


def generate_all(force: bool = False):
    """生成全部插图"""
    total = sum(len(specs) for specs in IMAGE_SPECS.values())
    print(f"🎨 开始生成全部 {total} 张插图 (模型: {MODEL_ID})\n")

    success = 0
    for chapter in sorted(IMAGE_SPECS.keys()):
        generate_chapter(chapter, force)
        success += sum(
            1 for spec in IMAGE_SPECS[chapter]
            if (IMAGES_DIR / chapter / spec["filename"]).exists()
        )

    print(f"\n{'=' * 40}")
    print(f"✅ 完成: {success}/{total} 张插图已就绪")
    print(f"📁 存放目录: src/images/")


def generate_markdown_refs():
    """生成每章的 Markdown 图片引用代码，方便复制粘贴到章节里"""
    print("\n📋 以下是各章节的 Markdown 图片引用代码，复制粘贴到对应章节即可:\n")
    for chapter, specs in sorted(IMAGE_SPECS.items()):
        print(f"--- 第 {chapter} 章 ---")
        for spec in specs:
            print(f'![{spec["description"]}](../images/{chapter}/{spec["filename"]})')
        print()


# ============================================================
# 主入口
# ============================================================

def main():
    parser = argparse.ArgumentParser(description="OpenClaw 书籍插图自动生成工具")
    parser.add_argument("--chapter", "-c", help="只生成指定章节的插图（如 03、08）")
    parser.add_argument("--list", "-l", action="store_true", help="列出所有插图计划")
    parser.add_argument("--force", "-f", action="store_true", help="强制重新生成已有的图片")
    parser.add_argument("--refs", "-r", action="store_true", help="输出 Markdown 图片引用代码")
    args = parser.parse_args()

    # 检查 API Key
    if not args.list and not args.refs:
        if not os.environ.get("GOOGLE_API_KEY"):
            print("❌ 请先设置环境变量: export GOOGLE_API_KEY='你的API_KEY'")
            print("   你可以在 https://aistudio.google.com/apikey 获取 API Key")
            sys.exit(1)

    ensure_dirs()

    if args.list:
        list_all_images()
    elif args.refs:
        generate_markdown_refs()
    elif args.chapter:
        generate_chapter(args.chapter, args.force)
    else:
        generate_all(args.force)


if __name__ == "__main__":
    main()
