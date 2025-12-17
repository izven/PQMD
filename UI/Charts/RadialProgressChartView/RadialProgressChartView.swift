//
//  RadialProgressChartView.swift
//  PQMD
//
//  Created by izven on 2025/12/17.
//

import UIKit

class RadialProgressChartView: UIView {
    
    // MARK: - 圆环配置
    struct RingConfig {
        let color: UIColor?
        var progress: CGFloat // 0.0 到 1.0
        
        init(color: UIColor?, progress: CGFloat = 0.0) {
            self.color = color
            self.progress = min(max(progress, 0.0), 1.0)
        }
    }
    
    // MARK: - 属性
    var rings: [RingConfig] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var ringSpacing: CGFloat = 4.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lineWidth: CGFloat = 6.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    // MARK: - 绘图
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard !rings.isEmpty else { return }
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let maxRadius = min(rect.width, rect.height) / 2 - lineWidth / 2
        
        // 计算每个圆环的半径（从内到外）
        for (index, ring) in rings.enumerated() {
            let radius = maxRadius - CGFloat(rings.count - 1 - index) * (lineWidth + ringSpacing)
            
            // 绘制背景圆环
            drawRing(
                center: center,
                radius: radius,
                color: ring.color?.withAlphaComponent(0.2),
                progress: 1.0
            )
            
            // 绘制进度圆环
            if ring.progress > 0 {
                drawRing(
                    center: center,
                    radius: radius,
                    color: ring.color,
                    progress: ring.progress
                )
            }
        }
    }
    
    private func drawRing(center: CGPoint, radius: CGFloat, color: UIColor?, progress: CGFloat) {
        let startAngle: CGFloat = -.pi / 2 // 从顶部开始
        let endAngle: CGFloat = startAngle + (2 * .pi * progress)
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        color?.setStroke()
        path.stroke()
    }
    
    
    // MARK: - 动画状态
    private struct AnimationState {
        let startTime: CFTimeInterval
        let duration: CFTimeInterval
        let startProgress: CGFloat
        let targetProgress: CGFloat
    }
    
    private var activeAnimations: [Int: AnimationState] = [:]
    private var displayLink: CADisplayLink?
    
    /// 设置进度
    /// - Parameters:
    ///   - progress: 目标进度 (0.0 - 1.0)
    ///   - index: 圆环索引
    ///   - animated: 是否执行动画
    func setProgress(_ progress: CGFloat, forRingAt index: Int, animated: Bool = false) {
        guard index >= 0 && index < rings.count else { return }
        
        let targetProgress = min(max(progress, 0.0), 1.0)
        
        if animated {
            // 如果已经在动画中，从当前进度继续动画
            let startProgress = rings[index].progress
            let duration: CFTimeInterval = .theme.chart

            // 记录动画状态
            activeAnimations[index] = AnimationState(
                startTime: CACurrentMediaTime(),
                duration: duration,
                startProgress: startProgress,
                targetProgress: targetProgress
            )
            
            // 启动 DisplayLink
            if displayLink == nil {
                displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
                displayLink?.add(to: .main, forMode: .common)
            }
        } else {
            // 取消该圆环可能存在的动画
            activeAnimations.removeValue(forKey: index)
            if activeAnimations.isEmpty {
                stopDisplayLink()
            }
            
            // 直接更新
            rings[index].progress = targetProgress
            setNeedsDisplay()
        }
    }
    
    @objc private func handleDisplayLink(_ link: CADisplayLink) {
        let currentTime = CACurrentMediaTime()
        var completedAnimations: [Int] = []
        
        for (index, state) in activeAnimations {
            let elapsed = currentTime - state.startTime
            
            if elapsed >= state.duration {
                // 动画完成
                rings[index].progress = state.targetProgress
                completedAnimations.append(index)
            } else {
                // 缓动计算 (Ease Out Quad)
                let t = CGFloat(elapsed / state.duration)
                let easedT = 1.0 - (1.0 - t) * (1.0 - t)
                
                let currentProgress = state.startProgress + (state.targetProgress - state.startProgress) * easedT
                rings[index].progress = currentProgress
            }
        }
        
        // 清理完成的动画
        for index in completedAnimations {
            activeAnimations.removeValue(forKey: index)
        }
        
        // 触发重绘
        setNeedsDisplay()
        
        // 如果没有活跃的动画，停止 DisplayLink
        if activeAnimations.isEmpty {
            stopDisplayLink()
        }
    }
    
    private func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
}
