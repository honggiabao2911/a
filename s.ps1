$d = 'C:\SysConfig'
md $d -Force | Out-Null
$n = 'SysLog','NetSec','DataVault','CoreAuth','WinAudit'
1..20 | ForEach-Object {
    $r = $n[(Get-Random -Max 5)] + $_
    $p = Join-Path $d $r
    md $p -Force | Out-Null
    'sys' | Out-File ($p + '\info.txt')
    'log' | Out-File ($p + '\config.dat')
}