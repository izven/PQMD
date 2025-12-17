//
//  GaugeLegendItemView.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class GaugeLegendItemView: UIView {
    /// 左侧颜色指示点
    public let indicatorView: GaugeIndicatorView = {
        let view = GaugeIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// 标题（Value / Total）
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .label
        return label
    }()

    /// 具体数值（2300 kcal）
    public let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        addSubview(indicatorView)
        addSubview(titleLabel)
        addSubview(valueLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // indicatorView（小圆点）
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 16),
            indicatorView.heightAnchor.constraint(equalToConstant: 16),

            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 5),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            // valueLabel
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
