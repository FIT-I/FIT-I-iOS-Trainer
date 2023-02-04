//
//  BottomBtnView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import UIKit
import SnapKit

class BottomBtnView : UIView {
    var updateBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        btn.backgroundColor = .systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        return btn
    }()
    
    var userOpenChatBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        btn.backgroundColor = .systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        return btn
    }()
    
    var userLocationBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        btn.backgroundColor = .systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        return btn
    }()
    
    var resetPwBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        btn.backgroundColor = .systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        return btn
    }()
    
    var noticeBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        btn.backgroundColor = .systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        return btn
    }()
    
    var clauseBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        btn.backgroundColor = .systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        return btn
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userOpenChatBtn,userLocationBtn,resetPwBtn,updateBtn,noticeBtn,clauseBtn])
        stackView.axis = .vertical
        stackView.spacing = 20
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
        self.backgroundColor = .systemBackground
        self.addSubview(globalStackView)
    }
    
    private func setConstraints() {
        globalStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

