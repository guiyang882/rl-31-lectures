# LaTeX 讲义构建说明

## 这个目录是做什么的

把每讲讲义写成 LaTeX，编译成排版质量高的 PDF，用于：
- 读者下载收藏、打印
- 作为公众号文章的"完整版"底稿（文章是精简版，讲义是完整版）
- 后续汇编成一本完整的《强化学习 31 讲》PDF

## 文件结构

```
latex/
├── rl-lecture.cls          ← 统一样式（中文/公式/伪代码/代码框/提示框）
├── main.tex                ← 单讲讲义模板（当前是第 01 讲示例）
├── build.sh                ← 构建脚本（xelatex 编译两遍）
├── code/                   ← 配套 Python 代码，被 \lstinputlisting 引入
├── figures/                ← 图片（建议 PDF/SVG 矢量图）
└── *.pdf                   ← 编译产物（gitignore）
```

## 编译环境（当前机器未安装，需要二选一）

方案 A —— **TeX Live（推荐，完整稳定）**
- Windows: 从 https://tug.org/texlive/windows.html 下载安装器，选择 `scheme-full` 或至少包含 `ctex`、`algorithm2e`、`tcolorbox`、`listings` 的集合。
- 安装后确认命令行能找到 `xelatex`：
  ```bash
  xelatex --version
  ```

方案 B —— **MiKTeX（轻量，按需下载宏包）**
- Windows: https://miktex.org/download
- 首次编译时会自动下载缺失宏包，需要联网。

> 两个方案都要求用 **XeLaTeX** 编译（`build.sh` 已固定），因为中文支持走 `ctexart`。

## 怎么用

1. 复制 `main.tex` 为 `L01.tex`、`L02.tex` …… 每讲一个文件。
2. 修改 `\title{}` 为讲次与标题，正文按固定的四段式写：
   - 本讲结论（`keypoint` 框）
   - 核心概念（definition / theorem + 公式）
   - 直觉与坑（intuition / pitfall 框）
   - 实验与代码（lstinputlisting + 图 + 表 + 伪代码）
3. 编译：
   ```bash
   ./build.sh L01
   ```
   产物 `L01.pdf` 会生成在同目录。

## 样式速查

| 你写的 | 呈现效果 |
|---|---|
| `\begin{keypoint}[标题] ... \end{keypoint}` | 绿色"重点"框 |
| `\begin{intuition}[标题] ... \end{intuition}` | 蓝色"直觉"框 |
| `\begin{pitfall}[标题] ... \end{pitfall}` | 红色"坑"框 |
| `\begin{definition}[名称] ... \end{definition}` | 定义环境 |
| `\begin{algorithm}[H] ... \end{algorithm}` | 算法伪代码 |
| `\lstinputlisting[caption={...}]{code/x.py}` | 带行号的 Python 代码框 |
| `\E`, `\argmax`, `\KL`, `\clip`, `\softmax` | 预定义数学算子 |

## 与公众号文章的关系

一份内容，两种形态：
- **讲义 PDF**：完整推导、全部代码、伪代码、表格——完整版
- **公众号文章**：取"本讲结论 + 一个核心直觉 + 一个坑 + 实验现象"，压到 2500–3500 字——精简版

以后也可以装 Pandoc 做 Markdown → LaTeX 的自动转换，但数学公式密度高的讲义，
手写 LaTeX 的排版质量明显更好，建议核心讲次手工维护 `.tex`。
