%% rl-lecture.cls — 强化学习 31 讲 · 讲义文档类
%% 编译方式：XeLaTeX（ctex 中文）
%% 依赖精简为 scheme-small 自带的宏包，无需额外安装
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rl-lecture}[2026/11/23 v0.2 RL lecture notes]

%% ---------- 选项 ----------
\newif\ifrl@draft
\rl@draftfalse
\DeclareOption{draft}{\rl@drafttrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\LoadClass[UTF8, a4paper, 11pt, openany]{ctexart}

%% ---------- 基础宏包（均为 TeX Live scheme-small 自带）----------
\RequirePackage[a4paper, top=2.5cm, bottom=2.5cm, left=2.8cm, right=2.5cm]{geometry}
\RequirePackage{amsmath, amssymb, mathtools, amsfonts}
\RequirePackage{bm}
\RequirePackage{amsthm}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{listings}
\RequirePackage{hyperref}

%% ---------- 配色 ----------
\definecolor{rlblue}{HTML}{2B5F8A}
\definecolor{rlgreen}{HTML}{1E7B5C}
\definecolor{rlred}{HTML}{B23A3A}
\definecolor{rlgray}{HTML}{666666}
\definecolor{rlcodebg}{HTML}{F5F6F8}
\definecolor{rlcodeframe}{HTML}{D9DEE4}
\definecolor{rlboxblue}{HTML}{EAF1F7}
\definecolor{rlboxgreen}{HTML}{E7F3EE}
\definecolor{rlboxred}{HTML}{F9EAEA}

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

%% ---------- 提示框：用 colorbox + minipage 实现（不依赖 tcolorbox）----------
\newcommand{\rlbox}[3]{%
  \par\medskip\noindent
  \colorbox{#1}{%
    \parbox{\dimexpr\linewidth-2\fboxsep\relax}{%
      \textbf{\color{#2}#3}%
    }%
  }\par\nopagebreak\vspace{2pt}%
  \noindent\begin{minipage}{\dimexpr\linewidth-8pt\relax}%
  \hspace{6pt}%
}
\newcommand{\rlboxend}{\end{minipage}\par\medskip}

\newenvironment{intuition}[1][直觉]{\rlbox{rlboxblue}{rlblue}{#1}}{\rlboxend}
\newenvironment{keypoint}[1][重点]{\rlbox{rlboxgreen}{rlgreen}{#1}}{\rlboxend}
\newenvironment{pitfall}[1][坑]{\rlbox{rlboxred}{rlred}{#1}}{\rlboxend}

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

%% 伪代码样式（用 listings 模拟，不依赖 algorithm/algpseudocode）
\lstdefinestyle{pseudocode}{
  basicstyle=\ttfamily\small,
  keywordstyle=\color{rlblue}\bfseries,
  commentstyle=\color{rlgray}\itshape,
  numbers=left,
  numbersep=8pt,
  frame=single,
  rulecolor=\color{rlcodeframe},
  backgroundcolor=\color{rlcodebg},
  breaklines=true,
  captionpos=b,
  xleftmargin=8pt, framexleftmargin=6pt
}

%% ---------- 页眉页脚 ----------
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\textcolor{rlgray}{强化学习 31 讲}}
\fancyhead[R]{\small\textcolor{rlgray}{\leftmark}}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}

%% ---------- 标题格式（不用 titlesec，直接重定义）----------
\makeatletter
\renewcommand{\section}{\@startsection{section}{1}{0pt}%
  {-1.5ex \@plus -0.5ex \@minus -0.3ex}{0.6ex}%
  {\Large\bfseries\color{rlblue}}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{0pt}%
  {-1.2ex \@plus -0.4ex \@minus -0.2ex}{0.4ex}%
  {\large\bfseries}}
\makeatother

%% ---------- 超链接 ----------
\hypersetup{
  colorlinks=true,
  linkcolor=rlblue,
  citecolor=rlgreen,
  urlcolor=rlblue,
  pdftitle={强化学习 31 讲},
  pdfauthor={}
}

\endinput
