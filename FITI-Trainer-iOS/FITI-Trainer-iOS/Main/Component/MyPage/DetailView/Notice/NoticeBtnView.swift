//
//  NoticeBtnView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//


import Foundation
import UIKit
import SnapKit

class NoticeBtnView : UIView {
    
    var updateNoticeDateLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = "지난달"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont.systemFont(ofSize: 10)
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        return label
    }()
    
    var privacyNoticeDateLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = "지난달"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont.systemFont(ofSize: 10)
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        return label
    }()
    
    var goUpdateNoticeBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "rightBtn.svg"), for: .normal)
        btn.snp.makeConstraints { make in
            make.height.equalTo(7)
            make.width.equalTo(4)
        }
//        btn.backgroundColor = .purple

        return btn
    }()
    
    var goPrivacyNoticeBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "rightBtn.svg"), for: .normal)
        btn.snp.makeConstraints { make in
            make.height.equalTo(7)
            make.width.equalTo(4)
        }
//        btn.backgroundColor = .systemMint

        return btn
    }()
    
    lazy var updateBtnStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateNoticeDateLabel,goUpdateNoticeBtn])
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
//        stackView.backgroundColor = .darkGray
        return stackView
    }()

    lazy var privacyBtnStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [privacyNoticeDateLabel,goPrivacyNoticeBtn])
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
//        stackView.backgroundColor = .green

        return stackView
    }()
    
    lazy var btnStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateBtnStackView,privacyBtnStackView])
        stackView.axis = .vertical
        stackView.spacing = 36
        stackView.alignment = .center
//        stackView.backgroundColor = .red
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
        self.addSubview(btnStackView)
    }
    
    private func setConstraints() {
        btnStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        }
    
    }
