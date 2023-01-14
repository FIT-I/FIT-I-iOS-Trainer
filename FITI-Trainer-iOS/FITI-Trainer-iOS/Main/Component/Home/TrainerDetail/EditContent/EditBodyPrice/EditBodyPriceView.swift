//
//  EditBodyPriceView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/13.
//

import UIKit
import SnapKit

class EditBodyPriceView: UIView {

    var isFreePickBtnTouched : Bool = false
    var isFirstPickBtnTouched : Bool = false
    var isSecondPickBtnTouched : Bool = false
    var isThirdPickBtnTouched : Bool = false
    var isFourthPickBtnTouched : Bool = false
    var isBtnTapped : Bool = false

    

    var freePickBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "emptyBox.svg"), for: .normal)
//        btn.addTarget(EditBodyPriceView.self, action: #selector(hourBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    var firstPickBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "emptyBox.svg"), for: .normal)
//        btn.addTarget(EditBodyPriceView.self, action: #selector(hourBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    var secondPickBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "emptyBox.svg"), for: .normal)
//        btn.addTarget(EditBodyPriceView.self, action: #selector(addBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    var thirdPickBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "emptyBox.svg"), for: .normal)
//        btn.addTarget(EditBodyPriceView.self, action: #selector(addBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    var fourthPickBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "emptyBox.svg"), for: .normal)
//        btn.addTarget(EditBodyPriceView.self, action: #selector(addBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    var freeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "무료"
        label.textColor = UIColor.black
        return label
    }()
    
    var firstPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "10,000원"
        label.textColor = UIColor.black
        return label
    }()
    
    var secondPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "15,000원"
        label.textColor = UIColor.black
        return label
    }()
    
    var thirdPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "20,000원"
        label.textColor = UIColor.black
        return label
    }()
    
    var fourthPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "25,000원"
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var freeLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [freePickBtn,freeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var firstLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstPickBtn,firstPriceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var secondLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondPickBtn,secondPriceLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var thirdLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirdPickBtn,thirdPriceLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var fourthLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fourthPickBtn,fourthPriceLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [freeLeftStackView,firstLeftStackView,secondLeftStackView,thirdLeftStackView,fourthLeftStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
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
        self.addSubview(globalStackView)
    }
    
    private func setConstraints(){
        globalStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    @objc func hourBtnClicked(sender: UIBarButtonItem) {
        
    }
    @objc func addBtnClicked(sender: UIBarButtonItem) {
        
    }
}

