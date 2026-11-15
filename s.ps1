$d = 'C:\SysConfig'
md $d -Force | Out-Null
$n = 'SysLog','NetSec','DataVault','CoreAuth','WinAudit'

# 1. Tạo 20 thư mục và file bên trong
1..20 | ForEach-Object {
    $r = $n[(Get-Random -Max 5)] + $_
    $p = Join-Path $d $r
    md $p -Force | Out-Null
    'sys' | Out-File ($p + '\info.txt')
    'log' | Out-File ($p + '\config.dat')
}

# 2. Tạo 15 file .log rác ở thư mục gốc
1..15 | ForEach-Object {
    $logName = "system_log_" + (Get-Random -Maximum 9999) + ".log"
    $logPath = Join-Path $d $logName
    "Initializing system services... OK" | Out-File $logPath
    "Loading kernel modules... OK" | Out-File $logPath -Append
}

# 3. Tạo 10 file .exe rác (chỉ là file text đổi đuôi để tạo nhiễu)
1..10 | ForEach-Object {
    $exeName = "setup_" + (Get-Random -Maximum 999) + ".exe"
    $exePath = Join-Path $d $exeName
    "This program cannot be run in DOS mode." | Out-File $exePath
}