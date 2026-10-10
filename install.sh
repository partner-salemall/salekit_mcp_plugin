#!/bin/sh
# Cài plugin Salekit cho Claude Code (macOS / Linux / WSL).
# Dùng: curl -fsSL https://raw.githubusercontent.com/partner-salemall/salekit_mcp_plugin/main/install.sh | sh

set -e

REPO="partner-salemall/salekit_mcp_plugin"
SERVER="plugin:salekit:salekit"

if ! command -v claude >/dev/null 2>&1; then
  echo "Chưa có Claude Code. Đang cài..."
  curl -fsSL https://claude.ai/install.sh | bash
  export PATH="$HOME/.local/bin:$PATH"
fi

# `claude mcp login` cần Claude Code đủ mới.
if ! claude mcp login --help >/dev/null 2>&1; then
  echo "Claude Code quá cũ, đang cập nhật..."
  claude update || true
  if ! claude mcp login --help >/dev/null 2>&1; then
    echo "Không cập nhật được Claude Code. Cài bằng npm thì chạy: npm install -g @anthropic-ai/claude-code@latest"
    echo "Cài bằng Homebrew thì chạy: brew upgrade claude-code"
    exit 1
  fi
fi

echo "Đang thêm marketplace Salekit..."
claude plugin marketplace add "$REPO" 2>/dev/null || claude plugin marketplace update salekit

echo "Đang cài plugin..."
claude plugin install salekit@salekit

# Server cùng tên tạo thủ công trước đây sẽ trùng với plugin.
if claude mcp get salekit >/dev/null 2>&1; then
  claude mcp remove salekit >/dev/null 2>&1 || true
fi

echo ""
echo "Đang mở trang đăng nhập Salekit. Đăng nhập, chọn shop rồi bấm \"Cho phép\"."
# Khi chạy qua `curl | sh`, stdin là pipe; lấy lại bàn phím từ /dev/tty.
if [ -r /dev/tty ]; then
  claude mcp login "$SERVER" < /dev/tty
else
  claude mcp login "$SERVER"
fi

echo ""
echo "Xong. Mở Claude Code (lệnh: claude) và hỏi thử: \"Dùng Salekit báo cáo bán hàng 7 ngày qua\""
