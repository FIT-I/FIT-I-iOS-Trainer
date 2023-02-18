//
//  NoticeBtnView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//


import Foundation
import UIKit
import SnapKit

class NoticeTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "NoticeTableCell"
    var newsText = String()
    
    // MARK: - UI Components

    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.black
        return label
    }()
    var date : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    private lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.date)
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(20)
        }
        date.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
}

//MARK: - Extension

extension NoticeTableCell {
    public func bindingNoticeList(model:news){
        name.text = model.title
        date.text = model.createdAt
        newsText = model.contents ?? ""
    }
}
