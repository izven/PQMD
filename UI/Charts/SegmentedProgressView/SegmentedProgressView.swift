//
//  SegmentedProgressView.swift
//  PQMD
//
//  Created by izven on 2025/12/17.
//

import UIKit

class SegmentedProgressView: UIView {
        
    // 标题标签
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hex: 0x6f6f6f)
        return label
    }()
    
    // 百分比标签
    public let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    
    // 进度条视图
    private let progressView = SegmentBarView()
    
    // 进度值 0.0 - 1.0
    var progress: CGFloat = 0.0 {
        didSet {
            progress = max(0.0, min(1.0, progress))
            progressView.progress = progress
            percentageLabel.text = "\(Int(progress * 100))%"
        }
    }
    
    // 颜色配置
    var filledColor: UIColor? {
        get { progressView.filledColor }
        set { progressView.filledColor = newValue }
    }
    
    var unfilledColor: UIColor? {
        get { progressView.unfilledColor }
        set { progressView.unfilledColor = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(progressView)
        addSubview(percentageLabel)
                
        titleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(30)
        }
        
        // [titleLabel][progressView][percentageLabel]
        // 间距 10px

        progressView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalTo(percentageLabel.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    // MARK: - 动画属性
    private var displayLink: CADisplayLink?
    private var animationStartTime: CFTimeInterval = 0
    private var animationStartProgress: CGFloat = 0
    private var animationTargetProgress: CGFloat = 0
    private let animationDuration: TimeInterval = .theme.chart
    
    func setProgress(_ value: CGFloat, animated: Bool = true) {
        let clampedValue = max(0.0, min(1.0, value))
        
        if animated {
            // 停止之前的动画
            stopDisplayLink()
            
            animationStartTime = CACurrentMediaTime()
            animationStartProgress = progress
            animationTargetProgress = clampedValue
            
            let link = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
            link.add(to: .main, forMode: .common)
            displayLink = link
        } else {
            stopDisplayLink()
            self.progress = clampedValue
        }
    }
    
    @objc private func handleDisplayLink(_ link: CADisplayLink) {
        let currentTime = CACurrentMediaTime()
        let elapsed = currentTime - animationStartTime
        
        if elapsed >= animationDuration {
            self.progress = animationTargetProgress
            stopDisplayLink()
        } else {
            // Ease Out Quad 缓动
            let t = CGFloat(elapsed / animationDuration)
            let easedT = 1.0 - (1.0 - t) * (1.0 - t)
            
            let currentProgress = animationStartProgress + (animationTargetProgress - animationStartProgress) * easedT
            self.progress = currentProgress
        }
    }
    
    private func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

// MARK: - 内部进度条
private class SegmentBarView: UIView {
    
    var filledColor: UIColor? = UIColor(hex: 0xec3169) // 粉红色
    var unfilledColor: UIColor? = UIColor(hex: 0xe6e6e6) // 灰色
    
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let minimumSegmentWidth: CGFloat = 4.0
    private let segmentSpacing: CGFloat = 4.0
    
    private let internalSegmentSpacing: CGFloat = 2.0 // 内部每个段的间距
    private let preferredSegmentWidth: CGFloat = 6.0 // 期望的段宽度
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentMode = .redraw
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        contentMode = .redraw
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let width = rect.width
        let height = rect.height
        
        // 自适应计算 segmentCount
        // width = count * segWidth + (count - 1) * spacing
        // width = count * (segWidth + spacing) - spacing
        // width + spacing = count * (segWidth + spacing)
        // count = (width + spacing) / (segWidth + spacing)
        
        // 使用期望宽度计算 count
        let totalUnit = preferredSegmentWidth + internalSegmentSpacing
        var count = Int((width + internalSegmentSpacing) / totalUnit)
        
        // 限制最少段数
        count = max(count, 5)
        
        // 实际的 segmentWidth 以填满空间
        // actualSegWidth = (width - (count - 1) * spacing) / count
        let totalSpacing = CGFloat(count - 1) * internalSegmentSpacing
        let actualSegmentWidth = (width - totalSpacing) / CGFloat(count)
        
        let filledSegments = Int(ceil(CGFloat(count) * progress))
        
        for i in 0..<count {
            let x = CGFloat(i) * (actualSegmentWidth + internalSegmentSpacing)
            let segmentRect = CGRect(x: x, y: 0, width: actualSegmentWidth, height: height)
            
            let color = i < filledSegments ? filledColor : unfilledColor
            
            // 圆角半径设置为高度的一半或根据宽度自适应
            let radius = min(actualSegmentWidth, height) / 2
            let path = UIBezierPath(roundedRect: segmentRect, cornerRadius: radius)
            
            context.setFillColor(color?.cgColor ?? UIColor.red.cgColor)
            context.addPath(path.cgPath)
            context.fillPath()
        }
    }
}
