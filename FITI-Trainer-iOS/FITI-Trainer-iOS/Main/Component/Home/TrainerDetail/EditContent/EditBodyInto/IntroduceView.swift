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
    
//    private var introTextView : UITextView = {
//        let textView = UITextView()
//        textView.backgroundColor = UIColor.customColor(.boxGray)
//        textView.textColor = UIColor.customColor(.darkGray)
//        //textView.layer.cornerRadius = 16
//        textView.isEditable = true
//        textView.isScrollEnabled = false
//        textView.font = UIFont.systemFont(ofSize: 15.0)
//         //   textview.text = bodyIntro.introTextView.text
//          //  textView.textContainerInset =  UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
//        textView.text = "다양한 자격증을 바탕으로 친절하게 지도해드립니다. 스포애니 3년의 경력을 믿어주세요~!운동 지도를 비롯하여 저만의 체계적인 식단관리표를 활용하여 PT를 진행할 예정입니다. 단기간의 다이어트는 물론 장기적으로 신체 변화를 가져오는 것 또한 자신이 있습니다. 주 2회의 대면 지도를 권장하며 자세한 커리큘럼은 쪽지를 통해 상세히 설명해 드리겠습니다."
//
//        return textView
//    }()
    
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

