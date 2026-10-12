---
name: channels-affiliates
description: >
  Evaluate Salekit sales sources (utm_source, ads), affiliates/CTV and tracking links. Use when the user
  asks which CTV sells best, affiliate results, which source brings orders, whether ads work,
  conversion rate, campaign links or commissions, e.g. "CTV nào bán tốt nhất", "affiliate tháng này",
  "nguồn nào ra đơn", "quảng cáo Facebook hiệu quả không", "tỉ lệ chuyển đổi", "hoa hồng CTV".
metadata:
  version: "0.2.0"
---

# Channels and affiliates

Salekit tags every order and contact with a **source** (`src`, usually utm_source) and optionally a **ref** (affiliate/CTV code). Both axes share the same set of tools:

| Question | By source | By CTV/affiliate |
|---|---|---|
| Ranking | `get_top_sources` | `get_top_refs` |
| Revenue | `get_revenue_by_src` | `get_revenue_by_ref` |
| Orders | `get_order_by_src` | `get_order_by_ref` |
| Contacts (leads) | `get_contact_by_src` | `get_contact_by_ref` |

Links: `get_tracking_links` (tracking links) and `get_campaign_links` (campaign links). Conversion rate: `get_conversion_rate`.

## Steps

1. Settle the time range (default 30 days for CTV questions, 7 days for ads) and say so.
2. Get the ranking with `get_top_sources` or `get_top_refs`.
3. For the top 3–5 entries, also get contacts and orders to compute close rate = orders / contacts. Use Salekit's number from `get_conversion_rate` when available instead of computing it yourself.
4. When the user asks about one CTV or source, look at its order list for anomalies (many cancellations, orders bunched on one day).

## Presenting

A table with: source/CTV name, contacts, orders, revenue, close rate. After the table give 2–3 observations: sources with many leads but few orders (sales follow-up needs review), CTVs with high revenue but high cancellation, fast-growing new sources.

Do not compute commissions if the tools do not return them; make clear which numbers come from Salekit and which are estimates.
