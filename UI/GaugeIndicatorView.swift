//
//  GaugeIndicatorView.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class GaugeIndicatorView: UIView {
    
    /// 指示器内圆颜色
    var indicatorColor: UIColor? = .systemBlue {
        didSet {
            innerCircle.backgroundColor = indicatorColor
        }
    }
    
    /// 内圆视图
    private let innerCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
        
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(innerCircle)
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            innerCircle.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            innerCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            innerCircle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            innerCircle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置圆形
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
        
        innerCircle.layer.cornerRadius = innerCircle.bounds.width / 2
        innerCircle.layer.masksToBounds = true
    }
}
