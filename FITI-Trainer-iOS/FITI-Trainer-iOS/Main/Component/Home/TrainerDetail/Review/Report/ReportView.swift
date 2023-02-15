//
//  ReportView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/14.
//

import UIKit
import SnapKit

class ReportView: UIView {

    lazy var reportReason = ""

    // Buttons
    lazy var firstPickBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(firstBtnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
        return btn
    }()

    lazy var secondPickBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
        btn.addTarget(self, action: #selector(secondBtnPressed), for: .touchUpInside)
        return btn
    }()

    lazy var thirdPickBtn: UIButton =  {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
        btn.addTarget(self, action: #selector(thirdBtnPressed), for: .touchUpInside)
        return btn
    }()

    lazy var fourthPickBtn: UIButton =  {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
        btn.addTarget(self, action: #selector(fourthBtnPressed), for: .touchUpInside)
        return btn
    }()

    lazy var fifthPickBtn: UIButton =  {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
        btn.addTarget(self, action: #selector(fifthBtnPressed), for: .touchUpInside)
        return btn
    }()

    // Labels
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "요청서와 관련없는 광고/홍보/영업"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()

    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "허위 프로필 작성"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()

    lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "유효하지 않은 카카오톡 링크"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()

    lazy var fourthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "부적절한 언어(욕설, 성희롱 등) 사용"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()

    lazy var fifthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "관련 법령 등을 위반하는 요청"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()

    // stackView
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstPickBtn, firstLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondPickBtn, secondLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    lazy var thirdStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirdPickBtn, thirdLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    lazy var fourthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fourthPickBtn, fourthLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    lazy var fifthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fifthPickBtn, fifthLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    // 전체 stackView
    
    lazy var globalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
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

    private func setViewHierarchy() {
        self.addSubview(globalStackView)
    }

    private func setConstraints() {
        globalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
        }
    }

    @objc func firstBtnPressed (_ sender: UIButton) {
        if firstPickBtn.imageView?.image == UIImage(named: "circle.fill.svg"){ firstPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = ""
        }
        else if firstPickBtn.imageView?.image == UIImage(named: "lessthan.circle.svg"){
            firstPickBtn.setImage(UIImage(named: "circle.fill.svg"), for: .normal)
            
            secondPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            thirdPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fourthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fifthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = "AD"
        }
    }

    @objc func secondBtnPressed (_ sender: UIButton) {
        if secondPickBtn.imageView?.image == UIImage(named: "circle.fill.svg"){ secondPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = ""
        }
        else if secondPickBtn.imageView?.image == UIImage(named: "lessthan.circle.svg"){
            secondPickBtn.setImage(UIImage(named: "circle.fill.svg"), for: .normal)
            
            firstPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            thirdPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fourthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fifthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = "FAKE_PROFILE"
        }
    }

    @objc func thirdBtnPressed (_ sender: UIButton) {
        if thirdPickBtn.imageView?.image == UIImage(named: "circle.fill.svg"){ thirdPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = ""
        }
        else if thirdPickBtn.imageView?.image == UIImage(named: "lessthan.circle.svg"){
            thirdPickBtn.setImage(UIImage(named: "circle.fill.svg"), for: .normal)
            
            secondPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            firstPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fourthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fifthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = "INVALID_LINK"
        }
    }

    @objc func fourthBtnPressed (_ sender: UIButton) {
        if fourthPickBtn.imageView?.image == UIImage(named: "circle.fill.svg"){ fourthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = ""
        }
        else if fourthPickBtn.imageView?.image == UIImage(named: "lessthan.circle.svg"){
            fourthPickBtn.setImage(UIImage(named: "circle.fill.svg"), for: .normal)
            
            thirdPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            secondPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            firstPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            fifthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = "BAD_WORD"
        }
    }

    @objc func fifthBtnPressed (_ sender: UIButton) {
        if fifthPickBtn.imageView?.image == UIImage(named: "circle.fill.svg"){ fifthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = ""
        }
        else if fifthPickBtn.imageView?.image == UIImage(named: "lessthan.circle.svg"){
            fifthPickBtn.setImage(UIImage(named: "circle.fill.svg"), for: .normal)
            
            fourthPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            thirdPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            secondPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            firstPickBtn.setImage(UIImage(named: "lessthan.circle.svg"), for: .normal)
            reportReason = "ILLEGAL"
        }
    }
}
