---
name: lightweight-charts
description: >-
  Use when building or debugging TradingView Lightweight Charts v5 in the
  browser: createChart, candlestick/line series, setData vs update, realtime
  ticks, resize/cleanup, React integration, custom series plugins, or
  time-scale issues.
metadata:
  category: reference
  triggers:
    - lightweight-charts
    - createChart
    - addSeries
    - CandlestickSeries
    - setData
    - series.update
    - chart.remove
    - ICustomSeriesPaneView
    - addCustomSeries
    - fitContent
    - time scale
    - TradingView chart
---

# Lightweight Charts v5

Client-side financial charts ([TradingView Lightweight Charts](https://tradingview.github.io/lightweight-charts/docs) **v5.x**). Curated guides live under `references/`; read `gotchas.md` before shipping.

## When to use

- Adding or fixing **candlestick, line, area, bar, histogram** charts in the browser
- **Realtime** price/volume updates (`update`, not `setData` per tick)
- **React** or **Next.js** chart mount/cleanup/resize issues
- **Custom series** / plugin indicators
- Debugging **blank chart**, **time axis**, or **memory leaks** after navigation

## When NOT to use

- **Server-side** chart rendering (library is browser-only)
- **v4 API** (`addCandlestickSeries`, etc.) — this skill is v5-only; see official migration externally
- Non-TradingView chart libraries (Chart.js, ECharts, etc.)

## Decision tree

```
Need a chart?
├─ React or Next.js? → references/react/integration.md
│  └─ else → references/core/chart-and-series.md
├─ Live / websocket data? → references/realtime/streaming.md
├─ Custom visualization not covered by built-in series? → references/plugins/custom-series.md
├─ Time format / setData vs update? → references/core/data-and-time.md
└─ Blank, resize, fitContent, remove? → references/core/lifecycle-resize.md
```

Always skim **`gotchas.md`** for the task at hand.

## Agent workflow

1. Confirm **`lightweight-charts` v5** in `package.json` and **client-only** execution (`'use client'` in Next.js).
2. Ensure chart **container has non-zero height** (`references/core/lifecycle-resize.md`).
3. `createChart(container, options)` then `chart.addSeries(SeriesConstructor, options)` (`references/core/chart-and-series.md`).
4. **Initial data:** sorted ascending → `series.setData(data)` → optional `chart.timeScale().fitContent()`.
5. **Streaming:** only `series.update(bar)` (`references/realtime/streaming.md`).
6. **Resize:** `ResizeObserver` or window listener → `chart.applyOptions({ width })`.
7. **Teardown:** `chart.remove()` on unmount.
8. **Public apps:** TradingView **attribution** (NOTICE + link to https://www.tradingview.com).

## Quick reference

| Topic | File |
| --- | --- |
| Index + official links | `references/readme.md` |
| Chart, series types, styling | `references/core/chart-and-series.md` |
| Time, setData, update | `references/core/data-and-time.md` |
| remove, resize, fitContent | `references/core/lifecycle-resize.md` |
| React / Next.js | `references/react/integration.md` |
| Live ticks | `references/realtime/streaming.md` |
| Custom series plugins | `references/plugins/custom-series.md` |
| Hard rules | `gotchas.md` |

## Minimal vanilla example

```js
import { createChart, CandlestickSeries } from 'lightweight-charts';

const el = document.getElementById('chart');
const chart = createChart(el, { width: el.clientWidth, height: 400 });
const series = chart.addSeries(CandlestickSeries);
series.setData(data);
chart.timeScale().fitContent();
// later: series.update(tick); on exit: chart.remove();
```

## Common mistakes

See **`gotchas.md`** — especially: no `setData` in hot paths, always `chart.remove()`, no SSR, v5 `addSeries` only.

## Limitations

- Does not mirror the full API; open the linked official page for option lists and plugin method signatures.
- Online docs may be newer than this skill; prefer official docs if versions disagree.
