---
name: pumpfun-agent-skill
description: Equip AI agents (Hermes, Claude Code, Codex, OpenClaw) to research, analyze, and trade on pump.fun — the memecoin launchpad on Solana.
version: 1.0.0
author: ardha27
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [solana, defi, pump-fun, memecoin, trading, bonding-curve]
    related_skills: [pumpclaw, pumpfun-cli]
---

# Pump.fun Agent Skill

Gives your AI agent the knowledge to work with [pump.fun](https://pump.fun) — the fairest way to launch and trade memecoins on Solana.

**What this skill covers:**
- Platform mechanics (bonding curve, graduation, King of the Hill)
- Token research & analysis (trending, new, graduating, search)
- Trading operations (buy, sell, migrate, simulate)
- Token launch workflow
- Safety guidelines & scam prevention
- Smart contract interaction patterns

## Prerequisites

| Tool | Required For | Install |
|------|-------------|---------|
| `pumpfun-cli` | Trading, token discovery, wallet mgmt | `uv tool install git+https://github.com/chainstacklabs/pumpfun-cli.git` |
| `uv` | Python package manager | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| Solana wallet | Any on-chain action | `pumpfun wallet create` or import existing |
| Solana RPC endpoint | Reads/writes on-chain data | `pumpfun config set rpc <url>` (get from Helius, QuickNode, Chainstack) |

## Quick Start

```bash
# 1. Check setup
bash scripts/check-setup.sh

# 2. Browse tokens (no wallet or RPC needed)
pumpfun tokens trending --limit 10
pumpfun tokens search "dog"

# 3. Configure for trading
pumpfun config set rpc https://api.mainnet-beta.solana.com
pumpfun wallet create
pumpfun wallet balance

# 4. Simulate a trade (no real TX)
pumpfun buy <TOKEN_MINT> 0.1 --dry-run

# 5. Trade
pumpfun buy <TOKEN_MINT> 0.1 --slippage 20 --confirm
```

## Platform Overview

### What is pump.fun?

A memecoin launchpad on Solana where anyone can create a token in seconds with no coding. Coins trade instantly on a **bonding curve** — no liquidity pools to seed, no presales, no team allocations.

### Key Concepts

| Concept | Description |
|---------|-------------|
| **Bonding Curve** | Price algorithm: as more tokens are bought, price rises along a fixed curve. Price = (virtual_sol_reserves / virtual_token_reserves) |
| **Virtual Reserves** | The curve's internal accounting. Starts with ~30 SOL virtual reserve and ~1 quadrillion tokens. Real reserves grow as users trade. |
| **Graduation** | When a token's market cap hits ~$69K (bonding curve completes). Token migrates to PumpSwap AMM (formerly Raydium). |
| **King of the Hill** | First token each day to reach $69K market cap gets featured. |
| **Cashback** | Some tokens offer cashback on trades. Claimable via `pumpfun claim-cashback`. |
| **Supply** | 1,000,000,000,000,000 (1 quadrillion) total supply, 6 decimals. |
| **Program** | `6EF8rrecthR5Dkzon8Nwu78hRvfCKubJ14M5uBEwF6P` — the pump.fun smart contract on Solana mainnet. |

### Token Lifecycle

```
Create → Bonding Curve (tradeable) → Market Cap hits ~$69K
                                          ↓
                              Graduates to PumpSwap AMM
                                          ↓
                              Traded like any SPL token
```

## Token Discovery (Zero Config)

These commands need **no wallet or RPC** — they use pump.fun's public HTTP API.

```bash
# Trending tokens — what's moving right now
pumpfun tokens trending --limit 20

# Newest launches
pumpfun tokens new --limit 20

# Tokens about to graduate (near $69K)
pumpfun tokens graduating --limit 10

# Recommended by pump.fun
pumpfun tokens recommended

# Search by name/ticker
pumpfun tokens search "pepe"
```

## Token Analysis

For deeper analysis, fetch and interpret the token data:

```bash
# Detailed info (needs RPC)
pumpfun info <TOKEN_MINT>
```

**Key metrics from the API response (from `pump.fun/api/coins`):**

| Field | What it tells you |
|-------|-------------------|
| `complete` | `true` = graduated to AMM, `false` = still on bonding curve |
| `virtual_sol_reserves` | SOL side of the curve (higher = more liquidity) |
| `virtual_token_reserves` | Token side of the curve (lower = more scarcity) |
| `usd_market_cap` | Current market cap in USD |
| `ath_market_cap` | All-time high market cap |
| `king_of_the_hill_timestamp` | When (if ever) it hit King of the Hill |
| `reply_count` | Chat activity level |
| `creator` | Token deployer's wallet address |
| `pump_swap_pool` | Raydium/PumpSwap pool address (if graduated) |
| `real_sol_reserves` | Actual SOL in the curve (not virtual) |
| `real_token_reserves` | Actual tokens remaining in the curve |
| `is_banned` | Flagged by pump.fun |
| `nsfw` | NSFW flagged |

**Bonding curve price calculation:**
```
price_in_sol = virtual_sol_reserves / virtual_token_reserves
market_cap_sol = total_supply * price_in_sol
```

**Graduation check:**
The curve graduates when real reserves indicate the market cap has reached approximately $69K. The `complete` field and `pump_swap_pool` presence tell you conclusively.

## Trading

### Buy

```bash
# Buy 0.5 SOL worth of a token
pumpfun buy <TOKEN_MINT> 0.5

# With slippage tolerance (default 25%)
pumpfun buy <TOKEN_MINT> 0.5 --slippage 15

# Dry-run first (no real transaction)
pumpfun buy <TOKEN_MINT> 0.5 --dry-run

# Wait for confirmation
pumpfun buy <TOKEN_MINT> 0.5 --confirm
```

### Sell

```bash
# Sell all tokens
pumpfun sell <TOKEN_MINT> all

# Sell specific amount
pumpfun sell <TOKEN_MINT> 1000000

# Dry-run first
pumpfun sell <TOKEN_MINT> all --dry-run
```

### Migrate (post-graduation)

Once a token graduates, you can migrate your position to the AMM:

```bash
pumpfun migrate <TOKEN_MINT> --slippage 10 --confirm
```

### Post-trade checks

```bash
pumpfun tx-status <SIGNATURE>
```

## Token Launch

Launching a token on pump.fun:

```bash
pumpfun launch \
  --name "MyToken" \
  --ticker "MTK" \
  --desc "A great memecoin" \
  --image /path/to/image.png \
  --buy 2.0  # optionally buy some at launch
```

**Launch safety checklist:**
1. Use a **fresh wallet** for launch (never main wallet)
2. Understand that the bonding curve is deterministic — price trajectory is visible to everyone
3. Bots will snipe your token within seconds of launch
4. Consider using a bundler if you want multi-wallet distribution

## Wallet Management

```bash
# Create new wallet (encrypted keystore)
pumpfun wallet create

# Import existing
pumpfun wallet import <keypair.json>

# Show address
pumpfun wallet show

# Balances
pumpfun wallet balance

# Transfer SOL
pumpfun wallet transfer <ADDRESS> <AMOUNT>

# Drain all assets to one address
pumpfun wallet drain <RECIPIENT>
```

## Configuration

```bash
# Set RPC endpoint
pumpfun config set rpc https://mainnet.helius-rpc.com/?api-key=YOUR_KEY

# Priority fee (micro-lamports)
pumpfun config set priority_fee 100000

# Compute unit limit
pumpfun config set compute_units 200000

# List all config
pumpfun config list
```

## API Reference (for direct HTTP access)

pump.fun exposes public HTTP endpoints for token discovery:

| Endpoint | Returns |
|----------|---------|
| `GET https://frontend-api-v3.pump.fun/coins/top-runners?limit=N` | Trending tokens |
| `GET https://frontend-api-v3.pump.fun/coins/recommended` | Recommended tokens |
| `GET https://frontend-api-v3.pump.fun/coins/new?limit=N` | New tokens |
| `GET https://frontend-api-v3.pump.fun/coins/graduating?limit=N` | Near graduation |
| `GET https://pump.fun/api/coins/live` | Live feed of token activity |

**All endpoints return JSON.** The response shape includes fields listed in the Token Analysis section above.

## Safety Guidelines

Read the full `references/SAFETY.md` — but here are the non-negotiables:

1. **NEVER share your private key or seed phrase** with anyone or any website
2. **Always dry-run first** (`--dry-run`) on any trade
3. **Set slippage** appropriately (10-25% for meme coins, higher for low-liquidity)
4. **Check if a token is banned** (`is_banned` field) or has red flags
5. **Verify the mint address** — don't trust links, always verify on-chain
6. **Don't launch from your main wallet** — use a dedicated launch wallet
7. **Expect snipers** — new tokens get botted within seconds
8. **Use a private RPC** for trading (public RPCs get front-run)
9. **Beware of "free token" scams** in pump.fun comments
10. **Graduated tokens on AMM** can have additional scam vectors (honeypots, rug pulls)

## Bonding Curve Deep Dive

See `references/BONDING-CURVE.md` for the full math. TL;DR:

- Price increases along the curve as more tokens are bought
- Early buyers get the best prices
- The curve is fully transparent — anyone can calculate the exact price
- Graduation happens when real SOL reserves indicate ~$69K market cap
- After graduation, the token moves to PumpSwap AMM with the accumulated liquidity

## Common Workflows for AI Agents

### Workflow 1: Token Research Agent

```
1. Get trending tokens → `pumpfun tokens trending --limit 50`
2. Filter by market cap, age, creator reputation
3. Get detailed info on promising tokens → `pumpfun info <MINT>`
4. Check if graduated, banned, NSFW
5. Estimate entry price from bonding curve
6. Produce analysis report
```

### Workflow 2: Trading Agent

```
1. Scan for new tokens → `pumpfun tokens new --limit 20`
2. Filter based on safety criteria
3. Simulate buy → `pumpfun buy <MINT> <AMOUNT> --dry-run`
4. Execute buy → `pumpfun buy <MINT> <AMOUNT> --slippage 20 --confirm`
5. Monitor position → `pumpfun info <MINT>`
6. Set sell conditions
7. Execute sell → `pumpfun sell <MINT> all --slippage 20 --confirm`
8. Verify → `pumpfun tx-status <SIGNATURE>`
```

### Workflow 3: Market Analysis Agent

```
1. Fetch trending + new + graduating tokens
2. Cross-reference with social signals (X/Twitter mentions)
3. Identify patterns (same creator launching repeatedly, copycats)
4. Identify King of the Hill candidates
5. Generate market summary
```

## Agent Platform Notes

### Hermes Agent
Load this skill: `/skill pumpfun-agent-skill` or `hermes -s pumpfun-agent-skill`
Enable terminal tools: `hermes tools enable terminal`
Install `uv` and `pumpfun-cli` first.

### Claude Code
Reference this skill file in your CLAUDE.md or project root:
```markdown
# Skills
- `pumpfun-agent-skill/SKILL.md` — pump.fun research and trading
```
Install `uv` + `pumpfun-cli` in the environment.

### OpenAI Codex
Include the skill instructions in your system prompt or reference the markdown file.
Use the `pumpfun` CLI via terminal/command execution.

### OpenClaw
Load via Agent Skills standard:
```
npx skills add ardha27/pumpfun-agent-skill
```
Or paste the GitHub link in chat.

## Additional Resources

- [pump.fun Website](https://pump.fun)
- [pumpfun-cli](https://github.com/chainstacklabs/pumpfun-cli) — standalone CLI tool
- [pumpclaw](https://github.com/chainstacklabs/pumpclaw) — original agent skill for pump.fun
- [Chainstack Guide: Creating a pump.fun bot](https://docs.chainstack.com/docs/solana-creating-a-pumpfun-bot)
- [Solana Developer Docs](https://solana.com/docs)
- [Bonding Curve Economics](https://en.wikipedia.org/wiki/Bonding_curve)
