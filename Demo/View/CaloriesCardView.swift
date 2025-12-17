//
//  CaloriesCardView.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class CaloriesCardView: CardView {
    
    private var gaugeView: GaugeChartView!
    
    private var consumedItemView: GaugeLegendItemView!
    private var baseItemView: GaugeLegendItemView!

    private var isItemConstraintsSet = false

    override init(frame: CGRect) {
        super.init(frame: frame)
   
        self.style = .inset
        
        let titleLabel = UILabel()
        titleLabel.text = "Calories KCAL"
        titleLabel.textColor = .theme.text
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(20)
            make.height.equalTo(20)
        }
        
        // 创建仪表盘
        gaugeView = GaugeChartView()
        gaugeView.valueLabel.text = "1232"
        gaugeView.titleLabel.text = "calories remaining"

        /*
        gaugeView.configure(
            unfilledColor: .systemGray5,
            normalColor: .systemGreen,
            exceededColor: .systemBlue,
            threshold: 0.8,  // 超过 0.8 才变蓝色
            progress: 0.9
        )
         */

        // 单独修改阈值超过 0.7 的部分变蓝色
    //        gaugeView.threshold = 0.7
        gaugeView.setProgress(0.4, animated: true)
        
        // 更新进度（带动画）
        DispatchQueue.main.asyncAfter(deadline: .now() + .theme.after) {
            self.gaugeView.setProgress(0.8, animated: true)
        }
        
        addSubview(gaugeView)
        gaugeView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(150)
        }
        
//        self.addShadow(ofColor: UIColor.black.withAlphaComponent(0.3))
        
        consumedItemView = GaugeLegendItemView()
        consumedItemView.indicatorView.indicatorColor = UIColor(hex: 0x6ac9bc)
        consumedItemView.titleLabel.text = "Consumed"
        consumedItemView.valueLabel.text = "2300kcal"
        addSubview(consumedItemView)

        consumedItemView.snp.makeConstraints { make in
            make.top.equalTo(gaugeView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        
        baseItemView = GaugeLegendItemView()
        baseItemView.indicatorView.indicatorColor = UIColor(hex: 0x59b0e9)
        baseItemView.titleLabel.text = "Base"
        baseItemView.valueLabel.text = "2500kcal"
        addSubview(baseItemView)

        baseItemView.snp.makeConstraints { make in
            make.top.equalTo(consumedItemView)
            make.size.equalTo(CGSize(width: 120, height: 20))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 在布局完成后，更新 item 的 leading 约束
        if !isItemConstraintsSet {
            isItemConstraintsSet = true
            consumedItemView.snp.makeConstraints { make in
                make.leading.equalTo(gaugeView.getLeftEdgeX() - 4)
            }
            
            baseItemView.snp.makeConstraints { make in
                make.leading.equalTo(consumedItemView.snp.trailing).offset(10)
            }
        }
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
