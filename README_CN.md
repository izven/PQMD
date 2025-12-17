# PQMD Demo

[English](./README.md) / 简体中文

@_heyrico 的 Pure quality mobile design by Ace Studio

<img src="design.png" alt="设计图" width="150" />

## 组件

### 径向进度图 (RadialProgressChartView)

显示多个同心进度圆环的视图。

- **同心圆环**：可配置间距、线宽和颜色。
- **可定制**：支持任意数量的圆环。
- **动画**：使用 `.theme.chart` 时长及其顺滑的入场动画。

```swift
let chart = RadialProgressChartView()
chart.rings = [
    RadialProgressChartView.RingConfig(color: .blue, progress: 0.5),
    RadialProgressChartView.RingConfig(color: .red, progress: 0.3)
]
chart.setProgress(0.8, forRingAt: 0, animated: true)
```

### 分段进度条 (SegmentedProgressView)

独立片段的线性进度视图。

- **自适应布局**：根据宽度自动计算分段数量。
- **集成标签**：内置标题和百分比标签。
- **配置便捷**：快速设置“高/中/低”风格的指示器。

```swift
let bar = SegmentedProgressView()
bar.filledColor = .orange
bar.titleLabel.text = "MED"
bar.setProgress(0.5, animated: true)
```

```swift
// 动画时长调用示例
let duration: TimeInterval = .theme.chart // 1.0s
```

## 要求

- iOS 13.0+
- Swift 5.0+
