//
//  GaugeChartView.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class GaugeChartView: UIView {
    /// 未绘制线段区域的颜色
    var unfilledColor: UIColor = .systemGray5 {
        didSet { updateGauge() }
    }
    
    /// 正常进度颜色（≤0.6）
    var normalColor: UIColor = .init(hex: 0x6ac9bc) ?? .systemGreen {
        didSet { updateGauge() }
    }
    
    /// 超出进度颜色（>0.6）
    var exceededColor: UIColor = .init(hex: 0x59b0e9) ?? .systemBlue {
        didSet { updateGauge() }
    }
    
    /// 进度阈值（超过此值使用 exceededColor）
    var threshold: CGFloat = 0.6 {
        didSet {
            threshold = max(0.0, min(1.0, threshold))
            updateGauge()
        }
    }
    
    /// 当前进度 (0.0 ~ 1.0)
    var progress: CGFloat = 0.0 {
        didSet {
            progress = max(0.0, min(1.0, progress))
            updateGauge()
        }
    }
    
    /// 线段数量
    var segmentCount: Int = 37 {
        didSet { updateGauge() }
    }
    
    /// 线段宽度
    var segmentWidth: CGFloat = 4.0 {
        didSet { updateGauge() }
    }
    
    /// 线段长度
    var segmentLength: CGFloat = 20.0 {
        didSet { updateGauge() }
    }
    
    private let backgroundLayer = CAShapeLayer()
    private let normalLayer = CAShapeLayer()
    private let exceededLayer = CAShapeLayer()
        
    /// 数值
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(hex: 0x595959)
        label.text = "0"
        return label
    }()
    
    /// 标题
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor(hex: 0x696969)
        label.text = "Title"
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
        
    private func setupLayers() {
        backgroundColor = .clear
        
        // 配置背景层
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = .round
        layer.addSublayer(backgroundLayer)
        
        // 配置正常进度层
        normalLayer.fillColor = UIColor.clear.cgColor
        normalLayer.lineCap = .round
        layer.addSublayer(normalLayer)
        
        // 配置超出进度层
        exceededLayer.fillColor = UIColor.clear.cgColor
        exceededLayer.lineCap = .round
        layer.addSublayer(exceededLayer)
        
        // 添加标签
        setupLabels()
    }
    
    private func setupLabels() {
        addSubview(valueLabel)
        addSubview(titleLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // valueLabel 水平居中，垂直位置在中心偏下
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGauge()
    }
        
    /// 更新仪表盘显示
    private func updateGauge() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height)
        let radius = min(bounds.width, bounds.height * 2) / 2 - segmentLength - 10
        
        guard radius > 0 else { return }
        
        // 创建背景路径（所有线段位置）
        let backgroundPath = createSegmentPath(center: center, radius: radius, fromProgress: 0, toProgress: 1.0)
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.strokeColor = unfilledColor.cgColor
        backgroundLayer.lineWidth = segmentWidth
        
        // 判断进度是否超过阈值
        if progress <= threshold {
            // 全部显示为正常颜色
            let normalPath = createSegmentPath(center: center, radius: radius, fromProgress: 0, toProgress: progress)
            normalLayer.path = normalPath.cgPath
            normalLayer.strokeColor = normalColor.cgColor
            normalLayer.lineWidth = segmentWidth
            
            // 清空超出层
            exceededLayer.path = nil
        } else {
            // 0-threshold 显示为正常颜色
            let normalPath = createSegmentPath(center: center, radius: radius, fromProgress: 0, toProgress: threshold)
            normalLayer.path = normalPath.cgPath
            normalLayer.strokeColor = normalColor.cgColor
            normalLayer.lineWidth = segmentWidth
            
            // threshold-progress 显示为超出颜色
            let exceededPath = createSegmentPath(center: center, radius: radius, fromProgress: threshold, toProgress: progress)
            exceededLayer.path = exceededPath.cgPath
            exceededLayer.strokeColor = exceededColor.cgColor
            exceededLayer.lineWidth = segmentWidth
        }
    }
    
    /// 创建线段路径
    private func createSegmentPath(center: CGPoint, radius: CGFloat, fromProgress: CGFloat, toProgress: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        // 半圆从 π 开始，到 0 结束（180度）
        let startAngle: CGFloat = .pi
        let endAngle: CGFloat = 0
        let totalAngle = endAngle - startAngle
        
        // 计算每个线段应该占据的角度
        let anglePerSegment = totalAngle / CGFloat(segmentCount)
        
        // 计算起始和结束的线段索引
        let startSegmentIndex = Int(CGFloat(segmentCount) * fromProgress)
        let endSegmentIndex = Int(CGFloat(segmentCount) * toProgress)
        
        for i in startSegmentIndex ..< endSegmentIndex {
            // 计算线段的中心角度
            let midAngle = startAngle + anglePerSegment * (CGFloat(i) + 0.5)
            
            // 计算线段的内外端点
            let innerRadius = radius - segmentLength / 2
            let outerRadius = radius + segmentLength / 2
            
            let innerPoint = CGPoint(
                x: center.x + innerRadius * cos(midAngle),
                y: center.y - innerRadius * sin(midAngle)
            )
            
            let outerPoint = CGPoint(
                x: center.x + outerRadius * cos(midAngle),
                y: center.y - outerRadius * sin(midAngle)
            )
            
            // 绘制线段
            path.move(to: innerPoint)
            path.addLine(to: outerPoint)
        }
        
        return path
    }
        
    /// 设置进度（带动画）
    /// - Parameters:
    ///   - progress: 目标进度 (0.0 ~ 1.0)
    ///   - duration: 动画时长
    ///   - completion: 完成回调
    func setProgress(_ progress: CGFloat, animated: Bool, duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        if animated {
            let oldProgress = self.progress
            let newProgress = max(0.0, min(1.0, progress))
            
            // 使用 CADisplayLink 实现平滑动画
            let startTime = CACurrentMediaTime()
            let displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
            
            // 保存动画参数
            animationStartProgress = oldProgress
            animationEndProgress = newProgress
            animationStartTime = startTime
            animationDuration = duration
            animationCompletion = completion
            
            displayLink.add(to: .main, forMode: .common)
            currentDisplayLink = displayLink
        } else {
            self.progress = progress
            completion?()
        }
    }
        
    // MARK: - 动画属性

    private var currentDisplayLink: CADisplayLink?
    private var animationStartProgress: CGFloat = 0
    private var animationEndProgress: CGFloat = 0
    private var animationStartTime: CFTimeInterval = 0
    private var animationDuration: TimeInterval = 0
    private var animationCompletion: (() -> Void)?
    
    @objc private func updateAnimation() {
        let currentTime = CACurrentMediaTime()
        let elapsed = currentTime - animationStartTime
        
        if elapsed >= animationDuration {
            // 动画完成 停止动画
            progress = animationEndProgress
            currentDisplayLink?.invalidate()
            currentDisplayLink = nil
            animationCompletion?()
            animationCompletion = nil
        } else {
            // 计算当前进度（使用 ease-in-out 曲线）
            let t = CGFloat(elapsed / animationDuration)
            let easedT = easeInOutCubic(t)
            progress = animationStartProgress + (animationEndProgress - animationStartProgress) * easedT
        }
    }
    
    private func easeInOutCubic(_ t: CGFloat) -> CGFloat {
        if t < 0.5 {
            return 4 * t * t * t
        } else {
            let f = 2 * t - 2
            return 0.5 * f * f * f + 1
        }
    }
    
    deinit {
        currentDisplayLink?.invalidate()
    }
    
    /// 获取圆弧最左侧的 x 坐标（外边缘）
    func getLeftEdgeX() -> CGFloat {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height)
        let radius = min(bounds.width, bounds.height * 2) / 2 - segmentLength - 10
        return center.x - (radius + segmentLength / 2)
    }
    
    /// 获取圆弧最右侧的 x 坐标（外边缘）
    func getRightEdgeX() -> CGFloat {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height)
        let radius = min(bounds.width, bounds.height * 2) / 2 - segmentLength - 10
        return center.x + (radius + segmentLength / 2)
    }
    
    /// 获取圆弧的宽度（从最左到最右）
    func getArcWidth() -> CGFloat {
        return getRightEdgeX() - getLeftEdgeX()
    }
}

extension GaugeChartView {
    /// 便捷配置方法
    func configure(unfilledColor: UIColor,
                   normalColor: UIColor,
                   exceededColor: UIColor,
                   threshold: CGFloat,
                   progress: CGFloat)
    {
        self.unfilledColor = unfilledColor
        self.normalColor = normalColor
        self.exceededColor = exceededColor
        self.threshold = threshold
        self.progress = progress
    }
}
