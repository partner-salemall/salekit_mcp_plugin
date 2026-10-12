---
name: products-inventory
description: >
  View Salekit products and stock, flag items running low, and suggest products to push.
  Use when the user asks how many of an item are left, what is in a warehouse, what is running out,
  what to restock, slow-moving stock, product categories, or which products to promote, e.g.
  "còn bao nhiêu áo X", "kho chính còn gì", "sản phẩm nào sắp hết", "nên nhập thêm gì", "hàng tồn lâu".
metadata:
  version: "0.2.0"
---

# Products and inventory

## Lookup

- Find a product by name or code: `search_products`, then `get_product_detail` for price, variants and description. Re-filter by the exact accented text (see `salekit-basics`).
- Categories: `get_categories`.
- Warehouses: `get_warehouses` for the list and ids, then `get_inventory` for stock per warehouse. If the shop has several warehouses and the user did not say which, ask, or use the main one and say so.

## Stock alerts

1. `detect_inventory_risk` for the warehouse in question: items running low and slow-moving stock.
2. Compare with sales velocity from `summarize_sales` or `get_daily_sales` when you need to estimate days of stock left.
3. Present two separate groups: **Running low** (name, current stock, estimated days left) and **Slow-moving** (name, stock, last sale if available). At most 10 lines per group.

## Sales suggestions

`recommend_products` gives products worth pushing. Combine with the slow-moving group to suggest clearance, or with best sellers to suggest restocking. Back every suggestion with a figure.

Never adjust stock or prices yourself. If the user wants to change them, direct them to the Salekit admin page.
