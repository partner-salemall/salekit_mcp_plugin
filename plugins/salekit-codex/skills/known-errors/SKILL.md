---
name: known-errors
description: >
  Diagnose errors when calling Salekit tools: authentication failures, missing permissions, invalid
  parameters, empty results, accent-insensitive search noise, mismatched figures. Use when a Salekit
  tool errors or returns something odd, or the user says "sao không ra dữ liệu", "số liệu sai", "Salekit lỗi".
metadata:
  version: "0.2.0"
---

# Known errors

Treat the error message returned by the tool as authoritative. Do not retry repeatedly with the same failing parameters.

## Authentication and permissions

- **401, expired token, no Salekit tools visible:** the login session expired or never happened. Follow the login section in `salekit-basics`. Reinstalling the plugin does not fix this.
- **403, no permission:** the account lacks a permission on the shop. Use `get_current_user` and `check_permission` to say exactly what is missing (see `shop-info`).
- **Wrong shop:** `get_current_shop` returns a different shop than the user wants. The user must log in again and choose the right shop.

## Parameters

- **Validation error:** re-read the tool schema and change only the rejected field. The most common causes are a wrong date format and ids carried over from an old session.
- **Id not found:** the record was deleted or belongs to another shop. Look it up again with the matching list tool (`get_orders`, `search_customers`, `get_warehouses`...).

## Results

- **Empty:** check the time range, channel/warehouse filters and `page`. Widen the time range once, then tell the user there is no data, including the filters used.
- **Unrelated matches when searching by name:** Salekit search ignores diacritics. Re-filter by the exact accented text.
- **Figures differ between two tools:** reports may count by order creation date or completion date, with or without cancelled orders. Report each tool's number as is instead of adjusting them to match.
- **A feature has no data** (workflows, affiliates, multiple warehouses): the shop may not use it, or its plan may not include it. Check with `get_shop_package`.

## Server errors

HTTP 5xx or timeout: the Salekit service is temporarily unstable. Retry once after a few seconds; if it still fails, tell the user and stop rather than retrying in a loop.
