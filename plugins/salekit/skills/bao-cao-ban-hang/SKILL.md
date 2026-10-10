---
name: bao-cao-ban-hang
description: >
  Lập báo cáo bán hàng Salekit cho chủ shop. Dùng khi người dùng hỏi "báo cáo sáng nay",
  "tình hình bán hàng", "doanh thu tuần này/tháng này", "shop dạo này thế nào",
  "so sánh với tuần trước", "kênh nào bán tốt", "sản phẩm nào sắp hết hàng".
metadata:
  version: "0.1.0"
---

# Báo cáo bán hàng

## Các bước

1. Xác định khoảng thời gian. Nếu người dùng không nói, mặc định 7 ngày gần nhất và nói rõ điều đó.
2. Lấy số liệu tổng: `summarize_sales` (hoặc `get_revenue_report` / `get_profit_report` cho khoảng tùy chọn, `get_monthly_sales` cho một tháng).
3. So sánh với kỳ trước bằng `detect_sales_drop`. Chỉ nhấn mạnh khi thay đổi đáng kể.
4. Nguồn doanh thu: `get_top_sources` (utm_source) và `get_top_refs` (affiliate/CTV).
5. Rủi ro tồn kho: lấy kho bằng `get_warehouses`, rồi `detect_inventory_risk` cho kho chính.
6. Việc cần làm: `get_cod_report` nếu shop bán COD, `recommend_followup` để lấy danh sách khách cần liên hệ lại.

Bỏ qua bước nào mà công cụ trả lỗi hoặc không có dữ liệu, và ghi chú ngắn ở cuối báo cáo.

## Mẫu trình bày

**Tổng quan [khoảng thời gian]:** doanh thu, số đơn, lợi nhuận (nếu có), so với kỳ trước (+/- %).

**Điểm đáng chú ý:** 2–4 ý ngắn: nguồn hoặc CTV nổi bật, ngày tăng hay giảm bất thường, sản phẩm sắp hết hàng.

**Việc nên làm hôm nay:** tối đa 3 việc cụ thể, mỗi việc gắn với số liệu ở trên.

Giữ báo cáo ngắn để đọc trên điện thoại. Nếu người dùng muốn lưu hoặc chia sẻ, đề nghị xuất thành tài liệu.
