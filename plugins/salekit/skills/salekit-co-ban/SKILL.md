---
name: salekit-co-ban
description: >
  Quy tắc nền tảng khi làm việc với Salekit qua MCP. Dùng skill này bất cứ khi nào
  người dùng nhắc tới Salekit, shop, đơn hàng, khách hàng, sản phẩm, tồn kho, doanh thu,
  affiliate, CTV, funnel, sequence hoặc workflow, ví dụ "xem đơn hôm nay",
  "tìm khách số 09...", "doanh thu tháng này", "dùng Salekit để...".
metadata:
  version: "0.1.0"
---

# Làm việc với Salekit

## Kiểm tra kết nối trước

- Gọi `get_current_shop` ở lần dùng đầu tiên trong phiên để biết đang thao tác shop nào, rồi nêu tên shop cho người dùng.
- Nếu công cụ báo lỗi xác thực (401, thiếu token, token hết hạn), hướng dẫn người dùng chạy `/mcp`, chọn `salekit` rồi chọn **Authenticate**, hoặc chạy script `${CLAUDE_PLUGIN_ROOT}/scripts/login-salekit.sh` (Windows: `login-salekit.ps1`). Không yêu cầu người dùng dán token vào chat.

## Quy tắc tra cứu

- Không tự đoán id. Lấy id kênh bán bằng `get_channels`, id kho bằng `get_warehouses`, id khách bằng `search_customers` / `get_customers`, id đơn bằng `get_orders`.
- Tìm kiếm tên trong Salekit có thể bỏ qua dấu tiếng Việt ("áo" có thể khớp "ảo"). Sau khi tìm, lọc lại kết quả theo đúng chữ có dấu và báo cho người dùng nếu kết quả lẫn mục không liên quan.
- Với danh sách dài, dùng `limit` và `page`; dùng `totalCount` khi báo tổng số, không tự đếm từ một trang.
- Ưu tiên công cụ tổng hợp (`summarize_shop`, `summarize_sales`, `summarize_customer`) khi người dùng hỏi tổng quan, để giảm số lần gọi.

## Trình bày kết quả

- Trả lời bằng tiếng Việt, số tiền theo VND có dấu chấm phân cách nghìn (ví dụ 1.250.000đ).
- Nêu khoảng thời gian của số liệu (ví dụ "7 ngày gần nhất", "từ 01/10 đến 09/10").
- Nêu điều đáng chú ý trước, chi tiết sau. Không đổ nguyên JSON cho người dùng.

## An toàn dữ liệu

- Thông tin khách hàng (số điện thoại, email, địa chỉ, công nợ) là dữ liệu nhạy cảm: chỉ hiển thị khi người dùng cần, không chép ra file hay gửi đi nơi khác nếu không được yêu cầu rõ.
- Với bất kỳ công cụ nào thay đổi dữ liệu (tạo, sửa, xóa, gửi tin, kích hoạt workflow), tóm tắt chính xác thao tác sắp làm và chờ người dùng xác nhận trước khi gọi.
