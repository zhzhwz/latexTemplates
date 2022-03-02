\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\GetIdInfo $Id: cglabreport.cls 0.1 2022-03-01 12:00:00Z zhzhwz $
  {Template for Undergraduate Lab Report of Computer Science, East China Normal University}
\ProvidesExplClass{\ExplFileName}
  {\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}

% 判断系统信息
\msg_new:nnn { cglabreport } { engine-unsupportd } 
  { \\
    This~ class~ requires~ XeTeX to~ compile. \\
    "#1"~ is~ not~ supported. \\
    You~ should~ choose~ "xelatex"~ as~ your~ engine.
  }
\sys_if_engine_xetex:F
  {
    \msg_fatal:nnx { cglabreport } { engine-unsupportd } { \c_sys_engine_str }
  }

\PassOptionsToClass
  {
    UTF8,
    zihao     = -4,
  }
  { ctexart }
\LoadClass { ctexart }
\keys_set:nn { ctex }
  {
    section = 
      {
        name        = {,、},
        number      = \zhnumber{\thesection}, 
        format      = \large\bfseries\raggedright,
        aftername   = \ ,
      },
    subsection={
        name        = {,},
        number      = \thesubsection, 
        format      = \bfseries\raggedright,
    },
  }

% 声明文档信息所需变量
\tl_set:Nn \l__cglabreport_title_tl {计算机图形学上机实践报告}
\clist_map_inline:nn
  {
    labName, labNo, studentID, name, date
  }
  { \tl_new:c { l__cglabreport_info_ #1 _tl } }
\clist_new:N \l__cglabreport_info_keywords_clist
\clist_new:N \l__cglabreport_info_keywordsEN_clist
% 文章信息
\keys_define:nn { cglabreport / info } 
  {
    labName     .tl_set:N = \l__cglabreport_info_labName_tl,
    labNo       .tl_set:N = \l__cglabreport_info_labNo_tl,
    studentID   .tl_set:N = \l__cglabreport_info_studentID_tl, 
    name        .tl_set:N = \l__cglabreport_info_name_tl, 
    date        .tl_set:N = \l__cglabreport_info_date_tl, 
  }
% 文章信息默认值
\keys_set:nn { cglabreport / info } 
  {
    labName     = {(上机实践名称)},
    labNo       = {(上机实践编号)},
    studentID   = {(学号)}, 
    name        = {(姓名)}, 
    date        = {(日期)}, 
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
  \fancyhead[L,R]   { }
  \fancyhead[C]     { \small \l__cglabreport_title_tl }
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
\tl_new:N \g__cglabreport_font_EN_tl
\tl_new:N \g__cglabreport_font_math_tl
\keys_define:nn { cglabreport / style }
  {
    fontEN      .choices:nn =
      { times, lm, default }
      { \tl_set_eq:NN \g__cglabreport_font_EN_tl \l_keys_choice_tl },
    fontMath    .choices:nn =
      { times, lm, default }
      { \tl_set_eq:NN \g__cglabreport_font_math_tl \l_keys_choice_tl },
  }
\cs_new_eq:NN \__cglabreport_set_family:nnn \xeCJK_set_family:nnn
\cs_new_eq:NN \__cglabreport_switch_family:n \xeCJK_switch_family:n
\cs_new_protected:Npn \cglabreport@kai
  { \__cglabreport_switch_family:n { cglabreport@kai } }
\cs_new_protected:Npn \__cglabreport_setmainfont:nn #1#2
  { \__fontspec_main_setmainfont:nn {#2} {#1} }
\cs_new_protected:Npn \__cglabreport_setsansfont:nn #1#2
  { \__fontspec_main_setsansfont:nn {#2} {#1} }
\cs_new_protected:Npn \__cglabreport_setmonofont:nn #1#2
  { \__fontspec_main_setmonofont:nn {#2} {#1} }
\cs_new_protected:Npn \__cglabreport_setmathfont:nn #1#2
  { \__um_setmathfont:nn {#2} {#1} }

\tl_new:N \g__cglabreport_font_family_xits_tl
\tl_new:N \g__cglabreport_font_style_xits_rm_tl
\tl_new:N \g__cglabreport_font_style_xits_bf_tl
\tl_new:N \g__cglabreport_font_style_xits_it_tl
\tl_new:N \g__cglabreport_font_style_xits_bfit_tl
\tl_new:N \g__cglabreport_font_name_xits_tl
\tl_new:N \g__cglabreport_font_name_xits_math_rm_tl
\tl_new:N \g__cglabreport_font_name_xits_math_bf_tl
\fontspec_font_if_exist:nTF { XITS-Regular.otf }
  {
    \tl_set:Nn \g__cglabreport_font_family_xits_tl        { XITS             }
    \tl_set:Nn \g__cglabreport_font_style_xits_rm_tl      { Regular          }
    \tl_set:Nn \g__cglabreport_font_style_xits_bf_tl      { Bold             }
    \tl_set:Nn \g__cglabreport_font_style_xits_it_tl      { Italic           }
    \tl_set:Nn \g__cglabreport_font_style_xits_bfit_tl    { BoldItalic       }
    \tl_set:Nn \g__cglabreport_font_name_xits_math_rm_tl  { XITSMath-Regular }
    \tl_set:Nn \g__cglabreport_font_name_xits_math_bf_tl  { XITSMath-Bold    }
  }
  {
    \tl_set:Nn \g__cglabreport_font_family_xits_tl        { xits          }
    \tl_set:Nn \g__cglabreport_font_style_xits_rm_tl      { regular       }
    \tl_set:Nn \g__cglabreport_font_style_xits_bf_tl      { bold          }
    \tl_set:Nn \g__cglabreport_font_style_xits_it_tl      { italic        }
    \tl_set:Nn \g__cglabreport_font_style_xits_bfit_tl    { bolditalic    }
    \tl_set:Nn \g__cglabreport_font_name_xits_math_rm_tl  { xits-math     }
    \tl_set:Nn \g__cglabreport_font_name_xits_math_bf_tl  { xits-mathbold }
  }

\cs_new_protected:Npn \__cglabreport_load_fontEN_lm:  { }
\cs_new_protected:Npn \__cglabreport_load_fontEN_times:
  {
    \__cglabreport_setmainfont:nn { Times~ New~ Roman } { }
    \__cglabreport_setsansfont:nn { Arial             } { }
    \__cglabreport_setmonofont:nn { Courier~ New      } { }
  }
\cs_new_protected:Npn \__cglabreport_load_fontMath_lm:
  { \__cglabreport_setmathfont:nn { latinmodern-math.otf } { } }
\cs_new_protected:Npn \__cglabreport_load_fontMath_times:
  { 
    \__cglabreport_setmathfont:nn { \g__cglabreport_font_name_xits_math_rm_tl .otf }
      { BoldFont = \g__cglabreport_font_name_xits_math_bf_tl .otf }
  }
\cs_new_protected:Npn \__cglabreport_load_font:
  {
    \use:c { __cglabreport_load_fontEN_ \g__cglabreport_font_EN_tl : }
    \use:c { __cglabreport_load_fontMath_ \g__cglabreport_font_math_tl : }
  }
\ctex_at_end_preamble:n { \__cglabreport_load_font: }

\keys_set:nn { unicode-math }
  {
    math-style = ISO,
    bold-style = ISO,
  }
\keys_set:nn { cglabreport / style } 
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
\keys_define:nn { cglabreport }
  {
    info    .meta:nn = { cglabreport / info } {#1},
    style   .meta:nn = { cglabreport / style } {#1},
  }
\DeclareDocumentCommand \cglabreportSetup { m } 
  { \keys_set:nn { cglabreport } { #1 } }

% 制作标题
\AtBeginDocument
  {
    \begin{center}
      \thispagestyle{plain}
      { \Large\bf\l__cglabreport_title_tl\par }
      \vskip 1.25em
      {
        \setlength{\tabcolsep}{0em}
        \begin{tabular}
          {
            p {0.125\textwidth}
            p {0.2\textwidth}
            p {0.075\textwidth}
            p {0.275\textwidth}
            p {0.125\textwidth}
            p {0.2\textwidth}
          }
          \textbf{姓名:} &
            \l__cglabreport_info_name_tl            &
          \textbf{学号:} & 
            \l__cglabreport_info_studentID_tl       & 
          \textbf{实验编号:} & 
            \l__cglabreport_info_labNo_tl          \\ 
          \textbf{实验题目:} & 
            \multicolumn{3}{l}{\l__cglabreport_info_labName_tl} &
          \textbf{实验时间:} & 
            \l__cglabreport_info_date_tl          
        \end{tabular}
        \par
      }
      \vskip 0.5em
      { \rule{\textwidth}{2pt} }
    \end{center}
  }