#!/bin/sh
# Đăng nhập Salekit cho plugin (macOS / Linux / WSL).
# Mở trình duyệt tới trang xác minh tài khoản Salekit qua OAuth.
# Yêu cầu Claude Code có lệnh `claude mcp login`.

if ! command -v claude >/dev/null 2>&1; then
  echo "Không tìm thấy lệnh 'claude'. Cài Claude Code trước: https://claude.ai/install.sh"
  exit 1
fi

# `claude mcp login` cần terminal thật (TTY). Nếu chạy nền thì bọc bằng python pty.
if [ -t 0 ]; then
  claude mcp login plugin:salekit:salekit
elif command -v python3 >/dev/null 2>&1; then
  python3 -c 'import pty,sys; pty.spawn(sys.argv[1:])' claude mcp login plugin:salekit:salekit
else
  case "$(uname -s)" in
    Darwin) script -q /dev/null claude mcp login plugin:salekit:salekit ;;
    *)      script -qc "claude mcp login plugin:salekit:salekit" /dev/null ;;
  esac
fi
