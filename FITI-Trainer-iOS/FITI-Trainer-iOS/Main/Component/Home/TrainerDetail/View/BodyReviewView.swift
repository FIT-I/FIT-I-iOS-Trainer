//
//  BodyReviewView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import UIKit
import SnapKit

class BodyReviewView : UIView {
    // 후기 뷰
    var reviewView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.layer.borderColor = UIColor.customColor(.boxGray).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    var reviewImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewIcon.svg")
        return imgView
    }()
    
    var reviewLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "후기 5건"
        label.textColor = UIColor.black
        return label
    }()
    
    var reviewGradeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "평균 4.3"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var reviewDetailBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
//        btn.addTarget(self, action: #selector(moveToReviewTableView), for: .touchUpInside)
        return btn
    }()
    
    lazy var reviewTopLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewImage,reviewLabel,reviewGradeLabel])
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
    
    func setViewHierarchy(){
        self.addSubview(reviewTopLeftStackView)
        self.addSubview(reviewDetailBtn)
    }
    
    func setConstraints(){
        reviewTopLeftStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        reviewDetailBtn.snp.makeConstraints { make in
            make.centerY.equalTo(reviewTopLeftStackView)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
    
}


