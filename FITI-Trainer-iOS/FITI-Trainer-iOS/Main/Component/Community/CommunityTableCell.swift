//
//  CommunityTableCell.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import UIKit
import SnapKit

class CommunityTableCell: UITableViewCell {
    
    var id = Int()
    static let identifier = "CommunityTableCell"
    
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "customerProfile1.svg")
        imgView.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(20)
        }
        return imgView
    }()


    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "홍준혁"
        label.textColor = UIColor.black
        return label
    }()
    
    var date : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "2022.12.2"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var pickUpStyle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "트레이너님이 와주세요"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()

    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,pickUpStyle])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerImage,nameStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
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

extension CommunityTableCell{
    public func bindingMatchingList(model: MatchingResult){
        name.text = model.name
//        date.text = model.orderDate
        id = model.matchingId
        reviewerImage.image = UIImage(named: "\(model.profile).svg")
        if(model.pickUpType == "TRAINER_GO"){
            pickUpStyle.text = "트레이너님이 와주세요."
        } else {
            pickUpStyle.text = "제가 직접 갈게요."
        }
    }
}
