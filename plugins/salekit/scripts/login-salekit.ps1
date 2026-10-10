# Đăng nhập Salekit cho plugin (Windows PowerShell).
# Mở trình duyệt tới trang xác minh tài khoản Salekit qua OAuth.

$claude = (Get-Command claude -ErrorAction SilentlyContinue).Source
if (-not $claude) {
    Write-Host "Không tìm thấy lệnh 'claude'. Cài Claude Code trước: irm https://claude.ai/install.ps1 | iex"
    exit 1
}

& $claude mcp login plugin:salekit:salekit
