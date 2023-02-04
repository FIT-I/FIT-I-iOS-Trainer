//
//  RequestSheet.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//

import Foundation
import SnapKit
import UIKit

class RequestSheet : UIView {
    
    var requsetIcon : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(named: "pickService.svg")
        return image
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "서비스 종류"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var hourLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "1시간"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var hourPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "20,000원"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var totalLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "총 금액"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var totalPriceLabel : UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 15.0)
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "30,000원"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var meetingDateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "매칭 날짜"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var meetingDate : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "23.1.18~23.1.25 (8일)"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var pickUpLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "픽업 형태"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var pickUp : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "제가 매칭 상대의 주소로 갈게요."
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var pickUpLocation : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "매칭 장소"
        label.textColor = UIColor.customColor(.blue)
        label.isHidden = true
        return label
    }()
    
    var userPickUpLocation : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "서울시~~"
        label.textColor = UIColor.customColor(.blue)
        label.isHidden = true

        return label
    }()
    
    var lineView0 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    var lineView1 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    var lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    var lineView3 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    var lineView4 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    lazy var topStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [requsetIcon,titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.customColor(.boxGray)
        self.layer.cornerRadius = 8
    }
    
    func setViewHierarchy(){
        self.addSubview(topStackView)
        self.addSubview(lineView0)
        
        self.addSubview(hourLabel)
        self.addSubview(hourPriceLabel)
        
        self.addSubview(lineView1)
        self.addSubview(totalLabel)
        self.addSubview(totalPriceLabel)
        
        self.addSubview(lineView2)
        self.addSubview(meetingDateLabel)
        self.addSubview(meetingDate)
        
        self.addSubview(lineView3)
        self.addSubview(pickUpLabel)
        self.addSubview(pickUp)
        
        self.addSubview(lineView4)
        self.addSubview(pickUpLocation)
        self.addSubview(userPickUpLocation)
        
        
    }
    
    func setConstraints(){
        
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(18)
        }
        lineView0.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView0.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
        }
        hourPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView0.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(hourPriceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
        }
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        meetingDateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
        }
        meetingDate.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
        lineView3.snp.makeConstraints { make in
            make.top.equalTo(meetingDateLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        pickUpLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
        }
        pickUp.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        lineView4.snp.makeConstraints { make in
            make.top.equalTo(pickUpLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        pickUpLocation.snp.makeConstraints { make in
            make.top.equalTo(lineView4.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
        }
        userPickUpLocation.snp.makeConstraints { make in
            make.top.equalTo(lineView4.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
        
    }


}
