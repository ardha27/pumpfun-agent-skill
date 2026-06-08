# Pump.fun Token Lifecycle — Visual Reference

> A visual sequence diagram of a token's journey on pump.fun.

```
Time ─────────────────────────────────────────────────────────►

Stage 1          Stage 2              Stage 3           Stage 4         Stage 5
Creation     Bonding Curve         King of the Hill   Graduation     AMM Trading
─────────    ─────────────         ────────────────   ──────────     ───────────

  │              │                     │                  │              │
  │  Create      │  Trade on curve     │  First to        │  Curve       │  PumpSwap
  │  token       │  Price↑ as          │  $69K MC         │  freezes     │  AMM
  │  1Q supply   │  demand↑            │  Featured on     │  Liquidity   │  trading
  │  IPFS meta   │                     │  homepage        │  migrates    │  begins
  │              │                     │                  │              │
  ▼              ▼                     ▼                  ▼              ▼

  $5K MC        $5K → $69K MC        $69K+ MC           $69K MC       $69K+ MC
  0 trades      Increasing trades    Volume spike       Migration     Standard DEX
                                     Social buzz        complete      trading

Data Sources:
  tokens new    tokens trending      API: king_of_the_  complete =    pump_swap_
                tokens graduating    hill_timestamp     true          pool != null
```

## Key On-Chain Addresses

```
Pump.fun Program ID:  6EF8rrecthR5Dkzon8Nwu78hRvfCKubJ14M5uBEwF6P
Token Program:        TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb
SOL Mint:             So11111111111111111111111111111111111111112
```

## Quick Metric Reference

| Signal | What it means |
|--------|---------------|
| `complete: false` | Still on bonding curve |
| `complete: true` | Graduated to AMM |
| `pump_swap_pool` set | Graduation complete, pool exists |
| `king_of_the_hill_timestamp` set | Was KOTH winner |
| `is_banned: true` | Flagged by pump.fun — skip |
| `reply_count > 100` | Active chat (could be bots) |
| `usd_market_cap / ath_market_cap < 0.1` | Down 90% from ATH |
| `virtual_sol_reserves` rising | More SOL entering curve (bullish) |
