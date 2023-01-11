//
//  BodyIntroAboutServiceView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//


import Foundation
import SnapKit
import UIKit

class BodyIntroAboutServiceView : UIView {
    
    var introServiceImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "newspaper.svg")
        return imgView
    }()
    
    var introServiceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "서비스 상세 설명"
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var introServiceTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introServiceImage,introServiceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    var introServiceLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.darkGray)
        return view
    }()
    
    var introServiceTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.customColor(.boxGray)
        textView.textColor = UIColor.customColor(.darkGray)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.text = "운동 지도를 비롯하여 저만의 체계적인 식단관리표를 활용하여 PT를 진행할 예정입니다. 단기간의 다이어트는 물론 장기적으로 신체 변화를 가져오는 것 또한 자신이 있습니다. 주 2회의 대면 지도를 권장하며 자세한 커리큘럼은 쪽지를 통해 상세히 설명해 드리겠습니다."
        return textView
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
        self.addSubview(introServiceTopStackView)
        self.addSubview(introServiceLineView)
        self.addSubview(introServiceTextView)
        
    }
    
    func setConstraints(){
        introServiceTopStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        introServiceLineView.snp.makeConstraints { make in
            make.top.equalTo(introServiceTopStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
        }
        introServiceTextView.snp.makeConstraints { make in
            make.top.equalTo(introServiceLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
//            make.width.equalTo(500)
        }
    }
}

