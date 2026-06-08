# Pump.fun Operations Reference

Complete CLI reference for `pumpfun` — the tool that powers this skill.

## Token Discovery (Zero Config — No Wallet, No RPC)

| Command | Description |
|---------|-------------|
| `pumpfun tokens trending --limit N` | Top runners + recommended |
| `pumpfun tokens new --limit N` | Recently launched |
| `pumpfun tokens graduating --limit N` | Near bonding curve completion |
| `pumpfun tokens recommended` | Recommended by pump.fun |
| `pumpfun tokens search <query>` | Search by name or ticker |

All support `--json` flag for machine-readable output.

## Token Info (Needs RPC)

| Command | Description |
|---------|-------------|
| `pumpfun info <mint>` | Price, bonding progress, reserves, graduation status |

## Trading (Needs RPC + Wallet)

### Buy
```bash
pumpfun buy <mint> <sol_amount> [--slippage N] [--dry-run] [--confirm]
```
- `sol_amount`: SOL amount to spend (e.g., 0.5)
- `--slippage N`: Slippage tolerance in percent (default: 25)
- `--dry-run`: Simulate without sending transaction
- `--confirm`: Wait for transaction confirmation

### Sell
```bash
pumpfun sell <mint> <amount|all> [--slippage N] [--dry-run] [--confirm]
```
- `amount`: Number of tokens to sell, or `all`
- `--slippage N`: Slippage tolerance in percent (default: 25)
- `--dry-run`: Simulate without sending transaction
- `--confirm`: Wait for transaction confirmation

### Migration
```bash
pumpfun migrate <mint> [--slippage N] [--confirm]
```
Migrate bonding curve position to PumpSwap AMM after graduation.

### Cashback & Fees
```bash
pumpfun claim-cashback <mint> [--confirm]
pumpfun collect-creator-fee <mint> [--confirm]
pumpfun close-volume-acc <mint> [--confirm]
```

## Transaction Verification

```bash
pumpfun tx-status <signature>
```
Returns: confirmation status, slot, fee, any errors.

## Token Launch (Needs RPC + Wallet)

```bash
pumpfun launch \
  --name <NAME> \
  --ticker <TICKER> \
  --desc <DESCRIPTION> \
  [--image <PATH>] \
  [--buy <SOL_AMOUNT>]
```

- `--name`: Token name (required)
- `--ticker`: Token symbol/ticker (required)
- `--desc`: Token description (required)
- `--image`: Path to token image (optional)
- `--buy`: SOL amount to buy at launch (optional)

## Wallet Management

| Command | Description |
|---------|-------------|
| `pumpfun wallet create` | Generate + encrypt keypair |
| `pumpfun wallet import <keypair.json>` | Import existing keypair |
| `pumpfun wallet show` | Display public key |
| `pumpfun wallet balance` | SOL + token balances |
| `pumpfun wallet transfer <to> <amount>` | Transfer SOL |
| `pumpfun wallet transfer <to> <amount> --mint <MINT>` | Transfer SPL tokens |
| `pumpfun wallet drain <recipient>` | Close all ATAs + transfer remaining SOL |
| `pumpfun wallet export --output <path>` | Export as Solana keypair JSON |

## Configuration

| Command | Description |
|---------|-------------|
| `pumpfun config set <key> <value>` | Set config value |
| `pumpfun config get <key>` | Get config value |
| `pumpfun config list` | List all config |

### Config Keys
- `rpc` — Solana RPC endpoint URL
- `priority_fee` — Priority fee in micro-lamports
- `compute_units` — Compute unit limit

## Global Flags

| Flag | Description |
|------|-------------|
| `--version` | Show version and exit |
| `--json` | Machine-readable JSON output |
| `--rpc <url>` | Override RPC endpoint |
| `--keyfile <path>` | Override wallet keystore path |
| `--priority-fee <N>` | Priority fee in micro-lamports |
| `--compute-units <N>` | Compute unit limit |

## Direct HTTP API Reference

These are the underlying endpoints `pumpfun-cli` calls under the hood:

### Trending
```
GET https://frontend-api-v3.pump.fun/coins/top-runners?limit={n}&includeNsfw=false
```

### Recommended
```
GET https://frontend-api-v3.pump.fun/coins/recommended
```

### New tokens
```
GET https://frontend-api-v3.pump.fun/coins/new?limit={n}&includeNsfw=false
```

### Graduating
```
GET https://frontend-api-v3.pump.fun/coins/graduating?limit={n}&includeNsfw=false
```

### Live feed
```
GET https://pump.fun/api/coins/live
```

### Search
```
GET https://frontend-api-v3.pump.fun/coins/search?q={query}
```

## Response Shape

```json
{
  "mint": "string (token address)",
  "name": "string",
  "symbol": "string",
  "description": "string",
  "image_uri": "string (IPFS URL)",
  "metadata_uri": "string (IPFS URL)",
  "twitter": "string (optional)",
  "telegram": "string (optional)",
  "website": "string (optional)",
  "bonding_curve": "string (PDA address)",
  "associated_bonding_curve": "string (ATA address)",
  "creator": "string (wallet address)",
  "created_timestamp": "number (epoch ms)",
  "complete": "boolean (graduated?)",
  "virtual_sol_reserves": "number",
  "virtual_token_reserves": "number",
  "total_supply": "number",
  "real_sol_reserves": "number",
  "real_token_reserves": "number",
  "usd_market_cap": "number",
  "ath_market_cap": "number",
  "king_of_the_hill_timestamp": "number (optional)",
  "reply_count": "number",
  "is_banned": "boolean",
  "nsfw": "boolean",
  "pump_swap_pool": "string (optional, if graduated)",
  "token_program": "string (TokenkegQ... or TokenzQdBNb...)"
}
```
