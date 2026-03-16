#!/bin/bash
# ============================================================
# OpenClaw 小龙虾入门指南 - 构建脚本
# 用法: ./scripts/build.sh [all|merge|pdf|mobile]
# ============================================================

set -e

# 项目根目录
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
CHAPTERS_DIR="$SRC_DIR/chapters"
TEMPLATES_DIR="$ROOT_DIR/templates/pdf"
PUB_DIR="$ROOT_DIR/pub/pdf"

# 确保 xelatex 在 PATH 中
eval "$(/usr/libexec/path_helper)" 2>/dev/null || true

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}[build]${NC} $1"; }
ok() { echo -e "${GREEN}[done]${NC} $1"; }

# ---- 合并章节 ----
merge_chapters() {
    log "合并章节文件 → src/full-book.md"
    cat \
        "$CHAPTERS_DIR/01-preface.md" \
        "$CHAPTERS_DIR/02-what-is-agent.md" \
        "$CHAPTERS_DIR/03-core-concepts.md" \
        "$CHAPTERS_DIR/04-what-is-openclaw.md" \
        "$CHAPTERS_DIR/05-architecture.md" \
        "$CHAPTERS_DIR/06-memory-system.md" \
        "$CHAPTERS_DIR/07-prepare.md" \
        "$CHAPTERS_DIR/08-install.md" \
        "$CHAPTERS_DIR/09-config-model.md" \
        "$CHAPTERS_DIR/10-feishu-integration.md" \
        "$CHAPTERS_DIR/11-personality.md" \
        "$CHAPTERS_DIR/12-what-is-skills.md" \
        "$CHAPTERS_DIR/13-clawhub.md" \
        "$CHAPTERS_DIR/14-core-skills.md" \
        "$CHAPTERS_DIR/15-office-skills.md" \
        "$CHAPTERS_DIR/16-content-data-skills.md" \
        "$CHAPTERS_DIR/17-advanced-skills.md" \
        "$CHAPTERS_DIR/18-write-your-own-skill.md" \
        "$CHAPTERS_DIR/19-entry-scenarios.md" \
        "$CHAPTERS_DIR/20-creative-cases.md" \
        "$CHAPTERS_DIR/21-project实战.md" \
        "$CHAPTERS_DIR/22-self-media-automation.md" \
        "$CHAPTERS_DIR/23-knowledge-management.md" \
        "$CHAPTERS_DIR/24-multi-agent.md" \
        "$CHAPTERS_DIR/25-data-analysis.md" \
        "$CHAPTERS_DIR/26-customer-service.md" \
        "$CHAPTERS_DIR/27-n8n-workflows.md" \
        "$CHAPTERS_DIR/28-troubleshooting.md" \
        "$CHAPTERS_DIR/29-security.md" \
        "$CHAPTERS_DIR/30-ending.md" \
        "$CHAPTERS_DIR/31-appendix-cheatsheet.md" \
        > "$SRC_DIR/full-book.md"
    ok "合并完成 ($(wc -l < "$SRC_DIR/full-book.md") 行)"
}

# ---- 生成 A4 PDF ----
build_pdf() {
    log "生成 A4 电脑版 PDF"
    mkdir -p "$PUB_DIR"
    pandoc "$TEMPLATES_DIR/metadata.yaml" "$SRC_DIR/full-book.md" \
        -o "$PUB_DIR/openclaw-book.pdf" \
        --pdf-engine=xelatex \
        --top-level-division=chapter 2>&1 | grep -v "WARNING" || true
    ok "A4 PDF → pub/pdf/openclaw-book.pdf ($(du -h "$PUB_DIR/openclaw-book.pdf" | cut -f1))"
}

# ---- 生成手机版 PDF ----
build_mobile() {
    log "生成手机版 PDF"
    mkdir -p "$PUB_DIR"
    pandoc "$TEMPLATES_DIR/metadata-mobile.yaml" "$SRC_DIR/full-book.md" \
        -o "$PUB_DIR/openclaw-book-mobile.pdf" \
        --pdf-engine=xelatex \
        --top-level-division=chapter 2>&1 | grep -v "WARNING" || true
    ok "手机 PDF → pub/pdf/openclaw-book-mobile.pdf ($(du -h "$PUB_DIR/openclaw-book-mobile.pdf" | cut -f1))"
}

# ---- 主入口 ----
case "${1:-all}" in
    merge)  merge_chapters ;;
    pdf)    merge_chapters && build_pdf ;;
    mobile) merge_chapters && build_mobile ;;
    all)
        merge_chapters
        build_pdf
        build_mobile
        echo ""
        ok "全部构建完成 ✅"
        ls -lh "$PUB_DIR/"
        ;;
    *)
        echo "用法: $0 [all|merge|pdf|mobile]"
        exit 1
        ;;
esac
