# Salekit for Claude and Codex

The official plugin connecting Claude Code, Claude Cowork and Codex (ChatGPT) to Salekit: orders, customers, revenue, inventory, affiliates and workflows. Sign in with your Salekit account over OAuth; no token copying needed.

## Quick install (Claude Code)

Open a terminal and paste one command. The script installs Claude Code if missing, updates it if too old, installs the plugin, then opens the Salekit sign-in page.

macOS / Linux:

```
curl -fsSL https://raw.githubusercontent.com/partner-salemall/salekit_mcp_plugin/main/install.sh | sh
```

Windows (PowerShell):

```
irm https://raw.githubusercontent.com/partner-salemall/salekit_mcp_plugin/main/install.ps1 | iex
```

## Manual install (Claude Code)

```
claude plugin marketplace add partner-salemall/salekit_mcp_plugin
claude plugin install salekit@salekit
```

## Sign in (Claude Code)

```
claude mcp login plugin:salekit:salekit
```

The browser opens the Salekit sign-in page. Sign in, choose your shop and click **Cho phép** (Allow). The terminal prints `Authenticated with "plugin:salekit:salekit"` when done.

Alternatively: in Claude Code type `/mcp`, select `salekit`, then choose **Authenticate**.

After signing in, open a **new session** and ask, for example:

- "Dùng Salekit báo cáo bán hàng 7 ngày qua"
- "Khách nào đang còn nợ tiền?"
- "Sản phẩm nào ở kho chính sắp hết hàng?"

Agent-readable install guide: [docs/claude-install.md](docs/claude-install.md).

## Codex (ChatGPT)

```
codex plugin marketplace add https://github.com/partner-salemall/salekit_mcp_plugin.git --ref main
codex plugin add salekit@salekit
codex mcp login salekit
```

In the Codex desktop app, use the Codex CLI bundled with the app. Open a **new thread** after signing in. Agent-readable install guide: [docs/codex-install.md](docs/codex-install.md).

Update: `codex plugin marketplace upgrade salekit`.

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

## Update (Claude Code)

```
claude plugin marketplace update salekit
claude plugin update salekit@salekit
```

## Uninstall (Claude Code)

```
claude plugin uninstall salekit@salekit
```

Revoke access: Salekit → Settings → Connected apps.

## Repository layout

```
.claude-plugin/marketplace.json      Claude Code marketplace
.agents/plugins/marketplace.json     Codex marketplace
plugins/salekit-claude/              Claude Code plugin
  .claude-plugin/plugin.json
  .mcp.json                          Points to https://api.salekit.com/mcp
  skills/                            Source of truth for every skill
  scripts/login-salekit.sh|.ps1      Sign-in scripts
plugins/salekit-codex/               Codex plugin
  .codex-plugin/plugin.json
  .mcp.json
  skills/salekit-basics/             Codex edition of the basics skill
  skills/*                           Copied from plugins/salekit-claude/skills
scripts/sync-skills.mjs              Syncs skills into Codex (--check to verify)
docs/claude-install.md               Claude Code install guide for agents
docs/codex-install.md                Codex install guide for agents
```

## Developing skills

1. Edit or add skills in `plugins/salekit-claude/skills/<name>/SKILL.md`. Skills use short tool names (`get_orders`), never a host-specific namespace.
2. Host-specific parts (sign-in, tool namespace) live only in `salekit-basics`, one edition per plugin.
3. Run `node scripts/sync-skills.mjs` to copy them into Codex. CI runs `--check` and fails if the two copies drift.
4. Bump `version` in both plugins' `plugin.json` and in `.claude-plugin/marketplace.json`.
