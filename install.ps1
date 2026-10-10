# Cài plugin Salekit cho Claude Code (Windows PowerShell).
# Dùng: irm https://raw.githubusercontent.com/partner-salemall/salekit_mcp_plugin/main/install.ps1 | iex

$ErrorActionPreference = 'Continue'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$repo = 'partner-salemall/salekit_mcp_plugin'
$server = 'plugin:salekit:salekit'

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host 'Chưa có Claude Code. Đang cài...'
    Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
    $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
    if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
        Write-Host 'Cài xong nhưng chưa tìm thấy lệnh claude. Mở cửa sổ PowerShell mới rồi chạy lại lệnh cài Salekit.'
        return
    }
}

# `claude mcp login` cần Claude Code đủ mới.
claude mcp login --help *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Host 'Claude Code quá cũ, đang cập nhật...'
    claude update
    claude mcp login --help *> $null
    if ($LASTEXITCODE -ne 0) {
        Write-Host 'Không cập nhật được Claude Code. Cài bằng npm thì chạy: npm install -g @anthropic-ai/claude-code@latest'
        return
    }
}

Write-Host 'Đang thêm marketplace Salekit...'
claude plugin marketplace add $repo *> $null
if ($LASTEXITCODE -ne 0) { claude plugin marketplace update salekit }

Write-Host 'Đang cài plugin...'
claude plugin install salekit@salekit

# Server cùng tên tạo thủ công trước đây sẽ trùng với plugin.
claude mcp get salekit *> $null
if ($LASTEXITCODE -eq 0) { claude mcp remove salekit *> $null }

Write-Host ''
Write-Host 'Đang mở trang đăng nhập Salekit. Đăng nhập, chọn shop rồi bấm "Cho phép".'
claude mcp login $server

Write-Host ''
Write-Host 'Xong. Mở Claude Code (lệnh: claude) và hỏi thử: "Dùng Salekit báo cáo bán hàng 7 ngày qua"'
