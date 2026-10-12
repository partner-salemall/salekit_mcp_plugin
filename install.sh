#!/bin/sh
# Install the Salekit plugin for Claude Code (macOS / Linux / WSL).
# Usage: curl -fsSL https://raw.githubusercontent.com/partner-salemall/salekit_mcp_plugin/main/install.sh | sh

set -e

REPO="partner-salemall/salekit_mcp_plugin"
SERVER="plugin:salekit:salekit"

if ! command -v claude >/dev/null 2>&1; then
  echo "Claude Code not found. Installing..."
  curl -fsSL https://claude.ai/install.sh | bash
  export PATH="$HOME/.local/bin:$PATH"
fi

# `claude mcp login` needs a recent Claude Code.
if ! claude mcp login --help >/dev/null 2>&1; then
  echo "Claude Code is too old, updating..."
  claude update || true
  if ! claude mcp login --help >/dev/null 2>&1; then
    echo "Could not update Claude Code. If installed with npm, run: npm install -g @anthropic-ai/claude-code@latest"
    echo "If installed with Homebrew, run: brew upgrade claude-code"
    exit 1
  fi
fi

echo "Adding the Salekit marketplace..."
claude plugin marketplace add "$REPO" 2>/dev/null || claude plugin marketplace update salekit

echo "Installing the plugin..."
claude plugin install salekit@salekit

# A manually added `salekit` server pointing at the same endpoint duplicates the plugin's tools.
# Remove it only in that case; leave servers pointing anywhere else alone.
if claude mcp get salekit >/dev/null 2>&1; then
  OLD_URL=$(claude mcp get salekit 2>/dev/null | sed -n 's/^ *URL: *//p' | tr -d '\r')
  if [ "$OLD_URL" = "https://api.salekit.com/mcp" ]; then
    claude mcp remove salekit >/dev/null 2>&1 || true
    echo "Removed the old manually added 'salekit' server (duplicate of the plugin)."
  else
    echo "Note: you have a separate MCP server named 'salekit' (${OLD_URL:-not an HTTP server}). It was left unchanged."
    echo "If you no longer need it, remove it with: claude mcp remove salekit"
  fi
fi

echo ""
echo "Opening the Salekit sign-in page. Sign in, choose your shop, then click \"Cho phép\" (Allow)."
# Under `curl | sh`, stdin is a pipe; reattach the keyboard from /dev/tty.
if [ -r /dev/tty ]; then
  claude mcp login "$SERVER" < /dev/tty
else
  claude mcp login "$SERVER"
fi

echo ""
echo "Done. Open Claude Code (command: claude) and try: \"Use Salekit to report sales for the last 7 days\""
