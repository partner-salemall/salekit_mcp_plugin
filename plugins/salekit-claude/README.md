# salekit plugin

Connects Claude to the Salekit MCP server at `https://api.salekit.com/mcp` (streamable HTTP, OAuth 2.1 + PKCE).

No environment variables or tokens needed: Claude Code runs OAuth itself on `claude mcp login plugin:salekit:salekit`, or when the user chooses Authenticate in `/mcp`.

## Skills

| Skill | When it is used |
|---|---|
| `salekit-basics` | Every Salekit request: sign-in, id lookup rules, accent-aware search, presentation, confirm before writing |
| `sales-report` | Revenue reports, comparison with the previous period, sales sources, stock |
| `profit-costs` | Profit, costs, COD awaiting reconciliation, total receivables |
| `order-lookup` | Find orders, details, processing history, shipment tracking |
| `customer-care` | Customers in debt, lapsed customers, customer profiles, follow-up drafts |
| `products-inventory` | Products, stock per warehouse, items running low, slow-moving stock |
| `channels-affiliates` | Ad source performance, affiliates/CTV, tracking links, conversion rate |
| `marketing-automation` | Workflows, sequences, funnels, campaign suggestions |
| `shop-info` | Subscription plan, settings, staff, roles, permissions |
| `known-errors` | Diagnosing auth, permission, parameter and empty-result errors |

This is the source of truth for the skills. The Codex plugin (`plugins/salekit-codex`) uses copies of every skill except `salekit-basics`; after editing a skill, run `node scripts/sync-skills.mjs`.

## Install

```
claude plugin marketplace add partner-salemall/salekit_mcp_plugin
claude plugin install salekit@salekit
```
