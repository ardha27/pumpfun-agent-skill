<p align="center">
  <img src="https://pump.fun/pump-logomark.svg" alt="pumpfun-agent-skill" width="80" />
</p>

<h1 align="center">pumpfun-agent-skill</h1>

<p align="center">
  <b>Equip AI agents to research, analyze, and trade on pump.fun</b><br />
  The memecoin launchpad on Solana — bonding curve mechanics, token discovery, trading, and launch.
</p>

<p align="center">
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square" /></a>
  <a href="#agent-compatibility"><img alt="Agents" src="https://img.shields.io/badge/agents-7%20backends-111?style=flat-square" /></a>
  <a href="#references"><img alt="Docs" src="https://img.shields.io/badge/references-5%20guides-3ce6ac?style=flat-square" /></a>
  <a href="#quick-start"><img alt="Quickstart" src="https://img.shields.io/badge/quickstart-3%20commands-22a34a?style=flat-square" /></a>
  <a href="https://github.com/ardha27/pumpfun-agent-skill"><img alt="GitHub" src="https://img.shields.io/badge/github-repo-181717?style=flat-square&logo=github" /></a>
</p>

<p align="center">
  <a href="README.md"><b>English</b></a>
</p>

---

## Agent compatibility

Works with any AI agent that can read markdown and execute shell commands:

| Agent | How to load |
|-------|-------------|
| **Hermes** | `/skill pumpfun-agent-skill` or `hermes -s pumpfun-agent-skill` |
| **Claude Code** | Add `pumpfun-agent-skill/SKILL.md` to `CLAUDE.md` |
| **OpenAI Codex** | Reference `SKILL.md` in project context |
| **OpenClaw** | `npx skills add ardha27/pumpfun-agent-skill` |
| **Cursor** | Add to `.cursorrules` |
| **Windsurf / Trae** | Reference in project instructions |
| **Cline / Aider / Copilot** | Include in agent/system prompt |

---

## Quick start

```bash
# 1. Install prerequisites
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install git+https://github.com/chainstacklabs/pumpfun-cli.git

# 2. Verify setup
bash scripts/check-setup.sh

# 3. Explore tokens (no wallet, no RPC needed)
pumpfun tokens trending --limit 10
pumpfun tokens search "pepe"

# 4. Configure for trading
pumpfun config set rpc https://api.mainnet-beta.solana.com
pumpfun wallet create
pumpfun wallet balance

# 5. Simulate a trade (dry-run — no real TX)
pumpfun buy <TOKEN_MINT> 0.1 --dry-run
```

---

## What this skill covers

| Area | Details |
|------|---------|
| **Platform mechanics** | Bonding curve, virtual reserves, graduation, King of the Hill |
| **Token discovery** | Trending, new, graduating, search — zero config, no wallet needed |
| **Token analysis** | Market cap, bonding progress, creator history, social signals |
| **Trading** | Buy, sell, migrate, dry-run, slippage, confirmation |
| **Token launch** | Create and launch tokens with metadata and image |
| **Wallet management** | Create, import, balance, transfer, drain |
| **Bonding curve math** | Price formula, virtual vs real reserves, price impact |
| **Safety** | Scam detection, red flags, risk management, agent guardrails |
| **API reference** | Direct HTTP endpoints (no CLI) |

---

## Platform essentials

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│   Token Created → Bonding Curve → ~$69K MC → Graduation      │
│   (1Q supply)    (tradeable)    (KOTH)     (PumpSwap AMM)    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

| Concept | Description |
|---------|-------------|
| **Bonding curve** | Price = `virtual_sol_reserves / virtual_token_reserves`. Deterministic — buy pressure pushes price up. |
| **Virtual reserves** | Curve's internal accounting (~30 SOL + 1 quadrillion tokens). Ensures liquidity even with few trades. |
| **Graduation** | Token hits ~$69K market cap → bonding curve freezes → liquidity migrates to PumpSwap AMM. |
| **King of the Hill** | First token each day to reach $69K gets featured on homepage. |
| **Total supply** | 1,000,000,000,000,000 (1 quadrillion), 6 decimals. |
| **Program ID** | `6EF8rrecthR5Dkzon8Nwu78hRvfCKubJ14M5uBEwF6P` |

---

## Agent workflows

### 🔍 Token research agent

```bash
# Scan trending → deep dive → filter → report
pumpfun tokens trending --limit 50 --json
pumpfun info <MINT>
# Check: market cap, age, creator wallet, is_banned, social links
```

### 🤖 Trading agent

```bash
# Scan → filter → simulate → execute → verify
pumpfun tokens new --limit 20
pumpfun buy <MINT> 0.1 --dry-run
pumpfun buy <MINT> 0.1 --slippage 20 --confirm
pumpfun tx-status <SIGNATURE>
```

### 📊 Market analysis agent

```bash
# Cross-reference on-chain data
pumpfun tokens trending --json
pumpfun tokens graduating --json
# Identify KOTH candidates, detect creator patterns, trend analysis
```

---

## Safety

> **⚠️ Memecoin trading is extremely high risk.** Most pump.fun tokens go to zero. Trade only what you can afford to lose.

1. **Always dry-run** — `--dry-run` before every real trade
2. **Private RPC** — public endpoints get front-run by bots
3. **Check `is_banned`** — skip flagged tokens
4. **Never share private keys** — no legitimate tool asks for your seed phrase
5. **Launch from dedicated wallet** — never your main wallet
6. **Slippage matters** — 10-25% for memecoins, higher for low-liquidity

Full guide: [`references/SAFETY.md`](references/SAFETY.md)

---

## References

| Guide | Contents |
|-------|----------|
| [`SKILL.md`](SKILL.md) | Main skill file — full agent knowledge base |
| [`references/OPERATIONS.md`](references/OPERATIONS.md) | Complete CLI reference with all flags |
| [`references/SAFETY.md`](references/SAFETY.md) | Trading safety & scam prevention |
| [`references/BONDING-CURVE.md`](references/BONDING-CURVE.md) | Bonding curve math explained |
| [`references/LIFECYCLE.md`](references/LIFECYCLE.md) | Token lifecycle from birth to AMM |

---

## Public API endpoints

Token discovery without any CLI tool:

```bash
curl -s "https://frontend-api-v3.pump.fun/coins/top-runners?limit=5"
curl -s "https://frontend-api-v3.pump.fun/coins/new?limit=5"
curl -s "https://frontend-api-v3.pump.fun/coins/graduating?limit=5"
curl -s "https://frontend-api-v3.pump.fun/coins/recommended"
curl -s "https://pump.fun/api/coins/live"
```

---

## Related projects

- [pumpfun-cli](https://github.com/chainstacklabs/pumpfun-cli) — The CLI tool this skill wraps
- [pumpclaw](https://github.com/chainstacklabs/pumpclaw) — Original agent skill (inspiration)
- [pumpfun-bot](https://github.com/chainstacklabs/pumpfun-bonkfun-bot) — Python trading bot
- [pump.fun](https://pump.fun) — The platform

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). PRs welcome!

## License

[MIT](LICENSE) © 2026 ardha27
