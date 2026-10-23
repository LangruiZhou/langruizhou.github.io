# Langrui Zhou 的个人主页

网站地址：<https://langruizhou.github.io/>

主页使用 Jekyll 生成。**日常需要手动更新的文字和信息全部集中在 `_data/` 文件夹**，修改内容时不需要编辑 HTML 或 CSS。

## 项目结构

```text
_data/                    # 日常内容更新入口
├── profile.yml           # 姓名、身份、学校、头像路径、邮箱和个人链接
├── biography.yml         # 个人简介，支持 Markdown
├── news.yml              # 新闻和动态，支持 Markdown
├── publications.yml      # 所有已发表及在审论文
└── services.yml          # 学术服务
_includes/                # 各个内容模块的展示模板
_layouts/default.html     # 整体页面框架
assets/css/jemdoc.css     # 字体、颜色、间距和手机端布局
larry.png                 # 当前使用的头像图片，以轻微圆角的矩形展示
index.html                # 首页入口，只负责组合展示模块
_config.yml               # Jekyll 构建设置，日常无需修改
Gemfile                   # 本地预览依赖，日常无需修改
preview.command           # macOS 双击启动预览
```

`_data/` 是 Jekyll 原生支持的数据目录，模板通过 `site.data` 读取 YAML。它借鉴了 [Academic Pages](https://github.com/academicpages/academicpages.github.io) 的内容与展示分离方式，使用适合这个单页主页的精简结构。参考：[Jekyll 数据文件文档](https://jekyllrb.com/docs/datafiles/)。

## 更新内容

所有 `.yml` 文件使用 UTF-8 和空格缩进（不要使用 Tab），同一级字段保持对齐。建议给文字、日期和链接加双引号；文字内的双引号写成 `\"`。

### 个人信息和简介

在 `_data/profile.yml` 中修改基本信息；学校和个人链接支持继续添加列表项。头像图片放在项目中，在 `avatar` 中填写以 `/` 开头的站内路径。

在 `_data/biography.yml` 的 `text` 下写简介，保持两格缩进。`>-` 允许将一个段落拆成多行编写；空一行可分成新段落。支持 `*斜体*`、`**粗体**` 和 `[链接文字](https://example.com)`，无需写 HTML。

### 添加新闻

在 `_data/news.yml` 的 `items` 顶部添加一条：

```yaml
  - date: "10/2026"
    tag: paper
    text: "Noise2Match is accepted by *IEEE TMI*."
```

新闻按文件中的顺序显示。`text` 支持与简介相同的 Markdown 语法。页面上的 News 列表高度约容纳六条单行消息，超过后可在列表区域内滚动查看，标题保持在区域外。

`tag` 为可选字段，每条消息可选一个分类：`paper`（论文，淡蓝色）、`award`（获奖，淡黄色）或 `service`（学术服务，淡绿色）。页面会在日期后显示对应的大写标签；省略 `tag` 则不显示标签。

### 添加论文

所有论文都在 `_data/publications.yml` 的 `items` 中，每篇论文填写一次：

页面依次展示黑色加粗标题、灰色作者、期刊或会议名称与相关链接。第三行使用 `/` 分隔期刊和链接；在审论文没有期刊或链接时省略该行。

```yaml
  - title: "论文完整标题"
    status: published
    year: 2026
    authors: ["Langrui Zhou", "Author Two"]
    corresponding_authors: ["Author Two"]
    venue: "期刊或会议名称"
    links:
      - label: "paper"
        url: "https://example.com/paper"
      - label: "code"
        url: "https://github.com/example/project"
```

- `status` 使用 `published` 或 `under_review`。在审论文可省略 `year` 和 `venue`。
- `year` 使用不加引号的整数；已发表论文会按年份倒序分组，同一分组内保留文件顺序。
- `authors` 按署名顺序填写；通讯作者在 `corresponding_authors` 中重复填写完整姓名，页面会自动添加上标 `*`。没有通讯作者标记时可以省略该字段。
- `venue` 只填期刊或会议名称，页面会自动追加年份。
- `links` 可省略，也可以增加任意数量的链接，标签例如 `paper`、`code`、`dataset`。`label` 的大小写按填写内容原样显示，例如 `GitHub`、`PDF`、`arXiv`。
- 论文接收后，将 `status` 改为 `published`，补上年份和期刊，无需再移动文件或调整 HTML。

### 更新学术服务

修改 `_data/services.yml`。`groups` 中每组对应一个小标题，组内的 `items` 保存条目。`url` 可省略，省略时只显示文字。

### 隐藏暂时不需要的模块

将新闻或论文的 `items` 改成 `[]`，服务的 `groups` 改成 `[]`，或将简介的 `text` 改成 `""`，对应模块便会隐藏。

## 本地预览

### macOS：双击启动

1. 在访达中打开项目文件夹，双击 `preview.command`。
2. 等待浏览器自动打开主页。首次运行会自动安装依赖，需要联网，之后无需重复安装。
3. 修改 `_data/` 中的内容并保存，预览页面会自动刷新。

预览时保留启动的终端窗口，结束时在该窗口按 **Control+C**。如果浏览器未自动打开，访问 <http://127.0.0.1:4000>。

启动器将依赖安装在项目的 `vendor/` 目录中，不需要 `sudo`，也不会提交到 GitHub。它使用本机 Ruby；当前这台 Mac 已完成依赖准备和启动验证。

### 手动启动（可选）

也可以在项目根目录运行同一个启动器：

```sh
./preview.command
```

如果已经自行安装 Ruby 和 Bundler，也可以直接使用标准 Jekyll 命令：

```sh
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve
```

使用标准命令启动时，修改 `_data/` 后 Jekyll 会重新生成页面，刷新浏览器即可。不要直接双击 `index.html`，其中的模板语法需要经过 Jekyll 构建。修改 `_config.yml` 后需要重启预览服务。

只生成静态文件时运行：

```sh
bundle exec jekyll build --strict_front_matter
```

输出目录为 `_site/`，不需要手动修改或提交。

## 发布到 GitHub Pages

将更改提交并推送到 GitHub。如果仓库 Pages 的 Source 为 **Deploy from a branch**，选择存放源码的分支和 `/ (root)` 目录，GitHub Pages 会通过 Jekyll 构建这个项目。

如果使用 **GitHub Actions** 发布，则现有工作流需要先执行 Jekyll 构建，再发布 `_site/`，不能直接将源码目录作为静态网页上传。当前项目未配置自定义 Actions 工作流。

日常只需修改 `_data/` 并提交；网页设计变更则修改 `_layouts/`、`_includes/` 和 `assets/css/`。
