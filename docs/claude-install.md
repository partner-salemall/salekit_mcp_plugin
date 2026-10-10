# Salekit plugin for Claude Code: install guide (for AI agents)

This guide is written for Claude Code to follow on the user's behalf. Host it as plain text at a stable URL (for example https://salekit.com/claude) so the user can tell Claude: "Install the Salekit plugin from https://salekit.com/claude".

## 1. Install

Run in order:

```
claude plugin marketplace add https://github.com/YOUR-ORG/salekit-claude-plugin.git#main
claude plugin install salekit@salekit
```

The marketplace command clones a git repository. Give it a generous timeout and wait for it to exit; do not start a second attempt while one is running.

If a standalone server named exactly `salekit` exists (`claude mcp get salekit`), remove it with `claude mcp remove salekit`. Never remove `plugin:salekit:salekit`.

## 2. Log in

```
claude mcp login plugin:salekit:salekit
```

This opens the Salekit sign-in page in the browser. Tell the user (in Vietnamese) to sign in, choose their shop and click "Cho phép". If the browser does not open, show the user the authorization URL printed in the output.

If the shell has no TTY ("stdin is not a terminal"), run the bundled script instead:

- macOS / Linux / WSL: `sh "${CLAUDE_PLUGIN_ROOT}/scripts/login-salekit.sh"`
- Windows PowerShell: `powershell -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}\scripts\login-salekit.ps1"`

Success signal: the output line `Authenticated with "plugin:salekit:salekit"`. `Connected` alone does not mean authenticated.

## 3. Verify

```
claude plugin list
claude mcp get plugin:salekit:salekit
```

`salekit@salekit` must be enabled.

## 4. Finish

Tell the user, in Vietnamese, that Salekit is ready, that they must open a **new session** for the tools to load, and give one example request such as "Dùng Salekit báo cáo bán hàng 7 ngày qua". Do not call Salekit tools in the installation session.

## Troubleshooting

- `claude mcp login` not found: Claude Code is too old. Run `claude update`, or `npm install -g @anthropic-ai/claude-code@latest`, then retry.
- `Authentication timeout`: start one fresh login. Never run two logins at once.
- HTTP 5xx during login: Salekit's auth service is temporarily unavailable. Wait and retry; do not reinstall. You can probe `curl -fsS https://api.salekit.com/.well-known/oauth-protected-resource`.
- Tools return an authentication error in a later session: run step 2 again.
