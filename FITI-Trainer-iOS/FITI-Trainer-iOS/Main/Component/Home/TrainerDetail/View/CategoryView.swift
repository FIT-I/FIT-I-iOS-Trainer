//
//  CategoryView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/31.
//

import Foundation
import UIKit
import SnapKit

class CategoryView : UIView {
    var priceImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "category.svg")
        return imgView
    }()
    
    var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "카테고리 선택"
        label.textColor = UIColor.black
        return label
    }()
    
    var editBodyPriceButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "edit.svg"), for: .normal)
        return btn
    }()
    
    var priceLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "개인 PT"
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
        self.addSubview(timeLabel)
        self.addSubview(editBodyPriceButton)
    }
    
    private func setConstraints(){
        priceTopStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        editBodyPriceButton.snp.makeConstraints { make in
            make.top.equalTo(priceTopStackView)
            make.trailing.equalToSuperview().offset(-20)
        }
        priceLineView.snp.makeConstraints { make in
            make.top.equalTo(priceTopStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }
}

