//
//  PreviewReviewTableCell.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit
import Foundation
import SnapKit
import Then

class PreviewReviewTableCell: UITableViewCell {
    
    static let identifier = "PreviewReviewTableCell"
    
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        //imgView.image = UIImage(named: "reviewerIcon.svg")
        imgView.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        return imgView
    }()


    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
     //   label.text = "홍준혁"
        label.textColor = UIColor.black
        return label
    }()
    
    var date : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
    //    label.text = "2022.12.2"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var starIcon : UIImageView = {
        let image = UIImageView()
        image.snp.makeConstraints { make in
            make.height.width.equalTo(10)
        }
        image.image = UIImage(named: "star.svg")
        return image
    }()
    
    var grade : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
     //   label.text = "4.3"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var rateStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starIcon,grade])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()

    
    lazy var dateStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [date,rateStackView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,dateStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var topStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerImage,nameStackView])
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.customColor(.boxGray)
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return stackView
    }()
    
    var reviewTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.customColor(.boxGray)
        textView.font = UIFont.systemFont(ofSize: 12.0)
        textView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        // 더미 데이터
     //   textView.text = "친절한 지도 감사합니다:)"
        return textView
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView,reviewTextView])
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.customColor(.boxGray)
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.globalStackView)
        self.backgroundColor = UIColor.customColor(.boxGray)
        globalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        print(globalStackView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    
    
}


extension PreviewReviewTableCell {
    func dataBind(model: ReviewDto) {
        name.text = model.name
        date.text = model.createdAt
        grade.text = String(model.grade)
        reviewTextView.text = model.contents
        switch model.profile {
        case "profile1":
            reviewerImage.image = UIImage(named:"profile1")
            return
        case "profile2":
            reviewerImage.image = UIImage(named:"profile2")
            return
        case "profile3":
            reviewerImage.image = UIImage(named:"profile3")
            return
        case "profile4":
            reviewerImage.image = UIImage(named:"profile4")
            return
        case "profile5":
            reviewerImage.image = UIImage(named:"profile5")
            return
        case "profile6":
            reviewerImage.image = UIImage(named:"profile6")
            return
        default:
            reviewerImage.image = UIImage(named:"profile1")
            return
        }
    }
}
