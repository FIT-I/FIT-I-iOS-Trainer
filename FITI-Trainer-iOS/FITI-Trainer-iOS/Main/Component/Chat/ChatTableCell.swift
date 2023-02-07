//
//  c.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/05.
//

import Foundation
import UIKit
import SnapKit

class ChatTableCell: UITableViewCell {
    
    var id = Int()
    static let identifier = "ChatTableCell"
    // MARK: - UI Components
    
    private lazy var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "customerProfile1.svg")
        imgView.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(20)
        }
        return imgView
    }()
    private lazy var name : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.black
        return label
    }()
    private lazy var date : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    private lazy var pickUp : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    private lazy var location : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.customColor(.darkGray)
        label.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        return label
    }()
    private lazy var locationImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "pin.svg")
        imgView.snp.makeConstraints { make in
            make.height.equalTo(11)
            make.width.equalTo(10)
        }
        return imgView
    }()
    private lazy var infoStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,pickUp,locationStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var locationStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationImage,location])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerImage,infoStackView])
        stackView.axis = .horizontal
        stackView.spacing = 25
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.globalStackView)
        self.contentView.addSubview(self.date)
        globalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview()
        }
        date.snp.makeConstraints { make in
            make.top.equalTo(name)
            make.trailing.equalToSuperview().offset(-10)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
}

extension ChatTableCell{
    public func bindingMatchingSuccess(model: MatchingSuccessResult){
        name.text = model.trainerName
//        date.text = model.orderDate
        date.text = model.createdAt.substring(from: 0, to: 9)
        id = model.matchingId
        pickUp.text = model.pickUp
        
        if(model.pickUp == "트레이너가 갈게요"){
            location.text = model.customerLocation ?? "설정된 위치가 없습니다."
        } else{
            location.text = model.trainerLocation ?? "설정된 위치가 없습니다."
        }

    }
}
