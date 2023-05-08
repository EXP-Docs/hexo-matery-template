#!/bin/bash
#------------------------------------------------
# 运行 hexo 服务（一般用于开发环境调试）
# 示例: hexo/run_svc.sh
#------------------------------------------------


CONTAINER_NAME="hexo-matery"
CONTAINER_ID=`docker ps -aq --filter name="$CONTAINER_NAME"`
if [[ "${CONTAINER_ID}x" = "x" ]] ; then
    echo "[$CONTAINER_NAME] is not running ..."
else
    docker exec -it $CONTAINER_ID bash -c "cd /hexo && hexo s"
fi
