# Lightweight Charts Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a Tier 2 hybrid agent skill at `skills/lightweight-charts/` for TradingView Lightweight Charts v5 (vanilla + React, realtime, plugins).

**Architecture:** Slim `SKILL.md` dispatcher with decision tree and agent workflow; curated `references/` for high-friction topics only; `gotchas.md` for anti-rationalization rules. Pattern follows `skills/intervention-image-v4/`.

**Tech Stack:** Markdown skill files only; examples use `lightweight-charts` npm v5.x (docs pinned to 5.2). No runtime code in this repo.

**Spec:** `docs/superpowers/specs/2026-05-21-lightweight-charts-design.md`

---

## File map (all under `skills/lightweight-charts/`)

| File | Responsibility |
|------|----------------|
| `SKILL.md` | CSO frontmatter, when to use, decision tree, workflow, index table |
| `gotchas.md` | Hard rules agents must not rationalize away |
| `references/readme.md` | Topic index + official v5.2 links |
| `references/core/chart-and-series.md` | `createChart`, `addSeries`, series types |
| `references/core/data-and-time.md` | Time formats, `setData` vs `update` |
| `references/core/lifecycle-resize.md` | `remove`, sizing, `fitContent`, resize |
| `references/react/integration.md` | Official React patterns, Next.js client boundary |
| `references/realtime/streaming.md` | Live `update` patterns |
| `references/plugins/custom-series.md` | Custom series plugin skeleton |

---

### Task 1: Scaffold directories

**Files:**
- Create: `skills/lightweight-charts/references/core/` (via mkdir)
- Create: `skills/lightweight-charts/references/react/`
- Create: `skills/lightweight-charts/references/realtime/`
- Create: `skills/lightweight-charts/references/plugins/`

- [ ] **Step 1: Create directory tree**

```bash
mkdir -p skills/lightweight-charts/references/{core,react,realtime,plugins}
```

- [ ] **Step 2: Verify structure**

```bash
find skills/lightweight-charts -type d | sort
```

Expected:

```
skills/lightweight-charts
skills/lightweight-charts/references
skills/lightweight-charts/references/core
skills/lightweight-charts/references/plugins
skills/lightweight-charts/references/react
skills/lightweight-charts/references/realtime
```

---

### Task 2: References index

**Files:**
- Create: `skills/lightweight-charts/references/readme.md`

- [ ] **Step 1: Write `references/readme.md`**

```markdown
# Lightweight Charts v5 — local references

Docs version: **5.2**. Full API: [official docs](https://tradingview.github.io/lightweight-charts/docs).

## When to read which file

| Situation | File |
| --- | --- |
| Create chart, pick series type, styling | `core/chart-and-series.md` |
| Time format errors, `setData` vs `update` | `core/data-and-time.md` |
| Blank chart, resize, teardown, `fitContent` | `core/lifecycle-resize.md` |
| React, Next.js client component | `react/integration.md` |
| Live ticks, websocket feed | `realtime/streaming.md` |
| Custom indicator / non-built-in series | `plugins/custom-series.md` |
| Rules you must not skip | `../gotchas.md` |

## Official links (v5.2)

- [Getting started](https://tradingview.github.io/lightweight-charts/docs)
- [Series types](https://tradingview.github.io/lightweight-charts/docs/series-types)
- [Time scale](https://tradingview.github.io/lightweight-charts/docs/time-scale)
- [Plugins](https://tradingview.github.io/lightweight-charts/docs/plugins/intro)
- [React simple tutorial](https://tradingview.github.io/lightweight-charts/tutorials/react/simple)
- [React advanced tutorial](https://tradingview.github.io/lightweight-charts/tutorials/react/advanced)
```

---

### Task 3: Gotchas (anti-rationalization)

**Files:**
- Create: `skills/lightweight-charts/gotchas.md`

- [ ] **Step 1: Write `gotchas.md`**

```markdown
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
```

---

### Task 4: Core — chart and series

**Files:**
- Create: `skills/lightweight-charts/references/core/chart-and-series.md`

- [ ] **Step 1: Write `references/core/chart-and-series.md`**

```markdown
# Chart and series (v5)

Read when: creating a chart, choosing a series type, or styling series/chart options.

Official: [Getting started](https://tradingview.github.io/lightweight-charts/docs) · [Series types](https://tradingview.github.io/lightweight-charts/docs/series-types)

## Install

```bash
npm install --save lightweight-charts
```

Client-only; targets ES2020 browsers.

## Minimal candlestick chart

```js
import { createChart, CandlestickSeries } from 'lightweight-charts';

const container = document.getElementById('container');
const chart = createChart(container, {
  width: container.clientWidth,
  height: 400,
  layout: {
    textColor: '#d1d4dc',
    background: { type: 'solid', color: '#131722' },
  },
});

const series = chart.addSeries(CandlestickSeries, {
  upColor: '#26a69a',
  downColor: '#ef5350',
  borderVisible: false,
  wickUpColor: '#26a69a',
  wickDownColor: '#ef5350',
});

series.setData([
  { time: '2018-12-22', open: 75.16, high: 82.84, low: 36.16, close: 45.72 },
  { time: '2018-12-23', open: 45.12, high: 53.9, low: 45.12, close: 48.09 },
]);

chart.timeScale().fitContent();
```

## Built-in series types

Import the constructor, then `chart.addSeries(Constructor, options)`:

| Constructor | Typical data shape |
| --- | --- |
| `LineSeries` | `{ time, value }` |
| `AreaSeries` | `{ time, value }` |
| `BarSeries` | `{ time, open, high, low, close }` |
| `BaselineSeries` | `{ time, value }` |
| `CandlestickSeries` | `{ time, open, high, low, close }` |
| `HistogramSeries` | `{ time, value, color? }` |

You **cannot** change a series type in place. Remove and add a new series:

```js
chart.removeSeries(oldSeries);
const newSeries = chart.addSeries(LineSeries, { color: '#2962FF' });
newSeries.setData(data);
```

## Options on the fly

```js
chart.applyOptions({ layout: { background: { type: 'solid', color: '#000' } } });
series.applyOptions({ upColor: 'red', downColor: 'blue' });
```

## Multiple series

```js
const volume = chart.addSeries(HistogramSeries, {
  color: '#26a69a',
  priceFormat: { type: 'volume' },
  priceScaleId: '', // overlay or separate scale per your layout
});
volume.setData(volumeData);
```

See official [SeriesStyleOptionsMap](https://tradingview.github.io/lightweight-charts/docs/api/interfaces/SeriesStyleOptionsMap) for all style keys.
```

---

### Task 5: Core — data and time

**Files:**
- Create: `skills/lightweight-charts/references/core/data-and-time.md`

- [ ] **Step 1: Write `references/core/data-and-time.md`**

```markdown
# Data and time (v5)

Read when: fixing time axis bugs, choosing `setData` vs `update`, or streaming data.

Official: [ISeriesApi.setData](https://tradingview.github.io/lightweight-charts/docs/api/interfaces/ISeriesApi#setdata) · [ISeriesApi.update](https://tradingview.github.io/lightweight-charts/docs/api/interfaces/ISeriesApi#update)

## Time formats

Two common shapes:

1. **Business day string:** `'2018-12-22'` (date-only bars)
2. **UTCTimestamp:** Unix seconds as **number**, e.g. `1642425322`

Do not mix formats arbitrarily within one series without understanding scale behavior. Data must be **strictly ascending** by `time`.

## Initial load: `setData`

Replaces **all** points. Use for first paint or full history refresh.

```js
series.setData(sortedAscendingData);
chart.timeScale().fitContent();
```

## Live data: `update` only

**Do not** call `setData` on each tick.

```js
// Revise the last bar (same time)
series.update({ time: '2018-12-31', open: 109.87, high: 114.69, low: 85.66, close: 112 });

// Append a new bar (new time)
series.update({ time: '2019-01-01', open: 112, high: 112, low: 100, close: 101 });
```

For line/area:

```js
series.update({ time: '2019-01-01', value: 20 });
```

## When full replace is OK

- User changed symbol / interval and you need a clean slate
- Batch backfill completed (hundreds+ points), not sub-second streaming

Even then, prefer one `setData` per batch, not per row in a loop.

## TypeScript

```ts
import type { UTCTimestamp } from 'lightweight-charts';

const t = 1642425322 as UTCTimestamp;
series.update({ time: t, value: 42 });
```
```

---

### Task 6: Core — lifecycle and resize

**Files:**
- Create: `skills/lightweight-charts/references/core/lifecycle-resize.md`

- [ ] **Step 1: Write `references/core/lifecycle-resize.md`**

```markdown
# Lifecycle and resize (v5)

Read when: chart is blank, does not resize, or leaks after route change.

Official: [Time scale](https://tradingview.github.io/lightweight-charts/docs/time-scale) · [IChartApi.remove](https://tradingview.github.io/lightweight-charts/docs/api/interfaces/IChartApi#remove)

## Container sizing

The chart needs a visible box:

```css
#container {
  width: 100%;
  height: 400px; /* required — zero height = invisible chart */
}
```

Pass initial dimensions into `createChart` or `applyOptions` when the container size is known.

## Teardown

```js
chart.remove();
```

Always pair with component unmount / route leave. Removing the DOM node alone is not enough.

## Fit content

After `setData`, show all bars:

```js
chart.timeScale().fitContent();
```

If margins look wrong with few bars, adjust logical range (see official time scale doc):

```js
const vr = chart.timeScale().getVisibleLogicalRange();
if (vr) {
  chart.timeScale().setVisibleLogicalRange({ from: vr.from + 0.5, to: vr.to - 0.5 });
}
```

## Responsive width (vanilla)

```js
const chart = createChart(container, {
  width: container.clientWidth,
  height: 400,
});

const ro = new ResizeObserver((entries) => {
  if (!entries.length) return;
  const { width } = entries[0].contentRect;
  chart.applyOptions({ width });
});
ro.observe(container);

// on teardown:
ro.disconnect();
chart.remove();
```

Window `resize` listener is an alternative; always remove listeners in cleanup.
```

---

### Task 7: React integration

**Files:**
- Create: `skills/lightweight-charts/references/react/integration.md`

- [ ] **Step 1: Write `references/react/integration.md`**

```markdown
# React integration (v5)

Read when: embedding charts in React or Next.js.

Official: [React simple](https://tradingview.github.io/lightweight-charts/tutorials/react/simple) · [React advanced](https://tradingview.github.io/lightweight-charts/tutorials/react/advanced)

**Default path:** official tutorials (below). **Optional:** community `lightweight-charts-react-wrapper` — not required.

## Simple: one chart, one series

```tsx
'use client';

import { useEffect, useRef } from 'react';
import { createChart, CandlestickSeries } from 'lightweight-charts';

export function ChartPanel({ data }: { data: Array<{ time: string; open: number; high: number; low: number; close: number }> }) {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;

    const chart = createChart(el, {
      width: el.clientWidth,
      height: 400,
    });
    const series = chart.addSeries(CandlestickSeries);
    series.setData(data);
    chart.timeScale().fitContent();

    const ro = new ResizeObserver(() => {
      chart.applyOptions({ width: el.clientWidth });
    });
    ro.observe(el);

    return () => {
      ro.disconnect();
      chart.remove();
    };
  }, [data]);

  return <div ref={containerRef} style={{ width: '100%', height: 400 }} />;
}
```

## Advanced: Chart + Series children

Use when multiple series/components share one chart API. Key ideas from the official advanced tutorial:

- `ChartContainer` holds DOM + `createChart` lifecycle
- React Context passes chart API ref to `Series` children
- **`useLayoutEffect`** for chart/series creation (not plain `useEffect` for DOM timing)
- **`isRemoved` flag** on chart ref so series cleanup does not call `removeSeries` after chart is gone (Strict Mode)

See full pattern: [advanced tutorial source](https://tradingview.github.io/lightweight-charts/tutorials/react/advanced).

## Expose series for realtime `update`

```tsx
// Parent holds ref to ISeriesApi from child via useImperativeHandle
seriesRef.current?.update(nextBar);
```

Do not re-run `setData` on every render when props change for streaming — use `update` in an interval or websocket handler.

## Next.js App Router

- File must be a **Client Component** (`'use client'`)
- Do not import `lightweight-charts` in Server Components or `layout.tsx` without client boundary
- Dynamic import is optional; standard client import is fine inside `'use client'` modules

## Optional wrapper

`lightweight-charts-react-wrapper` provides declarative `<Chart><LineSeries /></Chart>`. Use only if the team already depends on it; otherwise prefer official patterns above.
```

---

### Task 8: Realtime streaming

**Files:**
- Create: `skills/lightweight-charts/references/realtime/streaming.md`

- [ ] **Step 1: Write `references/realtime/streaming.md`**

```markdown
# Realtime streaming (v5)

Read when: websocket ticks, polling prices, or revising the forming candle.

Depends on: `references/core/data-and-time.md`

## Pattern

1. **Initial history:** one `setData(batch)`
2. **Each tick:** `series.update(bar)` only

```js
function onTick(bar) {
  series.update(bar);
}
```

## Same time vs new time

| Case | `time` field | Effect |
| --- | --- | --- |
| Update forming candle | Same as last bar | Replaces last point |
| New closed bar | Greater than last | Appends |

```js
// websocket message handler
socket.onmessage = (event) => {
  const bar = JSON.parse(event.data);
  series.update(bar);
};
```

## React + live feed

```tsx
useEffect(() => {
  if (!seriesRef.current) return;
  const id = setInterval(() => {
    seriesRef.current?.update({ time: nextTime, value: price });
  }, 1000);
  return () => clearInterval(id);
}, [started]);
```

Keep interval/subscription cleanup in the same effect teardown as `chart.remove()`.

## Throttling

The library does not throttle. If you receive >30 updates/sec, throttle in app code (e.g. 100ms batch) before `update`.

## Multiple charts

Sync crosshair or time range via `chart.timeScale()` subscribe APIs — see [official time scale](https://tradingview.github.io/lightweight-charts/docs/time-scale). No extra local mirror required; link out for full sync recipes.
```

---

### Task 9: Custom series plugins

**Files:**
- Create: `skills/lightweight-charts/references/plugins/custom-series.md`

- [ ] **Step 1: Write `references/plugins/custom-series.md`**

```markdown
# Custom series plugins (v5)

Read when: built-in series types are not enough (custom indicators, heatmaps, etc.).

Official: [Plugins intro](https://tradingview.github.io/lightweight-charts/docs/plugins/intro) · [ICustomSeriesPaneView](https://tradingview.github.io/lightweight-charts/docs/api/interfaces/ICustomSeriesPaneView)

## Steps

1. Implement a class that satisfies `ICustomSeriesPaneView` (renderer + data binding).
2. Add it to the chart:

```js
const customSeries = chart.addCustomSeries(myCustomPaneView, {
  // series options
});
customSeries.setData(data);
```

3. Use `customSeries.update(point)` for realtime, same as built-in series.

## Skeleton (conceptual)

```js
class MyCustomSeries {
  // implement ICustomSeriesPaneView methods:
  // renderer(), update(), priceValueBuilder(), etc.
}

const series = chart.addCustomSeries(new MyCustomSeries(), {});
series.setData([{ time: '2018-12-22', value: 1 }, { time: '2018-12-23', value: 2 }]);
```

Exact method signatures change between minor versions — copy from official plugin examples in the repo/docs, do not invent APIs.

## Built-in first

If a **Histogram**, **Line**, or **Area** series can express the visualization, use built-in types before writing a plugin.

## Further reading

- [Plugin examples on GitHub](https://github.com/tradingview/lightweight-charts/tree/master/plugin-examples)
```

---

### Task 10: SKILL.md dispatcher

**Files:**
- Create: `skills/lightweight-charts/SKILL.md`

- [ ] **Step 1: Write `SKILL.md`**

```markdown
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
```

- [ ] **Step 2: Verify line count**

```bash
wc -l skills/lightweight-charts/SKILL.md
```

Expected: **under 500 lines** (target ~120).

---

### Task 11: RED-GREEN pressure tests (writing-skills)

**Files:**
- Create: `skills/lightweight-charts/PRESSURE-TEST-RESULTS.md` (optional log; delete before merge if you prefer results only in PR)

No pytest — manual skill validation per spec.

- [ ] **Step 1: RED baseline (optional)**

Run one scenario **without** attaching the skill (or with an empty stub). Record typical failure modes in `PRESSURE-TEST-RESULTS.md`:

```markdown
# Pressure test results

## Baseline (no skill)
- Scenario 1: [notes]
```

- [ ] **Step 2: GREEN — Scenario 1 (React + live price)**

Prompt (attach skill):

> Add a React candlestick chart with live price updates every second.

Pass if agent: loads skill, uses `update`, `chart.remove()` + resize cleanup, cites `references/react/integration.md` or `references/realtime/streaming.md`.

- [ ] **Step 3: GREEN — Scenario 2 (blank chart)**

Prompt:

> My Lightweight Charts chart is completely blank. Fix it.

Pass if agent: checks container **height/width**, cites `lifecycle-resize.md`.

- [ ] **Step 4: GREEN — Scenario 3 (v4 upgrade)**

Prompt:

> Migrate my app from lightweight-charts v4 addCandlestickSeries to the new API.

Pass if agent: states **v5-only skill**, uses `addSeries(CandlestickSeries)`, does not document v4 as supported; may link official docs externally.

- [ ] **Step 5: GREEN — Scenario 4 (custom heatmap)**

Prompt:

> I need a heatmap series on my TradingView lightweight chart.

Pass if agent: routes to `references/plugins/custom-series.md`, mentions `addCustomSeries` / `ICustomSeriesPaneView`.

- [ ] **Step 6: GREEN — Scenario 5 (Next.js)**

Prompt:

> Add a price chart page in Next.js App Router.

Pass if agent: **`'use client'`**, no `createChart` in Server Component.

- [ ] **Step 7: REFACTOR**

If any scenario fails, edit the failing reference or `gotchas.md` (not just SKILL.md), re-run that scenario, document fix in `PRESSURE-TEST-RESULTS.md`.

---

### Task 12: Pre-deploy checklist (writing-skills)

**Files:**
- Verify: all files under `skills/lightweight-charts/`

- [ ] **Step 1: Run checklist**

```bash
# name matches directory
grep '^name:' skills/lightweight-charts/SKILL.md
# triggers count
grep -A20 'triggers:' skills/lightweight-charts/SKILL.md | head -15
# file list
find skills/lightweight-charts -type f | sort
wc -l skills/lightweight-charts/SKILL.md skills/lightweight-charts/gotchas.md
```

Confirm:

- [ ] `name: lightweight-charts` matches directory `skills/lightweight-charts`
- [ ] `SKILL.md` is ALL CAPS
- [ ] Description starts with "Use when"
- [ ] `metadata.triggers` has **≥ 10** entries
- [ ] `SKILL.md` **< 500** lines
- [ ] No `@` force-loading in cross-references
- [ ] All 5 pressure scenarios **PASS**

---

## Spec coverage (self-review)

| Spec requirement | Task |
| --- | --- |
| Hybrid Tier 2 layout | Tasks 1–10 |
| CSO frontmatter + triggers | Task 10 |
| Vanilla + React decision tree | Task 10, 7 |
| Core + realtime + plugins | Tasks 4–9 |
| v5 only, no v4 migration | gotchas + SKILL When NOT |
| gotchas anti-rationalization | Task 3 |
| Five pressure scenarios | Task 11 |
| Line count < 500 | Task 10, 12 |
| Official doc links v5.2 | `references/readme.md` + each reference |
| License attribution | gotchas + workflow step 8 |
| Optional react-wrapper note | Task 7 |

No gaps identified.

## Placeholder scan

No TBD/TODO/similar-to tasks in this plan.
