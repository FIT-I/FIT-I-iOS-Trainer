//
//  NoticeLabelView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//

import Foundation
import UIKit
import SnapKit

class NoticeLabelView : UIView {

    var updateNoticeLabel : UILabel = {
        let label = UILabel()
        label.text = "앱 업데이트 안내"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont.systemFont(ofSize: 15)
//        label.backgroundColor = .magenta
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        return label
    }()
    
    var privacyNoticeLabel : UILabel = {
        let label = UILabel()
        label.text = "개인정보 약관 동의 관련"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont.systemFont(ofSize: 15)
//        label.backgroundColor = .orange
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }

        return label
    }()

    lazy var titleStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateNoticeLabel,privacyNoticeLabel])
        stackView.axis = .vertical
        stackView.spacing = 36
        stackView.alignment = .leading
//        stackView.backgroundColor = .blue
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
        self.addSubview(titleStackView)
    }
    
    private func setConstraints() {
        titleStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        }
    
    }
