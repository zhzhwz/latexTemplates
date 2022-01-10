\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\GetIdInfo $Id: homework.cls 0.1 2022-01-10 12:00:00Z zhzhwz $
  {Template for writing your homework in tex}
\ProvidesExplClass{\ExplFileName}
  {\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}

% 判断系统信息
\msg_new:nnn { homework } { engine-unsupportd } 
  { \\
    This~ class~ requires~ XeTeX to~ compile. \\
    "#1"~ is~ not~ supported. \\
    You~ should~ choose~ "xelatex"~ as~ your~ engine.
  }
\sys_if_engine_xetex:F
  {
    \msg_fatal:nnx { homework } { engine-unsupportd } { \c_sys_engine_str }
  }
\PassOptionsToClass
  {
    UTF8,
    zihao     = -4,
  }
  { ctexart }
\LoadClass { ctexart }

%设置标题格式
\ctexset{section = {format={\Large\bfseries}}}
\renewcommand{\thesection}{\arabic{section}}
\newcommand{\Section}[2][]{
    \renewcommand\thesection{#2}
    \section{#1}
    \renewcommand\thesection{\arabic{section}}
}

\renewcommand{\thesubsection}{(\arabic{subsection})}
\newcommand{\Subsection}[2][]{
    \renewcommand\thesubsection{#2}
    \subsection{#1}
    \renewcommand\thesubsection{(\arabic{subsection})}
}

\renewcommand{\thesubsubsection}{\alph{subsubsection}}
\newcommand{\Subsubsection}[2][]{
    \renewcommand\thesubsubsection{#2}
    \subsubsection{#1}
    \renewcommand\thesubsubsection{\alph{subsubsection}}
}

% 声明文档信息所需变量
\clist_map_inline:nn
  {
    courseName, teacherName, labName, labNo, studentID, name, grade, 
    groupNo, date, time
  }
  { \tl_new:c { l__homework_info_ #1 _tl } }
\clist_new:N \l__homework_info_keywords_clist
\clist_new:N \l__homework_info_keywordsEN_clist
% 文章信息
\keys_define:nn { homework / info } 
  {
    courseName      .tl_set:N = \l__homework_info_courseName_tl,
    teacherName     .tl_set:N = \l__homework_info_teacherName_tl,
    studentID       .tl_set:N = \l__homework_info_studentID_tl, 
    name            .tl_set:N = \l__homework_info_name_tl, 
    grade           .tl_set:N = \l__homework_info_grade_tl, 
    homeworkIndex   .tl_set:N = \l__homework_info_homeworkIndex_tl, 
  }
% 文章信息默认值
\keys_set:nn { homework / info } 
  {
    courseName    = {(课程名称)},
    teacherName   = {(指导教师)},
    studentID     = {(学号)}, 
    name          = {(姓名)}, 
    grade         = {(年级)}, 
    homeworkIndex = {(作业序号)}, 
  }
\PassOptionsToPackage
  { mathrm=sym } { unicode-math }
\RequirePackage
  {
    geometry,
    amsmath,
    amssymb,
    unicode-math,
    xcolor,
    listings,
    caption,
    graphicx,
    fancyhdr,
    lastpage,
    enumitem
  }
\geometry
  {
    paper     = a4paper,
    top       = 2.54 cm, 
    bottom    = 2.54 cm, 
    left      = 2.5  cm, 
    right     = 2.5  cm
  }
\pagestyle{fancy}
  \fancyhead[L]     { \small \l__homework_info_studentID_tl \l__homework_info_name_tl}
  \fancyhead[C]     { \small \l__homework_info_courseName_tl }
  \fancyhead[R]     { \small \l__homework_info_homeworkIndex_tl }
  \fancyfoot[C]     { \small 第\ \thepage\ 页\quad 共\ \pageref{LastPage}\ 页  }
  \fancyfoot[L,R]   { }
  \headheight   = 13 pt 
\fancypagestyle{plain} 
  {
    \fancyhf        { }
    \fancyfoot[C]   {\small 第\ \thepage\ 页\quad 共\ \pageref{LastPage}\ 页 }
    \fancyfoot[L,R] { }
    \footskip = 30pt
    \renewcommand   { \headrulewidth } { 0 pt }
    \renewcommand   { \footrulewidth } { 0 pt }
  }
\captionsetup
  {
    margin      = 10 pt,
    font        = small,
    labelfont   = {bf},
  }
\setenumerate[1]
  {
    itemsep     = 0 pt,
    partopsep   = 0 pt,
    parsep      = \parskip,
    topsep      = 5 pt
  }
\setitemize[1]
  {
    itemsep     = 0 pt,
    partopsep   = 0 pt,
    parsep      = \parskip,
    topsep      = 5 pt
  }
\setdescription
  {
    itemsep     = 0 pt,
    partopsep   = 0 pt,
    parsep      = \parskip,
    topsep      = 5 pt
  }

% 字体设置
\tl_new:N \g__homework_font_EN_tl
\tl_new:N \g__homework_font_math_tl
\keys_define:nn { homework / style }
  {
    fontEN      .choices:nn =
      { times, lm, default }
      { \tl_set_eq:NN \g__homework_font_EN_tl \l_keys_choice_tl },
    fontMath    .choices:nn =
      { times, lm, default }
      { \tl_set_eq:NN \g__homework_font_math_tl \l_keys_choice_tl },
  }
\cs_new_eq:NN \__homework_set_family:nnn \xeCJK_set_family:nnn
\cs_new_eq:NN \__homework_switch_family:n \xeCJK_switch_family:n
\cs_new_protected:Npn \homework@kai
  { \__homework_switch_family:n { homework@kai } }
\cs_new_protected:Npn \__homework_setmainfont:nn #1#2
  { \__fontspec_main_setmainfont:nn {#2} {#1} }
\cs_new_protected:Npn \__homework_setsansfont:nn #1#2
  { \__fontspec_main_setsansfont:nn {#2} {#1} }
\cs_new_protected:Npn \__homework_setmonofont:nn #1#2
  { \__fontspec_main_setmonofont:nn {#2} {#1} }
\cs_new_protected:Npn \__homework_setmathfont:nn #1#2
  { \__um_setmathfont:nn {#2} {#1} }

\tl_new:N \g__homework_font_family_xits_tl
\tl_new:N \g__homework_font_style_xits_rm_tl
\tl_new:N \g__homework_font_style_xits_bf_tl
\tl_new:N \g__homework_font_style_xits_it_tl
\tl_new:N \g__homework_font_style_xits_bfit_tl
\tl_new:N \g__homework_font_name_xits_tl
\tl_new:N \g__homework_font_name_xits_math_rm_tl
\tl_new:N \g__homework_font_name_xits_math_bf_tl
\fontspec_font_if_exist:nTF { XITS-Regular.otf }
  {
    \tl_set:Nn \g__homework_font_family_xits_tl        { XITS             }
    \tl_set:Nn \g__homework_font_style_xits_rm_tl      { Regular          }
    \tl_set:Nn \g__homework_font_style_xits_bf_tl      { Bold             }
    \tl_set:Nn \g__homework_font_style_xits_it_tl      { Italic           }
    \tl_set:Nn \g__homework_font_style_xits_bfit_tl    { BoldItalic       }
    \tl_set:Nn \g__homework_font_name_xits_math_rm_tl  { XITSMath-Regular }
    \tl_set:Nn \g__homework_font_name_xits_math_bf_tl  { XITSMath-Bold    }
  }
  {
    \tl_set:Nn \g__homework_font_family_xits_tl        { xits          }
    \tl_set:Nn \g__homework_font_style_xits_rm_tl      { regular       }
    \tl_set:Nn \g__homework_font_style_xits_bf_tl      { bold          }
    \tl_set:Nn \g__homework_font_style_xits_it_tl      { italic        }
    \tl_set:Nn \g__homework_font_style_xits_bfit_tl    { bolditalic    }
    \tl_set:Nn \g__homework_font_name_xits_math_rm_tl  { xits-math     }
    \tl_set:Nn \g__homework_font_name_xits_math_bf_tl  { xits-mathbold }
  }

\cs_new_protected:Npn \__homework_load_fontEN_lm:  { }
\cs_new_protected:Npn \__homework_load_fontEN_times:
  {
    \__homework_setmainfont:nn { Times~ New~ Roman } { }
    \__homework_setsansfont:nn { Arial             } { }
    \__homework_setmonofont:nn { Courier~ New      } { }
  }
\cs_new_protected:Npn \__homework_load_fontMath_lm:
  { \__homework_setmathfont:nn { latinmodern-math.otf } { } }
\cs_new_protected:Npn \__homework_load_fontMath_times:
  { 
    \__homework_setmathfont:nn { \g__homework_font_name_xits_math_rm_tl .otf }
      { BoldFont = \g__homework_font_name_xits_math_bf_tl .otf }
  }
\cs_new_protected:Npn \__homework_load_font:
  {
    \use:c { __homework_load_fontEN_ \g__homework_font_EN_tl : }
    \use:c { __homework_load_fontMath_ \g__homework_font_math_tl : }
  }
\ctex_at_end_preamble:n { \__homework_load_font: }

\keys_set:nn { unicode-math }
  {
    math-style = ISO,
    bold-style = ISO,
  }
\keys_set:nn { homework / style } 
  {
    fontEN      = times,
    fontMath    = lm,
  }

\definecolor { colorKeyword     } { RGB } {  86,156,214 }
\definecolor { colorString      } { RGB } { 214,157,133 }
\definecolor { colorComment     } { RGB } {  87,166, 74 }
\definecolor { colorNumber      } { RGB } { 128,128,128 }
\definecolor { colorEmph        } { RGB } {  78,201,176 }
\definecolor { colorBackground  } { RGB } { 242,242,242 }
\definecolor { colorRule        } { RGB } { 177,0,52 }
\lstdefinestyle{style@base}
  {
    basewidth       = 0.6 em,
    lineskip        = 2 pt,
    frame           = l,
    framerule       = 2 pt,
    framesep        = 5 pt,
    xleftmargin     = 7 pt,
    basicstyle      = \small\ttfamily,
    rulecolor       = \color{colorRule},
    backgroundcolor = \color{colorBackground},
    breaklines      = true,
    showspaces      = false,
    showstringspaces= false,
    keywordstyle    = \color{colorKeyword},
    stringstyle     = \color{colorString},
    commentstyle    = \color{colorComment},
    emphstyle       = \color{colorEmph},
    numberstyle     = \color{colorNumber},
    tabsize         = 4,
  }
\lstset
  {
    style = style@base,
  }
\RenewDocumentCommand \lstlistingname { } {源代码}

% 提供接口
\keys_define:nn { homework }
  {
    info    .meta:nn = { homework / info } {#1},
    style   .meta:nn = { homework / style } {#1},
  }
\DeclareDocumentCommand \homeworkSetup { m } 
  { \keys_set:nn { homework } { #1 } }

% 制作标题
\AtBeginDocument
  {
    \begin{center}
      \thispagestyle{plain}
      { \Large\bf\l__homework_info_courseName_tl\l__homework_info_homeworkIndex_tl\par }
      \vskip 1.25em
      {
        \setlength{\tabcolsep}{0em}
        \begin{tabular}
            {
              p {0.14\textwidth}
              p {0.35\textwidth}
              p {0.08\textwidth}
              p {0.2\textwidth}
              p {0.08\textwidth}
              p {0.15\textwidth}
            }
            \textbf{课程名称:} &
              \l__homework_info_courseName_tl    &
            \textbf{学号:} &
              \l__homework_info_studentID_tl     & 
            \textbf{姓名:} &
              \l__homework_info_name_tl \\ 
            \textbf{指导教师:} &
              \l__homework_info_teacherName_tl   & 
            \textbf{年级:} &
              \l__homework_info_grade_tl         & 
            \textbf{成绩:} & \\ 
        \end{tabular}
        \par
      }
      \vskip 0.5em
      { \rule{\textwidth}{2pt} }
    \end{center}
  }
