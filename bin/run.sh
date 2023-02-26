#!/bin/bash
#------------------------------------------------
# 运行容器
# 示例: bin/run_env.sh 
#   -s [svc_name]       docker-compose 中的服务名，不指定则启动所有服务
#   -f [ON/OFF]         使用前台模式启动（默认是后台模式）
#   -d [domain]         服务域名: 支持 域名、github子域名、IP端口（默认为 127.0.0.1:4000）
#   -m [GIT_MAIL]    使用 SSH 访问 Github 的用户邮箱
#   -u [GIT_USER]    使用 SSH 访问 Github 的用户账号
#   -n [repo_name]      发布 hexo 的目标 Github 仓库名
#   -o [repo_owner]     目标 Github 仓库的拥有者或组织
#------------------------------------------------

SVC=""
FRONT="OFF"

SITE_DOMAIN="127.0.0.1:4000"
GIT_MAIL="289065406@qq.com"
GIT_USER="lyy289065406"
DEPLOY_REPO_NAME="articles"
DEPLOY_REPO_OWNER="lyy289065406"


set -- `getopt s:f:d:m:u:n:o: "$@"`
while [ -n "$1" ]
do
  case "$1" in
    -s) SVC="$2"
        shift ;;
    -f) FRONT="$2"
        shift ;;
    -d) SITE_DOMAIN="$2"
        shift ;;
    -m) GIT_MAIL="$2"
        shift ;;
    -u) GIT_USER="$2"
        shift ;;
    -n) DEPLOY_REPO_NAME="$2"
        shift ;;
    -o) DEPLOY_REPO_OWNER="$2"
        shift ;;
  esac
  shift
done

MODE="-d"
if [[ "x${FRONT}" = "xON" ]] ; then
    MODE=""
fi

echo "Going to start ..."
SITE_DOMAIN=${SITE_DOMAIN} \
GIT_MAIL=${GIT_MAIL} \
GIT_USER=${GIT_USER} \
DEPLOY_REPO_NAME=${DEPLOY_REPO_NAME} \
DEPLOY_REPO_OWNER=${DEPLOY_REPO_OWNER} \
docker-compose up ${MODE} ${SVC}
docker ps

echo "App is running ..."