#!/bin/bash
# ============================================================
# OpenClaw 零基础入门 - 构建脚本
# 用法: ./scripts/build.sh [all|merge|pdf|mobile|web]
# ============================================================

set -e

# 项目根目录
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
CHAPTERS_DIR="$SRC_DIR/chapters"
TEMPLATES_DIR="$ROOT_DIR/templates"
PUB_DIR="$ROOT_DIR/pub"

# 确保 xelatex 在 PATH 中
eval "$(/usr/libexec/path_helper)" 2>/dev/null || true

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${BLUE}[build]${NC} $1"; }
ok() { echo -e "${GREEN}[done]${NC} $1"; }
err() { echo -e "${RED}[error]${NC} $1"; }

# ---- 章节列表 ----
CHAPTER_FILES=(
    "00-cover.md"
    "00-preface.md"
    "01-preface.md"
    "02-what-is-agent.md"
    "03-core-concepts.md"
    "04-what-is-openclaw.md"
    "05-architecture.md"
    "06-memory-system.md"
    "07-prepare.md"
    "08-install.md"
    "09-config-model.md"
    "10-feishu-integration.md"
    "11-personality.md"
    "12-what-is-skills.md"
    "13-clawhub.md"
    "14-core-skills.md"
    "15-office-skills.md"
    "16-content-data-skills.md"
    "17-advanced-skills.md"
    "18-write-your-own-skill.md"
    "19-entry-scenarios.md"
    "20-creative-cases.md"
    "21-project实战.md"
    "22-self-media-automation.md"
    "23-knowledge-management.md"
    "24-multi-agent.md"
    "25-data-analysis.md"
    "26-customer-service.md"
    "27-n8n-workflows.md"
    "28-troubleshooting.md"
    "29-security.md"
    "30-ending.md"
    "31-appendix-cheatsheet.md"
)

# ---- 合并章节 ----
merge_chapters() {
    log "合并章节文件 → src/full-book.md"
    > "$SRC_DIR/full-book.md"
    for f in "${CHAPTER_FILES[@]}"; do
        if [ -f "$CHAPTERS_DIR/$f" ]; then
            cat "$CHAPTERS_DIR/$f" >> "$SRC_DIR/full-book.md"
            echo -e "\n\n" >> "$SRC_DIR/full-book.md"
        fi
    done
    ok "合并完成 ($(wc -l < "$SRC_DIR/full-book.md") 行)"
}

# ---- 生成 B5 标准版 PDF ----
build_pdf() {
    log "生成 B5 标准版 PDF"
    mkdir -p "$PUB_DIR/pdf"
    pandoc "$SRC_DIR/full-book.md" \
        --metadata-file="$TEMPLATES_DIR/pdf/metadata.yaml" \
        --include-in-header="$TEMPLATES_DIR/pdf/book-style.tex" \
        -o "$PUB_DIR/pdf/openclaw-book.pdf" \
        --pdf-engine=xelatex \
        --resource-path="$CHAPTERS_DIR:$SRC_DIR" \
        --top-level-division=chapter \
        --wrap=preserve \
        2>&1 | grep -v "WARNING" || true
    ok "B5 PDF → pub/pdf/openclaw-book.pdf ($(du -h "$PUB_DIR/pdf/openclaw-book.pdf" | cut -f1))"
}

# ---- 生成手机版 PDF ----
build_mobile() {
    log "生成手机版 PDF"
    mkdir -p "$PUB_DIR/pdf"
    pandoc "$SRC_DIR/full-book.md" \
        --metadata-file="$TEMPLATES_DIR/pdf/metadata-mobile.yaml" \
        --include-in-header="$TEMPLATES_DIR/pdf/mobile-style.tex" \
        -o "$PUB_DIR/pdf/openclaw-book-mobile.pdf" \
        --pdf-engine=xelatex \
        --resource-path="$CHAPTERS_DIR:$SRC_DIR" \
        --top-level-division=chapter \
        --wrap=preserve \
        2>&1 | grep -v "WARNING" || true
    ok "手机 PDF → pub/pdf/openclaw-book-mobile.pdf ($(du -h "$PUB_DIR/pdf/openclaw-book-mobile.pdf" | cut -f1))"
}

# ---- 同步章节到 Web 目录 ----
sync_web() {
    log "同步章节到 web/ 目录"
    mkdir -p "$ROOT_DIR/web/chapters" "$ROOT_DIR/web/public"
    rsync -a --delete --exclude='00-cover.md' --exclude='00-toc.md' "$CHAPTERS_DIR/" "$ROOT_DIR/web/chapters/"
    rsync -a --delete --exclude='*.md' "$SRC_DIR/images/" "$ROOT_DIR/web/chapters/images/"
    mkdir -p "$ROOT_DIR/web/public/images/cover" "$ROOT_DIR/web/public/images/author" "$ROOT_DIR/web/public/downloads"
    cp "$SRC_DIR/images/cover/book-cover.png" "$ROOT_DIR/web/public/images/cover/"
    cp "$SRC_DIR/images/author/avatar.jpg" "$ROOT_DIR/web/public/images/author/"
    # 复制 PDF 到 downloads（如果存在）
    [ -f "$PUB_DIR/pdf/openclaw-book.pdf" ] && cp "$PUB_DIR/pdf/openclaw-book.pdf" "$ROOT_DIR/web/public/downloads/"
    [ -f "$PUB_DIR/pdf/openclaw-book-mobile.pdf" ] && cp "$PUB_DIR/pdf/openclaw-book-mobile.pdf" "$ROOT_DIR/web/public/downloads/"
    # 修复图片路径：../images/ → ./images/
    sed -i '' 's|\.\./images/|./images/|g' "$ROOT_DIR/web/chapters/"*.md
    ok "同步完成 ($(ls "$ROOT_DIR/web/chapters/"*.md | wc -l) 章节)"
}

# ---- 构建 Web 版 ----
build_web() {
    sync_web
    log "构建 Web 版"
    if [ ! -d "$ROOT_DIR/web/node_modules" ]; then
        log "安装 Web 依赖..."
        cd "$ROOT_DIR/web" && npm install
    fi
    cd "$ROOT_DIR/web" && npx vitepress build
    mkdir -p "$PUB_DIR/html"
    cp -r "$ROOT_DIR/web/.vitepress/dist/"* "$PUB_DIR/html/"
    ok "Web 版 → pub/html/"
}

# ---- 主入口 ----
case "${1:-all}" in
    merge)  merge_chapters ;;
    pdf)    merge_chapters && build_pdf ;;
    mobile) merge_chapters && build_mobile ;;
    web)    build_web ;;
    all)
        merge_chapters
        build_pdf
        build_mobile
        echo ""
        ok "全部构建完成 ✅"
        ls -lh "$PUB_DIR/pdf/"
        ;;
    *)
        echo "用法: $0 [all|merge|pdf|mobile|web]"
        exit 1
        ;;
esac
