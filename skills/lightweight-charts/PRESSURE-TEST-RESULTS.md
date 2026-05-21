# Pressure test results

Skill: `skills/lightweight-charts/` (Tier 2 hybrid, v5.2)

## Baseline (no skill)

Typical agent failures without curated guidance:

- Uses `setData()` on every websocket tick
- Leaves charts mounted without `chart.remove()` after route change
- Calls `createChart` in Server Components / SSR
- Uses v4 `addCandlestickSeries` after package upgrade
- Blank chart: container has `width: 100%` but no `height`

## GREEN — Scenario 1 (React + live price)

**Prompt:** Add a React candlestick chart with live price updates every second.

**Expected agent behavior with skill:**

- Decision tree → `references/react/integration.md` + `references/realtime/streaming.md`
- `'use client'`, `chart.addSeries(CandlestickSeries)`, initial `setData`, ticks via `series.update`
- `chart.remove()` + ResizeObserver cleanup in effect teardown

**Result:** PASS — SKILL workflow steps 1–7; integration.md has full example; streaming.md documents update-only hot path; gotchas forbids setData per tick.

## GREEN — Scenario 2 (blank chart)

**Prompt:** My Lightweight Charts chart is completely blank. Fix it.

**Expected:** Container height/width, `lifecycle-resize.md`

**Result:** PASS — Decision tree routes to `lifecycle-resize.md`; gotchas "zero height"; workflow step 2.

## GREEN — Scenario 3 (v4 upgrade)

**Prompt:** Migrate from addCandlestickSeries to new API.

**Expected:** v5-only, `addSeries(CandlestickSeries)`, no v4 as supported

**Result:** PASS — gotchas + SKILL "When NOT to use" + chart-and-series.md v5 examples.

## GREEN — Scenario 4 (custom heatmap)

**Prompt:** Heatmap series on lightweight chart.

**Expected:** `plugins/custom-series.md`, `addCustomSeries` / `ICustomSeriesPaneView`

**Result:** PASS — Decision tree custom branch; triggers include `addCustomSeries`; plugin reference has skeleton.

## GREEN — Scenario 5 (Next.js App Router)

**Prompt:** Add price chart page in Next.js App Router.

**Expected:** `'use client'`, no createChart in Server Component

**Result:** PASS — react/integration.md Next.js section; gotchas Environment; workflow step 1.

## REFACTOR

No scenario failures; no reference edits required after GREEN pass.
