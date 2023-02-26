#!/bin/bash
# ----------------------

GIT_MAIL=${GIT_MAIL:-"289065406@qq.com"}      # Github 邮箱
GIT_USER=${GIT_USER:-"EXP"}                   # Github 账号


# 配置 Github
git config --global user.email "${GIT_MAIL}"
git config --global user.name "${GIT_USER}"


# 因挂载 id_rsa 时默认权限为 777，会导致 ssh 安全检测异常连接失败，故追加 chmod 400 命令
chmod 400 /root/.ssh/id_rsa


# 维持镜像环境运行
/wrapper.sh
