//
//  EditBodyPriceViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit
import SnapKit

class EditBodyPriceViewController: UIViewController {

    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "가격 선택"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
        return view
    }()
    
    var grayView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
        return view
    }()
    
    var priceTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "금액 (1시간 기준)"
        label.textColor = UIColor.black
        return label
    }()
    
    var extraPriceTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "기타 (1시간 기준 / 직접 입력해 주세요.)"
        label.textColor = UIColor.black
        return label
    }()
    
    var extraPickBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "emptyBox.svg"), for: .normal)
//        btn.addTarget(EditBodyPriceView.self, action: #selector(hourBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    private let extraPriceTextField : UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(handleExtraTfDidChange), for: .editingChanged)
        return tf
    }()
    
//    lazy var extraPriceStackView : UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [extraPickBtn,extraPriceTextField])
//        stackView.axis = .horizontal
//        stackView.spacing = 15
//        stackView.alignment = .leading
//        return stackView
//    }()
//
    private let nextBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.blue)
        btn.layer.cornerRadius = 8
        btn.setTitle("다음", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customColor(.blue).cgColor
        btn.addTarget(self, action: #selector(nextEvent), for: .touchUpInside)
        return btn
    }()

    // 왼쪽 버튼 부분
    var priceStackView = EditBodyPriceView()
    
    // 오른쪽 금액 Label 부분
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        // Do any additional setup after loading the view.
        setViewHierarchy()
        setConstraints()
        self.dismissKeyboard()

    }
    
    private func setViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        progressView.addSubview(grayView)
        view.addSubview(priceTitleLabel)
        view.addSubview(nextBtn)
        view.addSubview(priceStackView)
        view.addSubview(extraPriceTitleLabel)
        view.addSubview(extraPickBtn)
        view.addSubview(extraPriceTextField)
    }
    
    private func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        grayView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        priceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(30)
        }
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
//            make.height.equalTo(80)
        }
        
        extraPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).offset(42)
            make.leading.equalTo(priceTitleLabel)
        }
        
        extraPickBtn.snp.makeConstraints { make in
            make.top.equalTo(extraPriceTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        extraPriceTextField.snp.makeConstraints { make in
            make.top.equalTo(extraPickBtn)
//            make.top.equalTo(extraPriceTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(extraPickBtn.snp.trailing).offset(16)
//            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(30)
        }
        
        
//        extraPriceStackView.snp.makeConstraints { make in
//            make.top.equalTo(extraPriceTitleLabel.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//        }
        
        nextBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    @objc func nextEvent(){
        let nextVC = TrainerDetailViewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleExtraTfDidChange(_ textField: UITextField) {
        if(extraPriceTextField.text == ""){
            extraPriceTextField.layer.borderColor = UIColor.customColor(.gray).cgColor
        }else{
            extraPriceTextField.layer.borderColor = UIColor.customColor(.blue).cgColor

        }
        
    }
    
}
