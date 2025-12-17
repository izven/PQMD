//
//  BreakdownItemView.swift
//  PQMD
//
//  Created by izven on 2025/12/17.
//

import UIKit

class BreakdownItemView: UIView{

    /// 标题（Carbs / Protein / Fat）
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.text = "Title"
        return label
    }()

    /// 数值（120 g）
    public let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = "0"
        return label
    }()

    /// 百分比（45%）
    public let percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.text = "0%"
        return label
    }()


    public override init(frame: CGRect) {
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
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(percentageLabel)
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            // valueLabel
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            // percentageLabel
            percentageLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            percentageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            percentageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            percentageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

