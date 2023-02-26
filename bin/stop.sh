#!/bin/bash
#------------------------------------------------
# 停止容器
# 示例: bin/stop.sh
#------------------------------------------------

SITE_DOMAIN="any" \
GIT_MAIL="any" \
GIT_USER="any" \
DEPLOY_REPO_NAME="any" \
DEPLOY_REPO_OWNER="any" \
docker-compose down

docker ps
