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
