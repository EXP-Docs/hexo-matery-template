# PowerShell
#------------------------------------------------
# 发布 hexo 页面到 Github 仓库
# 示例: bin/deploy.ps1
#           -d [ON/OFF]         使用后台模式启动（默认是前台模式）
#------------------------------------------------

param([string]$d="OFF")

$MODE = "-it"
if(![String]::IsNullOrEmpty($f) -and ("ON" -eq $d)) {
    $MODE = "-d"
}


$CONTAINER_NAME = "hexo-matery"
$CONTAINER_ID = (docker ps -aq --filter name="$CONTAINER_NAME")
if([String]::IsNullOrEmpty($CONTAINER_ID)) {
    Write-Host "[$CONTAINER_NAME] is not running ..."
} else {
    docker exec ${MODE} ${CONTAINER_ID} bash -c "cd /hexo && hexo d"
}
