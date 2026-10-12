# salekit plugin for Codex

Connects Codex to the Salekit MCP server at `https://api.salekit.com/mcp` (streamable HTTP, OAuth 2.1 + PKCE). Sign in with `codex mcp login salekit`.

- `.codex-plugin/plugin.json`: plugin metadata and Codex UI details.
- `.mcp.json`: MCP server configuration.
- `skills/salekit-basics/`: the basics skill, written for Codex.
- All other skills are copied from `plugins/salekit-claude/skills/` by `node scripts/sync-skills.mjs`. Do not edit them here; edit the source in the Claude plugin and rerun the script.

Install: see [docs/codex-install.md](../../docs/codex-install.md).
