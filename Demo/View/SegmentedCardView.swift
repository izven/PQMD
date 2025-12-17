//
//  SegmentedCardView.swift
//  PQMD
//
//  Created by izven on 2025/12/17.
//

import UIKit

class SegmentedCardView: CardView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - 标题

        let titleItemView = GaugeLegendItemView()
        titleItemView.indicatorView.indicatorColor = UIColor(hex: 0x5bc662)
        titleItemView.titleLabel.text = "Stress Overview"
        titleItemView.titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleItemView.titleLabel.textColor = UIColor(hex: 0x616161)
        addSubview(titleItemView)

        titleItemView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(25)
//            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        
        setupProgressView()
    }
    
    private func setupProgressView() {
        let highColor = UIColor(hex: 0xec5979)
        let medColor = UIColor(hex: 0xefa44c)
        let lowColor = UIColor(hex: 0x5ab3ed)

        // 第一个进度条 - 51%
        let progressView1 = SegmentedProgressView()
        addSubview(progressView1)
        
        progressView1.filledColor = highColor
        progressView1.titleLabel.text = "HIGH"
        progressView1.progress = 0.51
                
        progressView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        // 第二个
        let progressView2 = SegmentedProgressView()
        addSubview(progressView2)
        
        progressView2.filledColor = medColor
        progressView2.titleLabel.text = "MED"
        progressView2.progress = 0.9
                
        progressView2.snp.makeConstraints { make in
            make.top.equalTo(progressView1.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(progressView1)
        }
        
        // 第三个
        let progressView3 = SegmentedProgressView()
        addSubview(progressView3)
        
        progressView3.filledColor = lowColor
        progressView3.titleLabel.text = "LOW"
        progressView3.progress = 0.3
                
        progressView3.snp.makeConstraints { make in
            make.top.equalTo(progressView2.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(progressView1)
        }
        
        // 展示动画配置
        DispatchQueue.main.asyncAfter(deadline: .now() + .theme.after) {
            progressView1.setProgress(0.2, animated: true)
            progressView2.setProgress(0.5, animated: true)
            progressView3.setProgress(0.7, animated: true)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
