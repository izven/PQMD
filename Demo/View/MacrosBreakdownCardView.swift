//
//  MacrosBreakdownCardView.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class MacrosBreakdownCardView: CardView {
    private let carbsColor = UIColor(hex: 0x5ac661)
    private let proteinColor = UIColor(hex: 0xeb9136)
    private let fatColor = UIColor(hex: 0x56bafa)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - 标题

        let titleItemView = GaugeLegendItemView()
        titleItemView.indicatorView.indicatorColor = UIColor(hex: 0x5bc662)
        titleItemView.titleLabel.text = "Macros Breakdown"
        titleItemView.titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleItemView.titleLabel.textColor = UIColor(hex: 0x616161)
        addSubview(titleItemView)

        titleItemView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(25)
//            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        
        // MARK: - Carbs、Protein、Fat占比显示

        let carbsView = BreakdownItemView()
        carbsView.titleLabel.text = "Carbs"
        carbsView.valueLabel.text = "200g"
        carbsView.valueLabel.textColor = carbsColor
        carbsView.percentageLabel.text = "45%"
        
        let proteinView = BreakdownItemView()
        proteinView.titleLabel.text = "Protein"
        proteinView.valueLabel.text = "90g"
        proteinView.valueLabel.textColor = proteinColor
        proteinView.percentageLabel.text = "35%"

        let fatView = BreakdownItemView()
        fatView.titleLabel.text = "Fat"
        fatView.valueLabel.text = "60g"
        fatView.valueLabel.textColor = fatColor
        fatView.percentageLabel.text = "20%"

        addSubviews([carbsView, proteinView, fatView])
        carbsView.snp.makeConstraints { make in
            make.top.equalTo(titleItemView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 50, height: 80))
        }
        
        proteinView.snp.makeConstraints { make in
            make.top.size.equalTo(carbsView)
            make.leading.equalTo(carbsView.snp.trailing).offset(25)
        }
        
        fatView.snp.makeConstraints { make in
            make.top.size.equalTo(carbsView)
            make.leading.equalTo(proteinView.snp.trailing).offset(25)
        }

        // MARK: - 三个圆环
        
        let radialChart = RadialProgressChartView()
        radialChart.rings = [
            RadialProgressChartView.RingConfig(color: fatColor, progress: 0.20),
            RadialProgressChartView.RingConfig(color: proteinColor, progress: 0.35),
            RadialProgressChartView.RingConfig(color: carbsColor, progress: 0.45)
        ]
//        radialChart.ringSpacing = 5.0
//        radialChart.lineWidth = 8.0
        addSubview(radialChart)
        
        radialChart.snp.makeConstraints { make in
            make.top.equalTo(titleItemView.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        // 展示动画配置
        DispatchQueue.main.asyncAfter(deadline: .now() + .theme.after) {
            radialChart.setProgress(0.6, forRingAt: 0, animated: true)
            radialChart.setProgress(0.7, forRingAt: 1, animated: true)
            radialChart.setProgress(0.8, forRingAt: 2, animated: true)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
