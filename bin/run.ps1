# PowerShell
#------------------------------------------------
# 运行容器
# 示例: bin/run_env.ps1 
#   -s [svc_name]       docker-compose 中的服务名，不指定则启动所有服务
#   -f [ON/OFF]         使用前台模式启动（默认是后台模式）
#   -d [domain]         服务域名: 支持 域名、github子域名、IP端口（默认为 127.0.0.1:4000）
#   -m [GIT_MAIL]    使用 SSH 访问 Github 的用户邮箱
#   -u [GIT_USER]    使用 SSH 访问 Github 的用户账号
#   -n [repo_name]      发布 hexo 的目标 Github 仓库名
#   -o [repo_owner]     目标 Github 仓库的拥有者或组织
#------------------------------------------------

param(
    [string]$s="", 
    [string]$f="OFF", 
    [string]$d="127.0.0.1:4000", 
    [string]$m="289065406@qq.com", 
    [string]$u="lyy289065406", 
    [string]$n="articles", 
    [string]$o="lyy289065406"
)

$SVC = ""
if(![String]::IsNullOrEmpty($s)) {
    $SVC = $s
}

$MODE = "-d"
if(![String]::IsNullOrEmpty($f) -and ("ON" -eq $f)) {
    $MODE = ""
}


Write-Host "Going to start ..."
$ENV:SITE_DOMAIN=${d}; `
$ENV:GIT_MAIL=${m}; `
$ENV:GIT_USER=${u}; `
$ENV:DEPLOY_REPO_NAME=${n}; `
$ENV:DEPLOY_REPO_OWNER=${o}; `
docker-compose up ${MODE} ${SVC}
docker ps

Write-Host "App is running ..."
