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
