#!/bin/bash

# OpenClaw Daily Blog Publisher
# 发布到 GitHub Pages (docs 目录)

# 生成今日文章
./generate-daily-post.sh

# Git 操作
git add .
git commit -m "chore: daily auto-update $(date +%Y-%m-%d)" || echo "No changes to commit"
git push origin main

echo "Published to GitHub Pages! View at: https://zhangsan-tea.github.io/openclaw-diary"