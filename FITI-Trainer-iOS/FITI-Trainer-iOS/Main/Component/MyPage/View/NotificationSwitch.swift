//
//  NotificationSwitch.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import UIKit
import SnapKit

class NotificationSwitch : UIView {
    
    var notificationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "내 매칭 페이지 관리"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var showProfileBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ON.svg"), for: .normal)
        return btn
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [notificationLabel,showProfileBtn])
        stackView.axis = .horizontal
        stackView.spacing = 170
        stackView.alignment = .center
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
        self.backgroundColor = UIColor.customColor(.boxGray)
        self.addSubview(globalStackView)
    }
    
    private func setConstraints() {
        globalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}

