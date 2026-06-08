# Pump.fun Token Lifecycle

> Visual guide to a token's journey from creation to graduation.

## Stage 1: Token Creation

**What happens:**
1. Creator pays a small fee (in SOL)
2. Token is created with 1 quadrillion supply, 6 decimals
3. Metadata (name, ticker, description, image) is uploaded to IPFS via Pinata
4. Bonding curve is initialized with virtual reserves
5. Token appears on pump.fun's "new" list

**Agent actions:** Scan `pumpfun tokens new` for interesting launches

```
┌─────────────────┐
│  Token Created   │
│  - Name, Ticker  │
│  - Description   │
│  - Image (IPFS)  │
│  - Social links  │
│  - 1Q supply     │
└────────┬────────┘
         │
         ▼
```

## Stage 2: Bonding Curve Trading

**What happens:**
1. Token is tradeable immediately on the bonding curve
2. No liquidity pools to seed — curve handles everything
3. Price is fully transparent and deterministic
4. Anyone can buy or sell at any time
5. Early buyers get the best prices

**Agent actions:** Monitor trending, analyze token metrics, execute trades

```
┌──────────────────────┐
│  Bonding Curve Active │
│  - Buy/Sell enabled   │
│  - Deterministic price│
│  - Virtual reserves   │
│  - Real reserves grow │
│    with each trade    │
└────────┬──────────────┘
         │
         │ Market cap increases
         │ with each buy
         ▼
```

## Stage 3: King of the Hill

**What happens:**
1. First token each day to reach ~$69K market cap
2. Gets featured/promoted on pump.fun homepage
3. Often sees massive volume spike
4. Does NOT affect the bonding curve mechanics

**Agent actions:** Identify candidates before they hit, watch for KOTH announcements

```
┌─────────────────────────────────┐
│  King of the Hill (optional)    │
│  - First to $69K each day       │
│  - Featured on homepage         │
│  - Volume spike expected        │
└────────┬────────────────────────┘
         │
         │ Continuous trading
         ▼
```

## Stage 4: Graduation

**What happens:**
1. Market cap hits ~$69K on the bonding curve
2. Bonding curve freezes (no more buy/sell on curve)
3. Accumulated SOL liquidity migrates to PumpSwap AMM
4. Token becomes a standard SPL token
5. Trading continues on the AMM
6. `complete` field becomes `true`
7. `pump_swap_pool` address is set

**Agent actions:** 
- If holding, migrate position: `pumpfun migrate <MINT>`
- If not holding, decide whether to trade on AMM

```
┌──────────────────────────┐
│      Graduation! 🎉      │
│  1. Curve freezes         │
│  2. Liquidity migrates    │
│  3. AMM trading begins    │
│  4. complete = true       │
└────────┬──────────────────┘
         │
         ▼
```

## Stage 5: AMM Trading (Post-Graduation)

**What happens:**
1. Token trades on PumpSwap AMM (formerly Raydium)
2. Standard constant product AMM mechanics
3. Liquidity pool with SOL (from accumulated curve liquidity)
4. Creator can add/remove LP (risk of rug pull)
5. Token behaves like any other SPL token

**Agent actions:** Standard Solana DEX trading patterns

```
┌──────────────────────┐
│  PumpSwap AMM        │
│  - Order book style  │
│  - LP exists         │
│  - Standard SPL      │
│  - Rug pull risk     │
└──────────────────────┘
```

## Timeline

| Stage | Duration | Market Cap |
|-------|----------|------------|
| Creation | Instant | ~$5K (initial) |
| Bonding Curve | Hours to days (if popular) | $5K → $69K |
| KOTH | ~1 day (first token) | $69K+ |
| Graduation | Momentary | $69K |
| AMM Trading | Indefinite | $69K+ (or drops) |

## Creator Actions Timeline

| Time | Action |
|------|--------|
| Launch | Coin created, bonding curve active |
| Early | Creator may buy to jumpstart the curve |
| Mid | Creator may shill on Twitter/Telegram |
| Graduation | Creator can migrate liquidity |
| Post-graduation | Creator can add/remove LP tokens |

## Common Token Outcomes

1. **Dead on arrival** — Most tokens. 0 trades after launch.
2. **Pump and dump** — Quick price spike then crash. Common.
3. **Graduation then dump** — Graduates, then creator or whales dump.
4. **Sustained growth** — Rare. Token builds real community.
5. **Rug pull** — Creator drains liquidity after graduation.

## Key Signals by Stage

### Early (Bonding Curve)
- Creator wallet age and history
- Social links present and active
- Low reply count usually means organic

### Mid (Curve Trading)
- Increasing trade volume
- Growing reply count
- New holders (varied wallet types)
- Twitter activity

### Late (Near Graduation)
- Rapid price increase
- FOMO buying
- `virtual_sol_reserves` rising fast
- High social media attention

### Post-Graduation
- Liquidity pool depth
- Creator token holdings
- Holder distribution
- Developer activity on social
