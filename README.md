# hexo-matery-template

> docker 一键部署 Hexo 博客 : matery 主题

------

## 0x00 简介

还在头疼 Github Pages 部署个人博客？

本仓库提供 极简！快速！的 [Hexo](https://hexo.io/zh-cn/) 部署方式 ~ 让你专注于内容本身 ！

优点：

- docker 一键部署
- 预设优化后的 [matery](https://github.com/blinkfox/hexo-theme-matery) 主题，支持定制
- 预设流水线部署
- 支持 [Github](https://github.com/) 和 [Gitee](https://gitee.com/) 国内外双线同时部署

![效果图](./imgs/01.jpg)


## 0x10 环境说明

![](https://img.shields.io/badge/windows-blue.svg) ![](https://img.shields.io/badge/mac-green.svg) ![](https://img.shields.io/badge/linux-red.svg)

![](https://img.shields.io/badge/hexo%20x5.1.1-blue.svg) ![](https://img.shields.io/badge/matery%20x2.0.0-red.svg)


## 0x20 部署说明

### 0x21 准备工作

1. 安装 git、 docker、 docker-compose
2. Fork 这个仓库，用它作为**模板**创建你的仓库（**如果不想泄露文章源码，可私有**）
3. 在 Github/Gitee 分别创建一个**公开的空仓库**，并启用 Pages 服务，用于之后接收 hexo 所发布的内容
4. 配置 SSH 访问 Github 仓库，详见 《[connecting-to-github-with-ssh](https://help.github.com/en/articles/connecting-to-github-with-ssh)》 （Gitee 可以使用同一套密钥，配置方式是一样的）


### 0x22 常用功能

1. 文章目录: `volumes/hexo/source/_posts`
2. hexo 基本配置: `volumes/hexo/_config.yml`
3. matery 主题个性化配置: `volumes/hexo/themes/hexo-theme-matery/_config.yml`
4. matery 主题个性化资源: `volumes/hexo/themes/hexo-theme-matery/_config.yml`


### 0x23 本地调试

1. 运行环境: `bin/run.sh|ps1` （仅一次）
2. 按需重复执行: 
    - 构建 hexo 内容: `hexo/generate.sh|ps1`
    - 运行 hexo 网站: `hexo/run.sh|ps1`
    - 查看效果: [http://127.0.0.1:4000](http://127.0.0.1:4000)
3. 进入环境终端: `bin/terminal.sh|ps1` （按需）
4. 停止环境: `bin/stop.sh|ps1` （按需）


<details>
<summary>运行环境的完整命令参数</summary>
<br/>

实际上，运行环境的完整命令为: `bin/run.sh|ps1 -d ${SITE_DOMAIN} -u ${GIT_USER} -m ${GIT_MAIL} -n ${DEPLOY_REPO_NAME} -o ${DEPLOY_REPO_OWNER}`

其中：

- SITE_DOMAIN: 站点域名, 亦可使用 github/gitee 的 pages 域名，本地默认为 `127.0.0.1:4000`
- GIT_MAIL: git 命令的 mail 参数
- GIT_USER: git 命令的 user 参数
- DEPLOY_REPO_NAME: 用于接收发布内容的 github/gitee 仓库名称
- DEPLOY_REPO_OWNER: 该仓库的拥有者/组织

一般而言，这些都是线上部署才用到的参数，本地无需关注。

但是如果想在本地发布到 Github/Gitee 仓库，就可以使用完整命令运行 hexo 环境，例如：

- 运行环境: `bin/run.sh -d exp-blog.com -u EXP -m 289065406@qq.com -n articles -o lyy289065406`
- 构建 hexo 内容: `hexo/generate.sh|ps1`
- 发布 hexo 内容到 Github/Gitee 的目标仓库: `hexo/deploy.sh|ps1`

</details>


### 0x24 线上部署

线上环境通过 Github Actions 流水线自动发布。

流水线已经配置到 [.github/workflows] 里面了，无需修改，只需要添加流水线变量即可。

配置入口在 `Settings -> Secrets and variables -> Actions`。

------

选择 Secrets 标签，点击 New repository secret 按钮，添加密码变量: 

- `DEPLOY_PRIVATE_KEY`: 内容为之前为例配置 SSH 访问仓库时、所生成的密钥对的私钥内容，格式形如 `-----BEGIN OPENSSH PRIVATE KEY----- xxxxxxxx`
- `_GITEE_USER`: Gitee 的登录账号
- `_GITEE_PASS`: Gitee 的登录密码

> Gitee Pages 不会在提交仓库内容后刷新，流水线会用爬虫接口刷新，所以需要登录账密

![效果图](./imgs/02.jpg)

------

选择 Variables 标签，点击 New repository variables 按钮，添加密码变量: 

| 变量 | 说明 | 示例 |
|:---:|:---|:---:|
| `_GITHUB_DOMAIN` | Github Pages 的域名，可以使用 CNAME 解析的自定义域名 | `exp-blog.com` |
| `_GITHUB_DEPLOY_REPO_NAME` |  接收 hexo 内容的 Github 仓库 | `articles` |
| `_GITHUB_DEPLOY_REPO_OWNER` | 该 Github 的归属者或组织 | `lyy289065406` |
| `_GITEE_DOMAIN` | Gitee Pages 的域名，可以使用 CNAME 解析的自定义域名 | `exppoc.gitee.io` |
| `_GITEE_DEPLOY_REPO_NAME` | 接收 hexo 内容的 Gitee 仓库 | `articles` |
| `_GITEE_DEPLOY_REPO_OWNER` | 该 Gitee 的归属者或组织 | `exppoc` |
| `_GIT_MAIL` | git 命令的 mail 参数 | `289065406@qq.com` |
| `_GIT_USER` | git 命令的 user 参数 | `EXP` |
| `RUN_TIMEOUT` | 流水线的运行限制时长（秒） | `1200` |

`RUN_TIMEOUT` 第一次可以先设置为 0（表示不限制流水线执行时长），然后根据第一次流水线的执行时长设置稍大一点的超时时间。

之所以要限制超时，是因为流水线内的 docker in docker 命令是通过一个死循环监听是否结束的，由于该命令是网络交互的，异常情况下可能耗时极长。

而 Github Actions 每个月的免费额度只有 2000 分钟，故设置超时是为了避免浪费免费额度。

> hexo 构建时长是和文章数量相关，假如某一天超时时间不够用来构建，需要手动上调 `RUN_TIMEOUT`。

![效果图](./imgs/03.jpg)


## 0x30 镜像更新


拉取最新镜像: `docker pull expm02/hexo-matery-docker:latest`


## 0x40 仓库目录说明

```
hexo-matery-docker
├── LICENSE
├── imgs
├── AboutFrontMatter.md .................. [hexo 文章头部格式说明]
├── README.md ............................ [此仓库说明]
├── bin .................................. [镜像命令脚本]
│   ├── run.sh/ps1 ....................... [运行 hexo 的 docker 环境]
│   ├── terminal.sh/ps1 .................. [进入 hexo 的 docker 环境终端]
│   └── stop.sh/ps1 ...................... [停止 hexo 的 docker 环境]
├── hexo ................................. [hexo 命令脚本]
│   ├── check_flag.sh .................... [检查容器内的命令是否执行结束]
│   ├── generate.sh/ps1 .................. [构建 hexo 的内容]
│   ├── deploy.sh/ps1 .................... [发布 hexo 的内容（生产环境）]
│   ├── generate_deploy.sh/ps1 ........... [构建并发布 hexo 的内容（生产环境）]
│   ├── run.sh/ps1 ....................... [运行 hexo 的服务（开发环境）]
│   └── to_sha256.sh/ps1 ................. [生成文章 SHA256 密钥脚本]
├── docker-compose.yml ................... [docker 服务编排剧本]
└── volumes .............................. [数据卷目录，存储文章和主题源码，切勿丢失]
    └── hexo ............................. [Hexo 主目录]
        ├── scaffolds .................... [模板目录]
        ├── source ....................... [Markdown 文章源码目录]
        │   ├── _data .................... [可被 Hexo/主题/插件 引用的公共数据目录]
        │   ├── _draft ................... [草稿目录（不会发布）]
        │   ├── _posts ................... [文章/资源目录]
        │   ├── about .................... [关于页面]
        │   ├── categories ............... [分类页面]
        │   ├── contact .................. [解锁指引页面]
        │   ├── download ................. [存储本地下载资源的目录]
        │   ├── friends .................. [友情链接页面]
        │   ├── images ................... [可被文章引用的公共图片目录]
        │   ├── tags ..................... [标签页面]
        │   ├── .nojekyll ................ [声明禁止使用 jekyll 生成内容]
        │   ├── 404.md ................... [404 页面]
        │   ├── ads.txt .................. [授权 Google Adsense 的广告文件]
        │   ├── robots.txt ............... [声明搜索引擎爬取内容行为的文件]
        │   ├── LICENSE
        │   └── README.md
        ├── _config.yml .................. [hexo 配置文件]
        └── themes ....................... [主题目录]
            └── hexo-theme-matery
                ├── _config.yml .......... [主题配置文件]
                └── source
                    ├── favicon.png
                    └── medias ........... [主题资源目录]
```
