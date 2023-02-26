# PowerShell
#------------------------------------------------
# 进入容器的交互终端
# 示例: bin/terminal.ps1 
#------------------------------------------------


$CONTAINER_NAME = "hexo-matery"
$CONTAINER_ID = (docker ps -aq --filter name="$CONTAINER_NAME")
if([String]::IsNullOrEmpty($CONTAINER_ID)) {
    Write-Host "[$CONTAINER_NAME] is not running ..."
} else {
    docker exec -it $CONTAINER_ID bash
}
