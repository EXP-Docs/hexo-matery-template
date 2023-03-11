# PowerShell
#------------------------------------------------
# 停止容器
# 示例: bin/stop.ps1
#------------------------------------------------

$ENV:SITE_PROTOCOL="any"; `
$ENV:SITE_DOMAIN="any"; `
$ENV:GIT_MAIL="any"; `
$ENV:GIT_USER="any"; `
$ENV:DEPLOY_REPO_NAME="any"; `
$ENV:DEPLOY_REPO_OWNER="any"; `
docker-compose down

docker ps
