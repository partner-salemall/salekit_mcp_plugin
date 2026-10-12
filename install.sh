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

fail() {
  echo ""
  echo "$1"
  echo "Check your network connection and run the install command again."
  echo "If it keeps failing, run the steps by hand: https://github.com/partner-salemall/salekit_mcp_plugin#manual-install-claude-code"
  exit 1
}

# Update the marketplace if it is already registered, otherwise add it (one retry: the clone can time out).
if claude plugin marketplace list 2>/dev/null | grep -Eq '[[:space:]]salekit[[:space:]]*$'; then
  echo "Updating the Salekit marketplace..."
  claude plugin marketplace update salekit || fail "Could not update the Salekit marketplace."
else
  echo "Adding the Salekit marketplace..."
  claude plugin marketplace add "$REPO" ||
    { echo "Retrying..."; claude plugin marketplace add "$REPO"; } ||
    fail "Could not add the Salekit marketplace."
fi

echo "Installing the plugin..."
claude plugin install salekit@salekit || fail "Could not install the Salekit plugin."

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
# Under `curl | sh`, stdin is a pipe; reattach the keyboard from the terminal.
# Use the real device (e.g. /dev/ttys003): on macOS, Claude Code (Bun) crashes with
# "EINVAL: invalid argument, kqueue" when stdin is /dev/tty, which kqueue does not support.
TTY_DEV=""
if [ ! -t 0 ]; then
  T=$(ps -o tty= -p $$ 2>/dev/null | tr -d ' ')
  case "$T" in
    ""|"?"|"??") ;;
    *) [ -r "/dev/$T" ] && TTY_DEV="/dev/$T" ;;
  esac
  if [ -z "$TTY_DEV" ] && [ "$(uname -s)" != "Darwin" ] && [ -r /dev/tty ]; then
    TTY_DEV="/dev/tty"
  fi
fi
LOGIN_OK=0
if [ -n "$TTY_DEV" ]; then
  claude mcp login "$SERVER" < "$TTY_DEV" || LOGIN_OK=1
elif [ -t 0 ]; then
  claude mcp login "$SERVER" || LOGIN_OK=1
else
  # No terminal at all: keep claude from swallowing the rest of the piped script.
  claude mcp login "$SERVER" < /dev/null || LOGIN_OK=1
fi
if [ "$LOGIN_OK" -ne 0 ]; then
  echo ""
  echo "The plugin is installed, but sign-in did not finish."
  echo "Run this to sign in again: claude mcp login $SERVER"
  exit 1
fi

echo ""
echo "Done. Open Claude Code (command: claude) and try: \"Use Salekit to report sales for the last 7 days\""
