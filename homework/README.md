# LaTeX homework 模板
## 内容
`labreport.cls`。
## 使用方法
直接将其放入文档的根目录，随后在待编译的 `.tex` 的导言区内导入文档类

`\documentclass{homework}`

注意：使用本模版后只可以用 XeTeX 编译。
## 设置方法
### 设置格式
本模版使用 Key-Value 方式来填写信息、设置字体。具体设置内容如下所示。

```
\labreportSetup
  {
    info = {
      ...
    }, 
    style = {
      ...
    }
  }
```

### `info`设置

- `courseName    = {<课程名称>},`，在花括号内填入课程名称；
- `teacherName   = {<指导教师>},`，在花括号内填入指导教师；
- `studentID     = {<学号>},`，在花括号内填入学号；
- `name          = {<姓名>},`，在花括号内填入姓名；
- `homeworkIndex = {<作业序号>},`，在花括号内填入作业序号。

### `style` 设置
- `fontEN = lm | times | default,` ，英语字体选项，选项意思依次为 Latin Modern，Times，以及默认（选择默认时为 `times`）；
- `fontMath = lm | times | default,`，数学字体选项，选项意思依次为 Latin Modern，Times，以及默认（选择默认时为 `lm`）。

## 可选功能
本模板添加了三个命令：
```
\Section[<标题正文>]{<标题序号>}
\Subsection[<标题正文>]{<标题序号>}
\Subsubsection[<标题正文>]{<标题序号>}
```
可以用来临时更改一个标题的序号。

该命令同样会使计数器 `section`、`subsection` 或 `subsubsection` 递增。

## 文档中使用的宏包
- geometry
- amsmath
- amssymb
- unicode-math
- xcolor
- listings
- caption
- graphicx
- fancyhdr
- lastpage
- enumitem

## 关于
本模板由 Koyamin 的[华东师范大学计算机科学与技术系实验报告](https://github.com/Koyamin/labreport-cs)改编。