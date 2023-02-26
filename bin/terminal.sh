#!/bin/bash
#------------------------------------------------
# 进入容器的交互终端
# 示例: bin/terminal.sh
#------------------------------------------------


CONTAINER_NAME="hexo-matery"
CONTAINER_ID=`docker ps -aq --filter name="$CONTAINER_NAME"`
if [[ "${CONTAINER_ID}x" = "x" ]] ; then
    echo "[$CONTAINER_NAME] is not running ..."
else
    docker exec -it $CONTAINER_ID bash
fi
