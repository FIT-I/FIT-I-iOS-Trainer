//
//  HeadView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import SnapKit
import UIKit

class HeadView : UIView {
    
    // 상단 뷰
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewerIcon.svg")
        return imgView
    }()
    
    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "김동현"
        label.textColor = UIColor.black
        return label
    }()
    
    var goldIcon : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(named: "gold.svg")
        return image
    }()
    
    var starIcon : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star.svg")
        return image
    }()
    
    var grade : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "4.3"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var license : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "자격증 5개"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var school : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "숭실대"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,goldIcon])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .trailing
        return stackView
    }()
    
    lazy var rateStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starIcon,grade])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var gradeStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rateStackView,license,school])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView,gradeStackView])
        stackView.axis = .vertical
        stackView.spacing = 6
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
    
    func setViewHierarchy(){
        self.addSubview(reviewerImage)
        self.addSubview(globalStackView)
    }
    
    func setConstraints(){
        reviewerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.height.width.equalTo(70)
        }
        globalStackView.snp.makeConstraints { make in
            make.top.equalTo(reviewerImage.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(30)
            make.trailing.bottom.equalToSuperview()
        }
    }
}
