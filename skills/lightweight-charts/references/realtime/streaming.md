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
