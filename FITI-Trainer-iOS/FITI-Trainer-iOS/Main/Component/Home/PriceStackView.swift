//
//  PriceStackView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import UIKit
import SnapKit

class PriceStackView: UIView {
    
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
    
    lazy var priceTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceImage,priceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
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
    
    var priceForTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "/2만원부터~"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var priceMiddleStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel,priceForTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    var othersLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "+추가관리"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var otherPriceForTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "/3만원부터~"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var priceBottomStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [othersLabel,otherPriceForTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    lazy var priceStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceTopStackView,priceLineView,priceMiddleStackView,priceBottomStackView])

        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
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
        self.addSubview(priceStackView)
    }
    
    private func setConstraints(){
        priceStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
        }
    }
}
