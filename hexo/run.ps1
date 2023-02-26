# PowerShell
#------------------------------------------------
# 运行 hexo 服务（一般用于开发环境调试）
# 示例: bin/run_svc.ps1 
#------------------------------------------------


$CONTAINER_NAME = "hexo-matery"
$CONTAINER_ID = (docker ps -aq --filter name="$CONTAINER_NAME")
if([String]::IsNullOrEmpty($CONTAINER_ID)) {
    Write-Host "[$CONTAINER_NAME] is not running ..."
} else {
    docker exec -it $CONTAINER_ID bash -c "cd /hexo && hexo s"
}
