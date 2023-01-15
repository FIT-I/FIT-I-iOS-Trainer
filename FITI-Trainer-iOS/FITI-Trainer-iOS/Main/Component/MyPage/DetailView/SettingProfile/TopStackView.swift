//
//  TopStackView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import SnapKit
import UIKit

class TopStackView : UIView {
    
//    var reviewerImage : UIImageView = {
//        let imgView = UIImageView()
//        imgView.image = UIImage(named: "reviewerIcon.svg")
//        imgView.snp.makeConstraints { make in
//            make.height.width.equalTo(60)
//        }
//        return imgView
//    }()
    
    var settingUserProfile : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"chooseProfile.svg"), for: .normal)
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(75)
        }
        btn.backgroundColor = .systemBackground
        return btn
    }()
    
    var userName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "김동현"
        label.textColor = UIColor.black
        return label
    }()
    
    var blank : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "  "
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var userNameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userName,blank])
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingUserProfile,userNameStackView])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .center
        return stackView
    }()
    
//    lazy var globalStackView : UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [reviewerImage,userNameStackView])
//        stackView.axis = .vertical
//        stackView.spacing = 7
//        stackView.alignment = .center
//        return stackView
//    }()
    
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
    
    private func setConstraints() {
        globalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func pencilBtnEvent(){
        
    }
    
}

