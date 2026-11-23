#!/usr/bin/env bash
# 强化学习讲义构建脚本
# 用法：./build.sh [讲义文件名，默认 main]
set -euo pipefail

NAME="${1:-main}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# TeX Live 安装路径（按需修改）
export PATH="/c/texlive/2026/bin/windows:$PATH"

if ! command -v xelatex >/dev/null 2>&1; then
  echo "错误：未找到 xelatex，请确认 TeX Live 安装路径。" >&2
  exit 1
fi

echo "==> 编译 $NAME.tex (第 1 遍)"
xelatex -interaction=nonstopmode -halt-on-error "$NAME.tex" >/dev/null

echo "==> 编译 $NAME.tex (第 2 遍，解析交叉引用)"
xelatex -interaction=nonstopmode -halt-on-error "$NAME.tex" >/dev/null

echo "==> 完成：$DIR/$NAME.pdf"
