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
