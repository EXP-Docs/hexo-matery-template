#!/bin/bash
#------------------------------------------------
# 生成 hexo 页面
# 示例: hexo/generate_deploy.sh
#           -d [ON/OFF]         使用后台模式启动（默认是前台模式）
#------------------------------------------------

DETACH="OFF"

set -- `getopt d: "$@"`
while [ -n "$1" ]
do
  case "$1" in
    -d) DETACH="$2"
        shift ;;
  esac
  shift
done

MODE="-it"
if [[ "x${DETACH}" == "xON" ]] ; then
    MODE="-d"
fi

CONTAINER_NAME="hexo-matery"
CONTAINER_ID=`docker ps -aq --filter name="$CONTAINER_NAME"`
if [[ "${CONTAINER_ID}x" = "x" ]] ; then
    echo "[$CONTAINER_NAME] is not running ..."
else
    docker exec ${MODE} ${CONTAINER_ID} bash -c "cd /hexo && bin/regenerate.sh && hexo d && bin/flag.sh"
fi
