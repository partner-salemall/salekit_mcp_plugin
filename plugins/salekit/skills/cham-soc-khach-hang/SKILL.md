---
name: cham-soc-khach-hang
description: >
  Tìm và ưu tiên khách hàng Salekit cần chăm sóc lại. Dùng khi người dùng hỏi
  "khách nào cần gọi lại", "khách còn nợ", "khách lâu không mua", "khách sắp rời bỏ",
  "chăm sóc khách hàng", "xem thông tin khách X", "soạn tin nhắn cho khách".
metadata:
  version: "0.1.0"
---

# Chăm sóc khách hàng

## Lấy danh sách

- Khách chưa thanh toán đủ: `get_customer_debts`.
- Khách lâu không quay lại: `detect_customer_churn`.
- Gợi ý tổng hợp: `recommend_followup`.
- Hồ sơ một khách cụ thể: `search_customers` hoặc `get_customer_by_phone` / `get_customer_by_email`, sau đó `summarize_customer`.

## Ưu tiên

Xếp thứ tự theo: (1) công nợ lớn hoặc đơn chưa thanh toán gần nhất, (2) khách có tổng doanh thu cao nhưng lâu không mua, (3) còn lại. Trình bày tối đa 10 khách mỗi lần, mỗi khách một dòng gồm tên, lý do cần liên hệ, số liệu chính (số tiền nợ, ngày mua gần nhất, tổng chi tiêu).

## Soạn tin nhắn

- Khi người dùng muốn nhắn khách, soạn tin ngắn, lịch sự, xưng hô phù hợp ("anh/chị"), nhắc cụ thể đơn hàng hoặc sản phẩm khách đã mua.
- Với công nợ: nhẹ nhàng, đưa thông tin đơn và cách thanh toán, không dùng giọng đe dọa.
- Chỉ soạn nháp để người dùng tự gửi. Không tự gửi tin, gắn tag hay thêm khách vào workflow nếu người dùng chưa xác nhận từng thao tác.
