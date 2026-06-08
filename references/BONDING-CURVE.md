# Pump.fun Bonding Curve Math

> Understanding how pricing works on pump.fun's bonding curve.

## The Core Equation

pump.fun uses a **constant product bonding curve** — similar to Uniswap-style AMMs but with virtual reserves.

The price formula is:

```
price_per_token (in SOL) = virtual_sol_reserves / virtual_token_reserves
```

Market cap in SOL:
```
market_cap_sol = total_supply × price_per_token
```

## Initial State

When a token is created:

| Parameter | Value |
|-----------|-------|
| `virtual_sol_reserves` | ~30 SOL (30,000,000,000 lamports) |
| `virtual_token_reserves` | ~1,000,000,000,000,000 tokens (1 quadrillion) |
| `total_supply` | 1,000,000,000,000,000 (1 quadrillion) |
| `initial_price` | 30 / 1e15 = 0.00000000003 SOL per token |
| `initial_market_cap` | 30 SOL (~$5,250 at $175/SOL) |

## How Trades Affect the Curve

### Buy (sending SOL, receiving tokens)

When you buy, SOL enters the real reserves. The curve calculates how many tokens you receive:

```
k = virtual_sol_reserves × virtual_token_reserves  (constant product)

After buy:
new_virtual_sol_reserves = virtual_sol_reserves + SOL_INPUT
new_virtual_token_reserves = k / new_virtual_sol_reserves
tokens_received = virtual_token_reserves - new_virtual_token_reserves
```

### Sell (sending tokens, receiving SOL)

When you sell, tokens enter the real reserves. The curve calculates SOL returned:

```
After sell:
new_virtual_token_reserves = virtual_token_reserves + TOKEN_INPUT
new_virtual_sol_reserves = k / new_virtual_token_reserves
sol_received = virtual_sol_reserves - new_virtual_sol_reserves
```

## Virtual vs Real Reserves

This is critical to understand:

| Reserve Type | Purpose |
|-------------|---------|
| **Virtual SOL reserves** | What the curve uses for price calculation. Starts at 30 SOL. |
| **Real SOL reserves** | Actual SOL deposited by buyers. Always less than virtual. |
| **Virtual token reserves** | What the curve uses for price calculation. Starts at 1Q. |
| **Real token reserves** | Actual tokens still in the curve. Always less than virtual. |

The difference between virtual and real reserves represents:
- The **curve fee** (a portion of each trade goes to the platform)
- The **initial virtual liquidity** that bootstraps the curve

## Graduation

The curve "completes" (graduates) when the market cap in real reserves reaches approximately **$69,000 USD**.

At this point:
1. The bonding curve freezes
2. Accumulated SOL liquidity is migrated to PumpSwap AMM
3. Token becomes a standard SPL token on the AMM
4. Trading continues on the AMM instead of the curve

Signs a token is near graduation:
- `virtual_sol_reserves` approaching ~700+ SOL
- `usd_market_cap` approaching $60K-$69K
- High trading volume

## Price Impact

Since pump.fun uses a bonding curve (not an order book), large trades have significant price impact:

```
price_impact ≈ (trade_size / current_liquidity) × price
```

For small market cap tokens (<$10K), even a 1 SOL buy can move price 10-20%.

## Practical Example

**Token at $50K market cap:**
- `virtual_sol_reserves`: ~285 SOL
- `virtual_token_reserves`: ~571 quadrillion tokens (after trades)
- Current price: 285 / 571e15 = 0.000000000499 SOL
- If you buy 1 SOL: approximately 2 quadrillion tokens received, price becomes ~286 / 569e15

The earlier you buy, the better the price — but also the higher the risk.

## Key Takeaways

1. **Early buyers get best prices** — the curve is designed to reward early entrants
2. **Price increases deterministically** — no order book manipulation on the curve
3. **Virtual reserves keep the curve liquid** even if real reserves are low
4. **Graduation is automatic** — once $69K market cap is hit, the token migrates
5. **After graduation**, price discovery happens on PumpSwap AMM (order book style)
