# Salekit cho Claude

Plugin chính thức kết nối Claude Code và Claude Cowork với Salekit: đơn hàng, khách hàng, doanh thu, kho, affiliate và workflow. Đăng nhập bằng tài khoản Salekit qua OAuth, không cần copy token.

## Cài đặt

```
claude plugin marketplace add partner-salemall/salekit_mcp_plugin
claude plugin install salekit@salekit
```

## Đăng nhập

```
claude mcp login plugin:salekit:salekit
```

Trình duyệt sẽ mở trang đăng nhập Salekit. Đăng nhập, chọn shop, bấm **Cho phép**. Terminal báo `Authenticated with "plugin:salekit:salekit"` là xong.

Cách khác: trong Claude Code gõ `/mcp`, chọn `salekit`, chọn **Authenticate**.

Sau khi đăng nhập, mở **phiên mới** (New session) rồi hỏi, ví dụ:

- "Dùng Salekit báo cáo bán hàng 7 ngày qua"
- "Khách nào đang còn nợ tiền?"
- "Sản phẩm nào ở kho chính sắp hết hàng?"

## Cập nhật

```
claude plugin marketplace update salekit
claude plugin update salekit@salekit
```

## Gỡ cài đặt

```
claude plugin uninstall salekit@salekit
```

Thu hồi quyền truy cập: Salekit → Cài đặt → Ứng dụng đã kết nối.

## Cấu trúc repo

```
.claude-plugin/marketplace.json      Danh mục plugin (marketplace "salekit")
plugins/salekit/
  .claude-plugin/plugin.json         Thông tin plugin
  .mcp.json                          Trỏ tới https://api.salekit.com/mcp
  skills/salekit-co-ban/             Quy tắc dùng Salekit
  skills/bao-cao-ban-hang/           Báo cáo bán hàng
  skills/cham-soc-khach-hang/        Chăm sóc khách hàng
  scripts/login-salekit.sh|.ps1      Script đăng nhập
docs/claude-install.md               Hướng dẫn cài đặt cho AI đọc
```
