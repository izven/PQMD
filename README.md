# PQMD Demo

English / [简体中文](./README_CN.md)

From @_heyrico Pure quality mobile design by Ace Studio

![](design.png)

## Components

### RadialProgressChartView

A view that displays multiple concentric progress rings.

- **Concentric Rings**: Configurable spacing, line width, and colors.
- **Customizable**: Supports arbitrary number of rings.
- **Animation**: Smooth entry animations using `.theme.chart` duration.

```swift
let chart = RadialProgressChartView()
chart.rings = [
    RadialProgressChartView.RingConfig(color: .blue, progress: 0.5),
    RadialProgressChartView.RingConfig(color: .red, progress: 0.3)
]
chart.setProgress(0.8, forRingAt: 0, animated: true)
```

### SegmentedProgressView

A linear progress view broken into individual segments.

- **Adaptive Layout**: Automatically calculates the number of segments based on width.
- **Integrated Labels**: Built-in title and percentage labels.
- **Configurable**: Fast setup for "High/Medium/Low" style indicators.

```swift
let bar = SegmentedProgressView()
bar.filledColor = .orange
bar.titleLabel.text = "MED"
bar.setProgress(0.5, animated: true)
```

```swift
// Animation duration usage
let duration: TimeInterval = .theme.chart // 1.0s
```

## Requirements

- iOS 13.0+
- Swift 5.0+
