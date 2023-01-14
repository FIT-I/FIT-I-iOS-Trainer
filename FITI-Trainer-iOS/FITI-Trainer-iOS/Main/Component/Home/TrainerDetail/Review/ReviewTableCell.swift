//
//  ReviewTableCell.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit

class ReviewTableCell: UITableViewCell {
    
    static let identifier = "ReviewTabelCell"
    
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewerIcon.svg")
        return imgView
    }()


    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "홍준혁"
        label.textColor = UIColor.black
        return label
    }()
    
    var date : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "2022.12.2"
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
        label.text = "4.3"
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
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    var reviewTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .systemBackground
        textView.font = UIFont.systemFont(ofSize: 12.0)
        // 더미 데이터
        textView.text = "친절한 지도 감사합니다:)"
        return textView
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView,reviewTextView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.globalStackView)

        globalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview()
        }
        
        print(globalStackView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    
    
}

//
//extension ReviewTabelCell {
//    public func binding(){
//        //
//    }
//}
