#!/bin/bash

# OpenClaw Daily Blog Generator
# 生成每日博客文章

DATE=$(date +%Y-%m-%d)
YEAR=$(date +%Y)
MONTH=$(date +%m)

# 创建今日目录
mkdir -p posts/$YEAR/$MONTH

# 检查是否有今日的 memory 文件
if [ -f "/Users/lee/.openclaw/workspace-commander/memory/$DATE.md" ]; then
    # 读取今日记忆文件
    MEMORY_CONTENT=$(cat "/Users/lee/.openclaw/workspace-commander/memory/$DATE.md")
    
    # 检查是否有新技能文件（今天创建的）
    NEW_SKILLS=""
    if ls /Users/lee/.agents/skills/* 2>/dev/null | grep -q "$DATE"; then
        NEW_SKILLS="## 新技能 (Skills)\n"
        for skill_file in /Users/lee/.agents/skills/*; do
            if [[ $(stat -f "%Sm" -t "%Y-%m-%d" "$skill_file") == "$DATE" ]]; then
                skill_name=$(basename "$skill_file" .md)
                NEW_SKILLS="$NEW_SKILLS- [$skill_name]($skill_file)\n"
            fi
        done
    fi
    
    # 生成博客文章
    cat > "posts/$DATE-daily-summary.md" << EOF
# $DATE - OpenClaw 日常记录

> 自动化生成的每日总结

## 今日记忆

$MEMORY_CONTENT

$NEW_SKILLS

---

*本文由 OpenClaw 自动化系统生成*
EOF
    
    echo "Generated daily post for $DATE"
else
    echo "No memory file found for $DATE, skipping..."
fi