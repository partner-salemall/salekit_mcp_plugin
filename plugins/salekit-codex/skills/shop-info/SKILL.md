---
name: shop-info
description: >
  View Salekit shop information and configuration: subscription plan, settings, sales channels, staff,
  roles, permissions, notifications. Use when the user asks which plan the shop is on, whether it has
  expired, who the staff are, whether they have a permission, new notifications, or which channels
  the shop has, e.g. "shop đang dùng gói gì", "gói hết hạn chưa", "có những nhân viên nào",
  "tôi có quyền xem báo cáo không", "có thông báo gì mới".
metadata:
  version: "0.2.0"
---

# Shop info

| Question | Tool |
|---|---|
| Current shop, quick overview | `get_current_shop`, `summarize_shop` |
| Detailed info, settings | `get_shop_info`, `get_shop_settings` |
| Subscription plan, expiry, limits | `get_shop_package` |
| Sales channels, tags | `get_channels`, `get_tags` |
| Logged-in account | `get_current_user` |
| Staff, roles | `get_users`, `get_roles` |
| Check one permission | `check_permission` |
| System notifications | `get_notifications` |

## Notes

- If the plan expires soon (under 7 days) or has hit a limit, put that at the top of the answer.
- When another tool reports missing permission, use `get_current_user` and `check_permission` to say exactly which permission the account lacks, then suggest asking the shop owner to grant it or logging in with another account.
- The staff list contains emails and phone numbers: show them only when asked.
- Switching shops: the login session is tied to the shop chosen when granting access. To work on another shop, the user must log in again and pick that shop (see `salekit-basics`).
