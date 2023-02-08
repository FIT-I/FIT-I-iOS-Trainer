//
//  ProfileView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import UIKit
import SnapKit

class ProfileView : UIView {
    
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewerIcon.svg")
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(45)
        }
        return imgView
    }()

    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 25.0)
        label.text = "홍준혁"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var userId : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "junhyeon2111@daum.net"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var leftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,userId])
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var midLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerImage,leftStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    var fixProfileBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("프로필 조회", for: .normal)
        btn.setTitleColor(UIColor.customColor(.darkGray), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Black", size: 12.0)
        btn.backgroundColor = .systemBackground
        return btn
    }()
    
    lazy var midStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [midLeftStackView,fixProfileBtn])
        stackView.axis = .horizontal
        stackView.spacing = 45
//        stackView.alignment = .center
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
        self.addSubview(midStackView)
    }
    
    private func setConstraints(){
        midStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}

