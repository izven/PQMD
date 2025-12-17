//
//  CardView.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit

class CardView: UIView {
    
    enum Style {
        case normal
        case inset
    }
    
    
    var style: Style = .normal {
        didSet {
            updateStyle()
        }
    }
    
    
    private lazy var innerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#fafafa")
        view.layer.cornerRadius = 15.0 // 20 (outer) - 5 (padding)
        view.layer.masksToBounds = true
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
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(hexString: "#dfdfdf")?.cgColor
        
        addSubview(innerView)
        innerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        updateStyle()
    }
    
    private func updateStyle() {
        switch style {
        case .normal:
            innerView.isHidden = true
        case .inset:
            innerView.isHidden = false
        }
    }
}
