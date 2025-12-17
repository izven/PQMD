//
//  Demo1ViewController.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class Demo1ViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Demo1"
        
        // MARK: - 卡路里

        let caloriesCardView = CaloriesCardView()
        view.addSubview(caloriesCardView)
        
        caloriesCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
            make.height.equalTo(260)
        }
        
        // MARK: - Macros Breakdown
        
        let macrosBreakdownView = MacrosBreakdownCardView()
        view.addSubview(macrosBreakdownView)
        
        macrosBreakdownView.snp.makeConstraints { make in
            make.top.equalTo(caloriesCardView.snp.bottom).offset(30)
            make.width.centerX.equalTo(caloriesCardView)
            make.height.equalTo(160)
        }
        
        // MARK: - 分段进度条
        
        let segmentedCardView = SegmentedCardView()
        view.addSubview(segmentedCardView)
        
        segmentedCardView.snp.makeConstraints { make in
            make.top.equalTo(macrosBreakdownView.snp.bottom).offset(30)
            make.width.centerX.equalTo(caloriesCardView)
            make.height.equalTo(210)
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
