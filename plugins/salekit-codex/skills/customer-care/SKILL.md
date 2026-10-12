---
name: customer-care
description: >
  Find and prioritize Salekit customers who need follow-up. Use when the user asks which customers
  to call back, who still owes money, who has not bought in a while, who may churn, for a customer
  profile, or to draft a message, e.g. "khách nào cần gọi lại", "khách còn nợ", "khách lâu không mua",
  "khách sắp rời bỏ", "chăm sóc khách hàng", "xem thông tin khách X", "soạn tin nhắn cho khách".
metadata:
  version: "0.2.0"
---

# Customer care

## Build the list

- Customers with unpaid balances: `get_customer_debts`.
- Customers who have not come back: `detect_customer_churn`.
- Combined suggestions: `recommend_followup`.
- One specific customer: `search_customers` or `get_customer_by_phone` / `get_customer_by_email`, then `summarize_customer`. For more detail add `get_customer_detail`, `get_customer_orders`, `get_customer_revenue`, `get_customer_notes` (staff notes) and `get_customer_tags`.
- Filter by customer group: list tags with `get_tags`, then filter `get_customers` by tag if the schema supports it.

## Prioritize

Order by: (1) large debts or the most recent unpaid order, (2) high lifetime spend but no recent purchase, (3) everyone else. Show at most 10 customers at a time, one line each: name, reason to contact, key figure (amount owed, last purchase date, total spend).

## Customer profile

When showing one customer: total spend, order count, latest order, debt, tags, latest note. End with one concrete contact suggestion (e.g. a product similar to their last order, using `recommend_products`).

## Drafting messages

- When the user wants to message a customer, write a short, polite draft with the right form of address ("anh/chị"), mentioning the specific order or product they bought.
- For debts: gentle tone, include the order details and how to pay, never threatening.
- Only draft for the user to send themselves. Do not send messages, add tags or enroll customers in workflows unless the user confirms each action.
