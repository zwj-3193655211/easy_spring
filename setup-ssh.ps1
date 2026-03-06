# SSH配置脚本 - 配置无密码SSH密钥
Write-Host "正在配置SSH使用无密码密钥..." -ForegroundColor Green

$sshConfigPath = "C:\Users\31936\.ssh\config"
$sshConfigContent = @"
Host github.com
    HostName github.com
    User git
    IdentityFile C:\Users\31936\.ssh\id_temp
    IdentitiesOnly yes
"@

# 创建SSH配置文件
Set-Content -Path $sshConfigPath -Value $sshConfigContent -Encoding utf8

Write-Host "SSH配置文件已创建: $sshConfigPath" -ForegroundColor Green
Write-Host "现在Git将自动使用无密码密钥连接GitHub" -ForegroundColor Yellow

# 测试连接
Write-Host "`n测试SSH连接..." -ForegroundColor Cyan
$testResult = ssh -T git@github.com 2>&1
if ($testResult -match "successfully authenticated") {
    Write-Host "SSH连接测试成功！" -ForegroundColor Green
} else {
    Write-Host "SSH连接测试失败" -ForegroundColor Red
}

Write-Host "`n配置完成！现在你可以直接使用 git push 命令，无需输入密码。" -ForegroundColor Green
