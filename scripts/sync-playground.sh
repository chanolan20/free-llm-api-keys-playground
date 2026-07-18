#!/bin/bash
# Auto-sync script: pull upstream updates, push to playground repo
# Usage: ./scripts/sync-playground.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "=== Syncing free-llm-api-keys playground ==="
echo ""

# Check for uncommitted changes
if ! git diff --quiet; then
    echo "WARNING: You have uncommitted changes. Commit or stash them first."
    git status --short
    exit 1
fi

# Fetch upstream (origin-dead)
echo "[1/4] Fetching upstream (origin-dead)..."
git fetch origin-dead 2>&1 || echo "Upstream fetch failed (expected if remote is dead)"

# Pull latest from upstream main (if alive)
echo "[2/4] Pulling from upstream..."
git pull origin-dead main --rebase 2>&1 || echo "Upstream pull failed or unavailable - using local state"

# Push to playground
echo "[3/4] Pushing to playground..."
git push playground main 2>&1

# Update the docs index with latest README state
echo "[4/4] Verifying playground..."
PLAYGROUND_URL="https://chanolan20.github.io/free-llm-api-keys-playground/"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$PLAYGROUND_URL" --max-time 10)
if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ Playground is live (HTTP $HTTP_STATUS)"
else
    echo "⚠️  Playground returned HTTP $HTTP_STATUS"
fi

echo ""
echo "=== Sync complete ==="
