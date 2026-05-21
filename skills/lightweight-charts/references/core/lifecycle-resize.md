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
