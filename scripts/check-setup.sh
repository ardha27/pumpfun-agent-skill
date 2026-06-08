#!/usr/bin/env bash
# Pump.fun Agent Skill — Setup Check Script
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=== Pump.fun Agent Skill — Setup Check ==="
echo ""

fail=0

# Check uv
if command -v uv &>/dev/null; then
    echo -e "${GREEN}✓${NC} uv installed: $(uv --version)"
else
    echo -e "${RED}✗${NC} uv not found. Install: curl -LsSf https://astral.sh/uv/install.sh | sh"
    fail=1
fi

# Check pumpfun-cli
if command -v pumpfun &>/dev/null; then
    echo -e "${GREEN}✓${NC} pumpfun-cli installed: $(pumpfun --version 2>&1)"
else
    echo -e "${YELLOW}⚠${NC} pumpfun-cli not found (required for trading)."
    echo "  Install: uv tool install git+https://github.com/chainstacklabs/pumpfun-cli.git"
    echo "  (Skip this if you only want token discovery via HTTP API)"
fi

# Check Python
if command -v python3 &>/dev/null; then
    pyver=$(python3 --version 2>&1)
    echo -e "${GREEN}✓${NC} $pyver"
else
    echo -e "${RED}✗${NC} python3 not found"
    fail=1
fi

# Check Git
if command -v git &>/dev/null; then
    echo -e "${GREEN}✓${NC} git installed: $(git --version 2>&1)"
else
    echo -e "${YELLOW}⚠${NC} git not found (needed for pumpfun-cli install)"
fi

# Check curl
if command -v curl &>/dev/null; then
    echo -e "${GREEN}✓${NC} curl available"
else
    echo -e "${RED}✗${NC} curl not found"
    fail=1
fi

# Check wallet (if pumpfun-cli is installed)
if command -v pumpfun &>/dev/null; then
    if pumpfun wallet show &>/dev/null 2>&1; then
        addr=$(pumpfun wallet show 2>&1 | grep -oP '[1-9A-HJ-NP-Za-km-z]{32,44}' | head -1)
        echo -e "${GREEN}✓${NC} Wallet configured: ${addr:-yes}"
    else
        echo -e "${YELLOW}⚠${NC} No wallet configured. Run: pumpfun wallet create"
    fi

    # Check RPC config
    rpc=$(pumpfun config get rpc 2>&1 | grep -v "not set" || true)
    if [ -n "$rpc" ]; then
        echo -e "${GREEN}✓${NC} RPC configured"
    else
        echo -e "${YELLOW}⚠${NC} No RPC configured. Run: pumpfun config set rpc <URL>"
    fi
fi

# Check API access
echo ""
echo "--- API Connectivity ---"
if curl -s --max-time 5 "https://frontend-api-v3.pump.fun/coins/top-runners?limit=1" &>/dev/null; then
    echo -e "${GREEN}✓${NC} pump.fun API reachable"
else
    echo -e "${YELLOW}⚠${NC} pump.fun API not reachable (check network)"
fi

echo ""
if [ $fail -eq 0 ]; then
    echo -e "${GREEN}All prerequisites met!${NC}"
    echo "Next: pumpfun tokens trending --limit 10"
else
    echo -e "${RED}Some prerequisites missing. Fix issues above before using this skill.${NC}"
    exit 1
fi
