# Lightweight Charts — hard rules

Agents routinely skip these under time pressure. **Do not.**

## Data updates

**Do NOT call `setData()` on every tick or websocket message.**

- **Because:** `setData` replaces the entire series; the library warns this hurts performance for streaming.
- **Do instead:** `series.update(bar)` to revise the last bar or append a new one. See `references/core/data-and-time.md` and `references/realtime/streaming.md`.

**Do NOT use v4 API names** (`addCandlestickSeries`, `addLineSeries`, etc.).

- **Because:** This skill is **v5 only** — use `chart.addSeries(CandlestickSeries, options)`.
- **Do instead:** Import series constructors from `lightweight-charts`.

## Lifecycle

**Do NOT leave charts mounted after navigation without `chart.remove()`.**

- **Because:** Canvas, listeners, and resize observers leak; ghost charts cause duplicate feeds.
- **Do instead:** Call `chart.remove()` in `useEffect` cleanup, route leave, or SPA unmount.

**Do NOT create a chart when the container has zero height.**

- **Because:** The chart renders invisibly; users report "blank chart" bugs.
- **Do instead:** Set explicit `height` on the container (CSS or chart options) and width from layout.

## Environment

**Do NOT call `createChart` in Node.js, SSR, or React Server Components.**

- **Because:** Lightweight Charts is **client-only** (ES2020 browser library).
- **Do instead:** `'use client'` boundary (Next.js) or dynamic import after mount; guard with `typeof window !== 'undefined'` if needed.

## Data integrity

**Do NOT pass unsorted or duplicate time keys in `setData`.**

- **Because:** Time scale and series expect **ascending** unique times.
- **Do instead:** Sort by `time` before `setData`; use `update` for live revisions.

## React Strict Mode

**Do NOT assume effect cleanup order matches creation order in nested Chart/Series components.**

- **Because:** Child effects can run before parent; series may attach to a removed chart.
- **Do instead:** Use ref + Context pattern from official advanced tutorial; set `isRemoved` on chart ref before `remove()`. See `references/react/integration.md`.

## License

**Do NOT ship public apps without TradingView attribution.**

- **Because:** License requires NOTICE text and link to https://www.tradingview.com on public pages.
- **Do instead:** Add attribution in app footer or about page per [getting started](https://tradingview.github.io/lightweight-charts/docs).
