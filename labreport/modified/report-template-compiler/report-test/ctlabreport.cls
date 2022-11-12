\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\GetIdInfo $Id: ctlabreport.cls 0.1 2022-11-07 12:00:00Z zhzhwz <zhzhwz@stu.ecnu.edu.cn> $
  {Compiler Design Report for ECNU, CS}
\ProvidesExplClass{\ExplFileName}
  {\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}

% 判断系统信息
\msg_new:nnn { ctlabreport } { engine-unsupportd } 
  { \\
    This~ class~ requires~ XeTeX to~ compile. \\
    "#1"~ is~ not~ supported. \\
    You~ should~ choose~ "xelatex"~ as~ your~ engine.
  }
\sys_if_engine_xetex:F
  {
    \msg_fatal:nnx { ctlabreport } { engine-unsupportd } { \c_sys_engine_str }
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
        name        = {,},
        number      = {\arabic{section}.}, 
        format      = \large\bfseries\raggedright,
        aftername   = \ ,
      },
    subsection={
        name        = {,},
        number      = {\arabic{section}.\arabic{subsection}}, 
        format      = \bfseries\raggedright,
    },
  }

% 声明文档信息所需变量
\tl_set:Nn \l__ctlabreport_title_tl {华东师范大学计算机科学技术系上机实践报告}
\clist_map_inline:nn
  {
    projectName, authorName, version, date
  }
  { \tl_new:c { l__ctlabreport_info_ #1 _tl } }
\clist_new:N \l__ctlabreport_info_keywords_clist
\clist_new:N \l__ctlabreport_info_keywordsEN_clist
% 文章信息
\keys_define:nn { ctlabreport / info } 
  {
    projectName .tl_set:N = \l__ctlabreport_info_projectName_tl, 
    authorName  .tl_set:N = \l__ctlabreport_info_authorName_tl, 
    version     .tl_set:N = \l__ctlabreport_info_version_tl, 
    date        .tl_set:N = \l__ctlabreport_info_date_tl, 
  }
% 文章信息默认值
\keys_set:nn { ctlabreport / info } 
  {
    projectName = {(项目名)},
    authorName  = {(作者)},
    version     = {(版本号)},
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
    enumitem,
    textpos
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
  \fancyhead[L]     { \small \l__ctlabreport_info_projectName_tl \\ 软件测试说明书 }
  \fancyhead[C]     { \small Date: \l__ctlabreport_info_date_tl}
  \fancyhead[R]     { \small Version: \l__ctlabreport_info_version_tl \\ Page \, \thepage \, of \, \pageref{LastPage} }
  \fancyfoot[C]     { }
  \fancyfoot[L,R]   { }
  \headheight   = 13 pt 
\fancypagestyle{plain} 
  {
    \fancyhf        { }
    \fancyfoot[C]   { }
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
\tl_new:N \g__ctlabreport_font_EN_tl
\tl_new:N \g__ctlabreport_font_math_tl
\keys_define:nn { ctlabreport / style }
  {
    fontEN      .choices:nn =
      { times, lm, default }
      { \tl_set_eq:NN \g__ctlabreport_font_EN_tl \l_keys_choice_tl },
    fontMath    .choices:nn =
      { times, lm, default }
      { \tl_set_eq:NN \g__ctlabreport_font_math_tl \l_keys_choice_tl },
  }
\cs_new_eq:NN \__ctlabreport_set_family:nnn \xeCJK_set_family:nnn
\cs_new_eq:NN \__ctlabreport_switch_family:n \xeCJK_switch_family:n
\cs_new_protected:Npn \ctlabreport@kai
  { \__ctlabreport_switch_family:n { ctlabreport@kai } }
\cs_new_protected:Npn \__ctlabreport_setmainfont:nn #1#2
  { \__fontspec_main_setmainfont:nn {#2} {#1} }
\cs_new_protected:Npn \__ctlabreport_setsansfont:nn #1#2
  { \__fontspec_main_setsansfont:nn {#2} {#1} }
\cs_new_protected:Npn \__ctlabreport_setmonofont:nn #1#2
  { \__fontspec_main_setmonofont:nn {#2} {#1} }
\cs_new_protected:Npn \__ctlabreport_setmathfont:nn #1#2
  { \__um_setmathfont:nn {#2} {#1} }

\tl_new:N \g__ctlabreport_font_family_xits_tl
\tl_new:N \g__ctlabreport_font_style_xits_rm_tl
\tl_new:N \g__ctlabreport_font_style_xits_bf_tl
\tl_new:N \g__ctlabreport_font_style_xits_it_tl
\tl_new:N \g__ctlabreport_font_style_xits_bfit_tl
\tl_new:N \g__ctlabreport_font_name_xits_tl
\tl_new:N \g__ctlabreport_font_name_xits_math_rm_tl
\tl_new:N \g__ctlabreport_font_name_xits_math_bf_tl
\fontspec_font_if_exist:nTF { XITS-Regular.otf }
  {
    \tl_set:Nn \g__ctlabreport_font_family_xits_tl        { XITS             }
    \tl_set:Nn \g__ctlabreport_font_style_xits_rm_tl      { Regular          }
    \tl_set:Nn \g__ctlabreport_font_style_xits_bf_tl      { Bold             }
    \tl_set:Nn \g__ctlabreport_font_style_xits_it_tl      { Italic           }
    \tl_set:Nn \g__ctlabreport_font_style_xits_bfit_tl    { BoldItalic       }
    \tl_set:Nn \g__ctlabreport_font_name_xits_math_rm_tl  { XITSMath-Regular }
    \tl_set:Nn \g__ctlabreport_font_name_xits_math_bf_tl  { XITSMath-Bold    }
  }
  {
    \tl_set:Nn \g__ctlabreport_font_family_xits_tl        { xits          }
    \tl_set:Nn \g__ctlabreport_font_style_xits_rm_tl      { regular       }
    \tl_set:Nn \g__ctlabreport_font_style_xits_bf_tl      { bold          }
    \tl_set:Nn \g__ctlabreport_font_style_xits_it_tl      { italic        }
    \tl_set:Nn \g__ctlabreport_font_style_xits_bfit_tl    { bolditalic    }
    \tl_set:Nn \g__ctlabreport_font_name_xits_math_rm_tl  { xits-math     }
    \tl_set:Nn \g__ctlabreport_font_name_xits_math_bf_tl  { xits-mathbold }
  }

\cs_new_protected:Npn \__ctlabreport_load_fontEN_lm:  { }
\cs_new_protected:Npn \__ctlabreport_load_fontEN_times:
  {
    \__ctlabreport_setmainfont:nn { Times~ New~ Roman } { }
    \__ctlabreport_setsansfont:nn { Arial             } { }
    \__ctlabreport_setmonofont:nn { Courier~ New      } { }
  }
\cs_new_protected:Npn \__ctlabreport_load_fontMath_lm:
  { \__ctlabreport_setmathfont:nn { latinmodern-math.otf } { } }
\cs_new_protected:Npn \__ctlabreport_load_fontMath_times:
  { 
    \__ctlabreport_setmathfont:nn { \g__ctlabreport_font_name_xits_math_rm_tl .otf }
      { BoldFont = \g__ctlabreport_font_name_xits_math_bf_tl .otf }
  }
\cs_new_protected:Npn \__ctlabreport_load_font:
  {
    \use:c { __ctlabreport_load_fontEN_ \g__ctlabreport_font_EN_tl : }
    \use:c { __ctlabreport_load_fontMath_ \g__ctlabreport_font_math_tl : }
  }
\ctex_at_end_preamble:n { \__ctlabreport_load_font: }

\keys_set:nn { unicode-math }
  {
    math-style = ISO,
    bold-style = ISO,
  }
\keys_set:nn { ctlabreport / style } 
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
\keys_define:nn { ctlabreport }
  {
    info    .meta:nn = { ctlabreport / info } {#1},
    style   .meta:nn = { ctlabreport / style } {#1},
  }
\DeclareDocumentCommand \ctlabreportSetup { m } 
  { \keys_set:nn { ctlabreport } { #1 } }

% 制作标题
\AtBeginDocument
  {
    \setcounter{page}{0}
    \vspace*{4cm}
    \thispagestyle{plain}
    \begin{center}
      \zihao{1} \l__ctlabreport_info_projectName_tl
      \par
      \zihao{1} 软件测试说明书
    \end{center}
    \vspace{8cm}
    \begin{center}
      \zihao{3} 作者：\l__ctlabreport_info_authorName_tl
      \par
      \zihao{3} 版本：\l__ctlabreport_info_version_tl
      \par
      \zihao{3} 日期：\l__ctlabreport_info_date_tl
    \end{center}
    \newpage
  }
