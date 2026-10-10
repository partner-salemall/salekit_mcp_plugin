# Plugin salekit

Kết nối Claude với MCP server Salekit tại `https://api.salekit.com/mcp` (streamable HTTP, xác thực OAuth 2.1 + PKCE).

Không cần biến môi trường hay token: Claude Code tự thực hiện OAuth khi chạy `claude mcp login plugin:salekit:salekit` hoặc khi người dùng chọn Authenticate trong `/mcp`.

## Skills

| Skill | Khi nào dùng |
|---|---|
| `salekit-co-ban` | Mọi yêu cầu liên quan Salekit: quy tắc tra id, tìm kiếm có dấu, trình bày, xác nhận trước khi ghi |
| `bao-cao-ban-hang` | Báo cáo doanh thu, so sánh kỳ trước, nguồn bán, tồn kho |
| `cham-soc-khach-hang` | Khách còn nợ, khách lâu không mua, soạn tin chăm sóc |

## Cài đặt

```
claude plugin marketplace add https://github.com/YOUR-ORG/salekit-claude-plugin.git#main
claude plugin install salekit@salekit
```
