---
name: order-lookup
description: >
  Look up Salekit orders: find orders, view details, processing history and shipping status.
  Use when the user asks about today's orders, a customer's orders, where an order is, undelivered
  or returned orders, tracking numbers, or orders from a source/CTV, e.g. "đơn hôm nay",
  "tìm đơn của khách 09...", "đơn #12345 đang ở đâu", "đơn nào chưa giao", "đơn bị hoàn", "kiểm tra vận đơn".
metadata:
  version: "0.2.0"
---

# Order lookup

## Find orders

- By order code or filters (date, status, sales channel): `get_orders`. Get channel ids with `get_channels` when filtering by channel.
- By customer: find the customer with `get_customer_by_phone` / `get_customer_by_email` / `search_customers`, then `get_customer_orders`.
- By ad source (utm_source): `get_order_by_src`. By affiliate/CTV: `get_order_by_ref`.

If the user just says "today's orders" or "recent orders", filter on today or the last 7 days and state the range used.

## View one order

1. `get_order_detail`: items, quantities, totals, payment, delivery address.
2. `get_order_timeline`: created, confirmed, packed, shipped, returned milestones.
3. If there is a tracking number, call `track_shipment` for the carrier status. `get_shipping_providers` shows which carriers the shop uses.

## Presenting

- Lists: one line per order with order code, customer name, total, status, created date. At most 20 lines, plus the total from `totalCount`.
- One order: current status first, then the latest timeline milestone, then items and amounts.
- Call out orders stuck in one status for too long (e.g. waiting for pickup over 2 days, in transit over 5 days) as things to handle.
- Mask phone numbers and addresses when listing many orders (e.g. 090****123); show them in full only when the user views a single order.

The plugin only reads orders. If the user wants to create, edit or cancel an order and there is no matching write tool, direct them to the Salekit admin page.
