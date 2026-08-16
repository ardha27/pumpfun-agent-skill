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

Load full docs: `skill_view(name='pumpfun-agent-skill')`
GitHub: https://github.com/ardha27/pumpfun-agent-skill

## Quick Reference

```bash
# Prerequisites
uv tool install git+https://github.com/chainstacklabs/pumpfun-cli.git

# Token discovery (no wallet needed)
pumpfun tokens trending --limit 10
pumpfun tokens new --limit 10
pumpfun tokens graduating --limit 10
pumpfun tokens search "pepe"

# Trading (needs RPC + wallet)
pumpfun config set rpc <URL>
pumpfun wallet create
pumpfun buy <MINT> 0.1 --dry-run
pumpfun buy <MINT> 0.1 --slippage 20 --confirm
pumpfun sell <MINT> all --slippage 20 --confirm
pumpfun tx-status <SIG>

# Token launch
pumpfun launch --name "MyToken" --ticker "MTK" --desc "..."

# Info
pumpfun info <MINT>
pumpfun wallet balance
```

## Key Concepts

- **Bonding curve**: Deterministic price algorithm. Price = virtual_sol_reserves / virtual_token_reserves
- **Graduation**: Token hits ~$69K MC → migrates from curve to PumpSwap AMM
- **King of the Hill**: First token daily to reach $69K → featured
- **Virtual reserves**: Curve's internal accounting (~30 SOL + 1Q tokens)
- **Program ID**: `6EF8rrecthR5Dkzon8Nwu78hRvfCKubJ14M5uBEwF6P`

## Safety

1. Always `--dry-run` first
2. Check `is_banned` field
3. Use private RPC (avoid front-running)
4. Never share private keys
5. Launch from dedicated wallet only

## References

- `references/OPERATIONS.md` — full CLI reference
- `references/SAFETY.md` — trading safety guidelines
- `references/BONDING-CURVE.md` — bonding curve math
- `references/LIFECYCLE.md` — token lifecycle
- `scripts/check-setup.sh` — verify prerequisites
