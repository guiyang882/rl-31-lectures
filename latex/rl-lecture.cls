%% rl-lecture.cls — 强化学习 31 讲 · 讲义文档类
%% 编译方式：XeLaTeX（推荐）或 LuaLaTeX
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rl-lecture}[2026/11/23 v0.1 RL lecture notes]

%% ---------- 选项 ----------
\newif\ifrl@draft
\rl@draftfalse
\DeclareOption{draft}{\rl@drafttrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\LoadClass[UTF8, a4paper, 11pt, openany]{ctexart}

%% ---------- 基础宏包 ----------
\RequirePackage[a4paper, top=2.5cm, bottom=2.5cm, left=2.8cm, right=2.5cm]{geometry}
\RequirePackage{amsmath, amssymb, mathtools, amsfonts}
\RequirePackage{bm}
\RequirePackage{amsthm}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{listings}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{tcolorbox}
\tcbuselibrary{skills, breakable}
\RequirePackage{hyperref}
\RequirePackage{cleveref}

%% ---------- 配色 ----------
\definecolor{rlblue}{HTML}{2B5F8A}
\definecolor{rlgreen}{HTML}{1E7B5C}
\definecolor{rlred}{HTML}{B23A3A}
\definecolor{rlyellow}{HTML}{E8B33C}
\definecolor{rlgray}{HTML}{666666}
\definecolor{rlcodebg}{HTML}{F5F6F8}
\definecolor{rlcodeframe}{HTML}{D9DEE4}

%% ---------- 定理类环境 ----------
\theoremstyle{plain}
\newtheorem{definition}{定义}[section]
\newtheorem{theorem}{定理}[section]
\newtheorem{lemma}[theorem]{引理}
\newtheorem{proposition}[theorem]{命题}
\newtheorem{corollary}[theorem]{推论}

\theoremstyle{remark}
\newtheorem{remark}{注}[section]
\newtheorem{example}{例}[section]

%% ---------- 常用数学记号 ----------
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator*{\E}{\mathbb{E}}
\DeclareMathOperator{\Var}{\mathrm{Var}}
\DeclareMathOperator{\KL}{D_{\mathrm{KL}}}
\DeclareMathOperator{\clip}{\mathrm{clip}}
\DeclareMathOperator{\sign}{\mathrm{sign}}
\DeclareMathOperator{\softmax}{\mathrm{softmax}}
\DeclareMathOperator{\sgn}{\mathrm{sgn}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\abs}[1]{\left|#1\right|}
\newcommand{\norm}[1]{\left\|#1\right\|}
\newcommand{\inner}[1]{\left\langle#1\right\rangle}
\newcommand{\todo}[1]{\textcolor{rlred}{[TODO: #1]}}

%% ---------- 提示框：直觉 / 重点 / 坑 ----------
\newtcolorbox{intuition}[1][直觉]{
  enhanced, breakable, colback=rlblue!6, colframe=rlblue!70,
  boxrule=0.6pt, arc=3pt, left=10pt, right=10pt, top=6pt, bottom=6pt,
  title={#1}, fonttitle=\bfseries, coltitle=white
}
\newtcolorbox{keypoint}[1][重点]{
  enhanced, breakable, colback=rlgreen!6, colframe=rlgreen!70,
  boxrule=0.6pt, arc=3pt, left=10pt, right=10pt, top=6pt, bottom=6pt,
  title={#1}, fonttitle=\bfseries, coltitle=white
}
\newtcolorbox{pitfall}[1][坑]{
  enhanced, breakable, colback=rlred!6, colframe=rlred!70,
  boxrule=0.6pt, arc=3pt, left=10pt, right=10pt, top=6pt, bottom=6pt,
  title={#1}, fonttitle=\bfseries, coltitle=white
}

%% ---------- 代码样式 ----------
\lstdefinestyle{python}{
  language=Python,
  basicstyle=\ttfamily\small,
  keywordstyle=\color{rlblue}\bfseries,
  stringstyle=\color{rlgreen},
  commentstyle=\color{rlgray}\itshape,
  numberstyle=\tiny\color{rlgray},
  numbers=left,
  numbersep=8pt,
  frame=single,
  rulecolor=\color{rlcodeframe},
  backgroundcolor=\color{rlcodebg},
  breaklines=true,
  showstringspaces=false,
  extendedchars=true,
  captionpos=b,
  xleftmargin=8pt, framexleftmargin=6pt,
  escapeinside={(*@}{@*)}
}
\lstset{style=python}

%% ---------- 算法样式 ----------
\algnewcommand{\LineComment}[1]{$\triangleright$ #1}
\renewcommand{\algorithmicrequire}{\textbf{输入：}}
\renewcommand{\algorithmicensure}{\textbf{输出：}}
\floatname{algorithm}{算法}

%% ---------- 页眉页脚 ----------
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\textcolor{rlgray}{强化学习 31 讲}}
\fancyhead[R]{\small\textcolor{rlgray}{\leftmark}}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}

%% ---------- 标题格式 ----------
\titleformat{\section}
  {\Large\bfseries\color{rlblue}}{\thesection}{0.8em}{}
\titleformat{\subsection}
  {\large\bfseries}{\thesubsection}{0.6em}{}

%% ---------- 图表标题 ----------
\captionsetup{font=small, labelfont=bf, labelsep=quad}

%% ---------- 超链接 ----------
\hypersetup{
  colorlinks=true,
  linkcolor=rlblue,
  citecolor=rlgreen,
  urlcolor=rlblue,
  pdftitle={强化学习 31 讲},
  pdfauthor={}
}

%% ---------- 草稿模式标记 ----------
\ifrl@draft
  \RequirePackage{draftwatermark}
  \SetWatermarkText{草稿}
  \SetWatermarkScale{4}
  \SetWatermarkColor{rlred!15}
\fi

\endinput
