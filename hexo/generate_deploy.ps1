# PowerShell
#------------------------------------------------
# ���� hexo ҳ��
# ʾ��: hexo/generate_deploy.ps1
#           -d [ON/OFF]         ʹ�ú�̨ģʽ������Ĭ����ǰ̨ģʽ��
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
    docker exec ${MODE} ${CONTAINER_ID} bash -c "cd /hexo && bin/regenerate.sh && hexo d"
}
