# Pump.fun Safety Guidelines

> **⚠️ Memecoin trading on pump.fun is extremely high risk.** Most tokens lose value within hours of launch. This guide helps you and your AI agent trade responsibly.

## Non-Negotiables

### 1. Private Keys Never Leave Your Machine

No legitimate tool — including `pumpfun-cli` — asks for your seed phrase or private key. If a website, script, or person asks for your private key, it's a scam.

- Keys are stored locally in `~/.config/pumpfun/keystores/`
- Never paste your keypair JSON into a website
- Never share your seed phrase (12/24 words)

### 2. Always Dry-Run First

```bash
pumpfun buy <MINT> 0.1 --dry-run
pumpfun sell <MINT> all --dry-run
```

Dry-run simulates the transaction locally without sending it. It shows you the expected output before you commit real funds.

### 3. Set Slippage Appropriately

- **High volatility tokens**: 20-30% slippage
- **Low liquidity tokens**: 25-50% slippage (but beware of large price impact)
- **Graduated tokens on AMM**: 5-15% slippage
- **Never set slippage to 0%** — your transaction will almost certainly fail

### 4. Use a Private RPC

Public RPC endpoints (like `api.mainnet-beta.solana.com`) expose your pending transactions to MEV bots that can front-run you.

**Recommended providers:**
- [Helius](https://helius.xyz) — free tier available
- [QuickNode](https://quicknode.com) — paid, fast
- [Chainstack](https://chainstack.com) — trader nodes with gRPC
- [Triton](https://triton.one) — Solana RPC provider

```bash
pumpfun config set rpc https://mainnet.helius-rpc.com/?api-key=YOUR_KEY
```

### 5. Launch from a Dedicated Wallet

Never launch tokens from your main wallet. Create a fresh wallet for each launch:

```bash
pumpfun wallet create
```

This protects your primary funds if the launch wallet is compromised or doxxed.

## Token Red Flags

### Immediate Red Flags (Skip These Tokens)

| Red Flag | How to Check |
|----------|-------------|
| `is_banned == true` | From token info API |
| `nsfw == true` | From token info API |
| Creator has launched 50+ tokens in 24h | Check creator's launch history |
| No social links (Twitter/Telegram/Website) | From token metadata |
| Description is empty or gibberish | From token metadata |
| Image is default/empty pump.fun image | Check `image_uri` |

### Suspicious Patterns

- **Same creator launching copies of popular tokens** — rug pattern
- **High reply count but no social proof** — bot comments
- **Instant graduation** — could indicate manipulation
- **Creator holds >90% of supply** after launch
- **No liquidity migration** after graduation (check if `pump_swap_pool` exists)

### Scam Vectors on pump.fun

1. **Comment section scams** — "Free tokens! Visit link:" → always fake
2. **Impersonation** — Fake accounts pretending to be the dev team
3. **Copycat tokens** — Same name/symbol as existing tokens but different mint
4. **Honeypot tokens** — You can buy but cannot sell (rare on bonding curve, possible after graduation)
5. **Rug pulls** — Creator dumps all tokens at once after graduation

## AI Agent Safety Rules

When your AI agent operates on pump.fun, enforce these rules:

### MUST DO
1. Verify `is_banned` is `false` before any interaction
2. Dry-run every trade before executing
3. Check that the mint address matches the token name/symbol (avoid copycats)
4. Use `--json` flag for programmatic analysis
5. Confirm transactions with `pumpfun tx-status` after execution

### MUST NOT DO
1. Never share or expose wallet private keys in any output
2. Never execute trades without user confirmation (builder mode)
3. Never interact with tokens flagged as banned or NSFW
4. Never launch tokens without user review of parameters
5. Never use user's main wallet for token launches

### DEFAULT AGENT BEHAVIOR

An AI agent using this skill should:
1. **Default to observation mode** — scan, analyze, research only
2. **Ask for user confirmation** before any trade or launch
3. **Always dry-run first** before asking user to confirm
4. **Explain the reasoning** — show metrics, not just execute
5. **Log all transactions** for audit trail

## Risk Management

- Never allocate more than you can afford to lose (memecoins are gambling)
- Diversify across tokens if you trade memecoins
- Take profits on the way up — memecoins rarely sustain price
- Set stop-loss mentality: decide your exit before you enter
- Beware of "certain winners" — if it sounds too good, it is

## Post-Trade Hygiene

```bash
# Verify transaction landed
pumpfun tx-status <SIGNATURE>

# Check your position
pumpfun info <MINT>

# Claim any cashback
pumpfun claim-cashback <MINT> --confirm

# If graduating, migrate position
pumpfun migrate <MINT> --slippage 10 --confirm
```

## Additional Resources

- [Solana Security Best Practices](https://solana.com/docs/security)
- [Rug Pull Detection Guide](https://docs.solana.com/developing/security)
- [Bonding Curve Risks](https://medium.com/@billyrennekamp/risks-of-bonding-curves-7e736ca09d1e)
