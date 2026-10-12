---
name: profit-costs
description: >
  Analyze profit, costs, COD cash and receivables for a Salekit shop. Use when the user asks how much
  profit they made, profit this month, where costs went up, COD not yet received, COD reconciliation,
  profit margin, or total customer debt, e.g. "lãi bao nhiêu", "lợi nhuận tháng này",
  "chi phí tăng ở đâu", "tiền COD chưa về", "đối soát COD", "khách còn nợ tổng bao nhiêu".
metadata:
  version: "0.2.0"
---

# Profit and costs

## Steps

1. Settle the time range; default to the current month to date and say so.
2. Revenue: `get_revenue_report`. Profit: `get_profit_report`. Costs: `get_cost_report`.
3. For a daily trend use `get_daily_sales`; for monthly, `get_monthly_sales`.
4. Money not yet collected: `get_cod_report` (COD awaiting reconciliation) and `get_customer_debts` (customer debts).
5. When profit drops, compare with the previous period of the same length to find the cause: lower revenue, higher costs, or higher cost of goods. `detect_sales_drop` tells you whether revenue fell abnormally.

## Layout

**Results [time range]:** revenue, costs, profit, margin (%), vs. previous period.

**Money outstanding:** total COD awaiting reconciliation, total customer debt, largest item.

**Notes:** 2–3 points naming the fastest-growing cost or the main driver of the profit change.

Use only the figures Salekit returns. If the shop has not entered cost of goods or expenses (profit equals revenue, or costs are 0), say that the profit figure does not reflect reality instead of presenting it as real profit.
