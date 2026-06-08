# CLAUDE.md — Agent Instructions

This file helps Claude Code (and any AI agent) understand this project.

## Project

**pumpfun-agent-skill** — equip AI agents with knowledge to research, analyze, and trade on [pump.fun](https://pump.fun), the memecoin launchpad on Solana.

## Key files

| File | What it's for |
|------|---------------|
| `SKILL.md` | Main skill file — load this first |
| `README.md` | User-facing intro and quickstart |
| `references/OPERATIONS.md` | All CLI commands and flags |
| `references/SAFETY.md` | Trading safety and scam prevention |
| `references/BONDING-CURVE.md` | Bonding curve math |
| `references/LIFECYCLE.md` | Token lifecycle |
| `scripts/check-setup.sh` | Verify prerequisites |

## Agent behavior when using this skill

1. **Default to read-only** — scan, analyze, research before suggesting trades
2. **Always dry-run** — simulate any trade before real execution
3. **Show reasoning** — explain metrics and decision logic
4. **Flag risks** — check `is_banned`, `nsfw`, creator history
5. **Never expose private keys** — in any output or log

## Tech stack

- `pumpfun-cli` (Python CLI via `uv tool install`)
- Solana RPC + wallets (on-chain interaction)
- pump.fun public REST API (token discovery)
- Shell scripts (prerequisite checks)
