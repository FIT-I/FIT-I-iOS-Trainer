//
//  BodyPriceView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import UIKit
import SnapKit

class BodyPriceView : UIView {
    var priceImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "priceIcon.svg")
        return imgView
    }()
    
    var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "관리 비용"
        label.textColor = UIColor.black
        return label
    }()
    
    var priceLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.darkGray)
        return view
    }()
    
    var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "1시간"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var othersLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "+추가관리"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var priceForTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "10,000원"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var otherPriceForTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "20,000원"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var priceTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceImage,priceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    lazy var priceLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel,othersLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var priceRightStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceForTimeLabel,otherPriceForTimeLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .trailing
        return stackView
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.addSubview(priceTopStackView)
        self.addSubview(priceLineView)
        self.addSubview(priceLeftStackView)
        self.addSubview(priceRightStackView)
    }
    
    private func setConstraints(){
        priceTopStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        priceLineView.snp.makeConstraints { make in
            make.top.equalTo(priceTopStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        priceLeftStackView.snp.makeConstraints { make in
            make.top.equalTo(priceLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        priceRightStackView.snp.makeConstraints { make in
            make.top.equalTo(priceLineView.snp.bottom).offset(10)
            make.leading.equalTo(priceLeftStackView.snp.trailing).offset(80)
        }
    }
}

