---
name: sales-report
description: >
  Build a Salekit sales report for the shop owner. Use when the user asks for a morning report,
  sales performance, revenue this week/month, comparison with last week, best channels or
  items running low, e.g. "báo cáo sáng nay", "tình hình bán hàng", "doanh thu tuần này/tháng này",
  "shop dạo này thế nào", "so sánh với tuần trước", "kênh nào bán tốt", "sản phẩm nào sắp hết hàng".
metadata:
  version: "0.2.0"
---

# Sales report

## Steps

1. Settle the time range. If the user does not give one, default to the last 7 days and say so.
2. Get the headline numbers: `summarize_sales` or `get_sales_dashboard` / `get_dashboard_stats` (or `get_revenue_report` / `get_profit_report` for a custom range, `get_daily_sales` for a per-day view, `get_monthly_sales` for one month).
3. Compare with the previous period using `detect_sales_drop`. Only highlight significant changes.
4. Revenue sources: `get_top_sources` (utm_source) and `get_top_refs` (affiliates/CTV).
5. Stock risk: get warehouses with `get_warehouses`, then `detect_inventory_risk` for the main warehouse.
6. To-dos: `get_cod_report` if the shop sells COD, `recommend_followup` for customers to contact again.

Skip any step whose tool errors or returns no data, and add a short note at the end of the report.

## Layout

**Overview [time range]:** revenue, order count, profit (if available), change vs. previous period (+/- %).

**Highlights:** 2–4 short points: standout sources or CTVs, unusual up or down days, items running low.

**Do today:** at most 3 concrete actions, each tied to a figure above.

For deeper analysis, hand over to another skill: profit and COD in `profit-costs`, sources and CTVs in `channels-affiliates`, stock in `products-inventory`.

Keep the report short enough to read on a phone. If the user wants to save or share it, offer to export it as a document.
