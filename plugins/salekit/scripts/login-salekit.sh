#!/bin/sh
# Đăng nhập Salekit cho plugin (macOS / Linux / WSL).
# Mở trình duyệt tới trang xác minh tài khoản Salekit qua OAuth.
# Yêu cầu Claude Code có lệnh `claude mcp login`.

if ! command -v claude >/dev/null 2>&1; then
  echo "Không tìm thấy lệnh 'claude'. Cài Claude Code trước: https://claude.ai/install.sh"
  exit 1
fi

LOGIN="claude mcp login plugin:salekit:salekit"

# `claude mcp login` cần terminal thật (TTY). Chạy nền thì mở cửa sổ Terminal (macOS)
# hoặc bọc bằng pseudo-terminal.
if [ -t 0 ]; then
  $LOGIN
elif [ "$(uname -s)" = "Darwin" ]; then
  osascript -e "tell application \"Terminal\" to do script \"$LOGIN\"" -e 'tell application "Terminal" to activate'
  echo "Đã mở cửa sổ Terminal đăng nhập Salekit. Hoàn tất trên trình duyệt rồi đóng cửa sổ đó."
elif command -v python3 >/dev/null 2>&1; then
  python3 -c 'import pty,sys; pty.spawn(sys.argv[1:])' $LOGIN
else
  script -qc "$LOGIN" /dev/null
fi
