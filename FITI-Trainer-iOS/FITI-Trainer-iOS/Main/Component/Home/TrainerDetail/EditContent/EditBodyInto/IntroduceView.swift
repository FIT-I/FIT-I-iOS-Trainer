//
//  IntroduceView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//

import Foundation
import SnapKit
import UIKit

class IntroduceView: UIView {

    private lazy var introImage: UIImageView = {
            let imgView = UIImageView()
            imgView.image = UIImage(named: "introIcon.svg")
            return imgView
    }()
    
    private lazy var introLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "소개 글"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var introTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introImage,introLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
        
    private lazy var introLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
        make.height.equalTo(1)
        }
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)

        setViewHierarchy()
        setConstraints()
        
    }
    
    func setViewHierarchy(){
        self.addSubview(introTopStackView)
        self.addSubview(introLineView)
        //self.addSubview(introTextView)
           
       }
    func setConstraints() {
        
        introTopStackView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        introLineView.snp.makeConstraints { make in
            make.top.equalTo(introTopStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
//        introTextView.snp.makeConstraints { make in
//            make.top.equalTo(introLineView.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//          //  make.height.equalTo(90)
//        }
//
        
    }

}

