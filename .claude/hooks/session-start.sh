#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# Install pnpm if not available
if ! command -v pnpm &>/dev/null; then
  npm install -g pnpm@10.23.0
fi

# Install dependencies (uses cache on subsequent runs)
pnpm install --frozen-lockfile

# Build the project (needed for linter type-aware mode and tests)
pnpm build
