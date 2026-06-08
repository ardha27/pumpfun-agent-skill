# 🎯 Pump.fun Agent Skill

> Equip AI agents (Hermes, Claude Code, Codex, OpenClaw) to research, analyze, and trade on [pump.fun](https://pump.fun) — the memecoin launchpad on Solana.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Solana](https://img.shields.io/badge/Solana-9945FF?logo=solana&logoColor=white)](https://solana.com)

## Why This Exists

Pump.fun is the most active memecoin launchpad on Solana, with thousands of tokens launching daily. AI agents can be powerful tools for:

- **Token discovery** — scanning and filtering through thousands of tokens
- **Market analysis** — identifying patterns, trends, and outliers
- **Trading** — executing buys and sells with precise parameters
- **Risk assessment** — checking safety flags, creator history, and liquidity

This skill gives any AI agent the knowledge and tooling to do all of the above.

## What's Inside

```
pumpfun-agent-skill/
├── SKILL.md                    # Main skill file — what the agent loads
├── README.md                   # This file
├── references/
│   ├── OPERATIONS.md           # Complete CLI reference with all flags
│   ├── SAFETY.md               # Trading safety & scam prevention
│   ├── BONDING-CURVE.md        # Bonding curve math explained
│   └── LIFECYCLE.md            # Token lifecycle from birth to graduation
├── scripts/
│   └── check-setup.sh          # Verify prerequisites
└── assets/
    └── token-lifecycle.md      # Visual lifecycle reference
```

## Agent Compatibility

| Agent | How to Load |
|-------|------------|
| **Hermes** | `/skill pumpfun-agent-skill` or `hermes -s pumpfun-agent-skill` |
| **Claude Code** | Reference in `CLAUDE.md`: `pumpfun-agent-skill/SKILL.md` |
| **OpenAI Codex** | Add to project context or system prompt |
| **OpenClaw** | `npx skills add ardha27/pumpfun-agent-skill` |
| **Cursor** | Add `SKILL.md` path to `.cursorrules` |
| **Any ACP agent** | Include `SKILL.md` in agent instructions |

## Prerequisites

```bash
# 1. Install uv (fast Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# 2. Install pumpfun-cli (the tool this skill wraps)
uv tool install git+https://github.com/chainstacklabs/pumpfun-cli.git

# 3. Verify installation
pumpfun --version
```

### One-liner

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh && \
uv tool install git+https://github.com/chainstacklabs/pumpfun-cli.git && \
pumpfun --version
```

## Quick Start

```bash
# Token discovery (no wallet needed, no RPC needed)
pumpfun tokens trending --limit 10
pumpfun tokens search "pepe"

# Set up for trading
pumpfun config set rpc https://api.mainnet-beta.solana.com
pumpfun wallet create
pumpfun wallet balance

# Simulate a trade (dry-run — no real TX)
pumpfun buy <TOKEN_MINT> 0.1 --dry-run

# Execute
pumpfun buy <TOKEN_MINT> 0.1 --slippage 20 --confirm
pumpfun sell <TOKEN_MINT> all --slippage 20 --confirm

# Launch a token
pumpfun launch --name "MyToken" --ticker "MTK" --desc "A great token"
```

## Agent Workflows

### Token Research Agent
```bash
# What an AI agent should do:
pumpfun tokens trending --limit 50 --json     # Get data
pumpfun info <MINT>                            # Deep dive
# Then analyze: market cap, age, creator wallet, social links
```

### Trading Agent
```bash
# Scan → Filter → Simulate → Execute → Verify
pumpfun tokens new --limit 20
pumpfun buy <MINT> 0.1 --dry-run
pumpfun buy <MINT> 0.1 --slippage 20 --confirm
pumpfun tx-status <SIG>
```

### Market Analysis Agent
```bash
# Cross-reference on-chain data with social signals
pumpfun tokens trending --json
pumpfun tokens graduating --json
# Identify King of the Hill candidates
# Detect same-creator launch patterns
```

## Platform Essentials

| Metric | What It Means |
|--------|---------------|
| **Bonding Curve** | Price algorithm: buy pressure pushes price up deterministically |
| **Virtual Reserves** | Curve's internal accounting (30 SOL virtual, 1Q tokens virtual) |
| **Graduation** | Token hits ~$69K MC → migrates to PumpSwap AMM |
| **King of the Hill** | First token daily to reach $69K → featured on homepage |
| **Program ID** | `6EF8rrecthR5Dkzon8Nwu78hRvfCKubJ14M5uBEwF6P` |
| **Total Supply** | 1,000,000,000,000,000 (1 quadrillion) |

## API Endpoints (Public — No Auth)

```bash
# Direct HTTP access — wallet not needed
curl -s "https://frontend-api-v3.pump.fun/coins/top-runners?limit=5"
curl -s "https://frontend-api-v3.pump.fun/coins/new?limit=5"
curl -s "https://pump.fun/api/coins/live"
```

## Safety (Read This)

**⚠️ Memecoin trading is high risk.** Most tokens on pump.fun go to zero.

1. **Never share private keys** — no legitimate tool asks for your seed phrase
2. **Always dry-run** — use `--dry-run` before every real trade
3. **Use a private RPC** — public RPCs get front-run by bots
4. **Launch from a dedicated wallet** — never your main wallet
5. **Check `is_banned` flag** before interacting with any token
6. **Beware of comment section scams** — "free tokens" are always scams

Full safety guide: [`references/SAFETY.md`](references/SAFETY.md)

## Related Projects

- [pumpfun-cli](https://github.com/chainstacklabs/pumpfun-cli) — The CLI tool this skill wraps
- [pumpclaw](https://github.com/chainstacklabs/pumpclaw) — The original OpenClaw skill (inspiration)
- [pumpfun-bot](https://github.com/chainstacklabs/pumpfun-bonkfun-bot) — Python bot for pump.fun trading
- [pump.fun](https://pump.fun) — The platform itself

## Contributing

PRs welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT
