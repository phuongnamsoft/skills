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
