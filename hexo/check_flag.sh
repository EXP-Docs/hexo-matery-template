#!/bin/bash
#-----------------------------------------------------------------
# 检查特定位置的特定标记文件内容是否为目标内容。
# 用于 docker 以后台模式执行命令时，宿主机通过检测此标记确认命令是否执行完成。
#-----------------------------------------------------------------
# 命令执行示例（此脚本在宿主机执行）：
#   hexo/check_flag.sh
#       -n [filename]       # flag 文件的名字
#       -c [content]        # 要检查 flag 文件的内容
#-----------------------------------------------------------------

FLAG_DIRPATH="./tmp/flag"   # flag 文件在宿主机中的目录，从 docker 内挂载出来
FLAG_FILENAME="flag.dat"
FLAG_CONTENT="flag"

set -- `getopt n:c "$@"`
while [ -n "$1" ]
do
  case "$1" in
    -n) FLAG_FILENAME="$2"
        shift ;;
    -c) FLAG_CONTENT="$2"
        shift ;;
  esac
  shift
done

FLAG_FILEPATH="${FLAG_DIRPATH}/${FLAG_FILENAME}"
while [[ ! -f "${FLAG_FILEPATH}" ]]; do
  echo "Command is running, waiting ..."
  sleep 10
done

contents=$(cat "${FLAG_FILEPATH}")
rm -f ${FLAG_FILEPATH}
if [[ "${contents}" == "${FLAG_CONTENT}" ]]; then
  echo "Command is done, and exits normally ."
  exit 0
else
  echo "Command is done, but exited abnormally ."
  exit 1
fi
