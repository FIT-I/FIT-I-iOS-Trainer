//
//  TrainerCheckViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/10.
//

import Foundation
import UIKit
import SnapKit

class TrainerCheckViewController: UIViewController {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "트레이너 인증"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let schoolTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
                    string: "재학중인 학교를 입력해주세요",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(handleSchoolTfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let majorTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
                    string: "상세 전공을 입력해주세요",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(handleMajorTfDidChange), for: .editingChanged)
        return tf
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "학교 이메일을 입력해주세요."
        label.textColor = UIColor.customColor(.gray)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.customColor(.blue)
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(emailTfDidChange), for: .editingChanged)
        return tf
    }()
    
    let checkEmailButton : UIButton = {
           let btn = UIButton()
            btn.backgroundColor = UIColor.customColor(.gray)
            btn.setTitle("확인", for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            btn.layer.cornerRadius = 4
    
            return btn
        }()

//    lazy var buttonStackView : UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [checkEmailButton,checkNumButton])
//        stackView.axis = .vertical
////        stackView.spacing = 67
//        stackView.alignment = .fill
////        stackView.distribution = .fillProportionally
//        return stackView
//    }()
    
    let checkNumLabel : UILabel = {
        let label = UILabel()
        label.text = "인증번호 6자리를 입력해주세요."
        label.textColor = UIColor.customColor(.gray)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let checkNumTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.customColor(.blue)
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(authNumTfDidChange), for: .editingChanged)
        return tf
    }()
    
    let checkNumButton : UIButton = {
           let btn = UIButton()
            btn.backgroundColor = UIColor.customColor(.gray)
            btn.setTitle("확인", for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            btn.layer.cornerRadius = 4
    
            return btn
        }()
    
    let nextButton : UIButton = {
           let btn = UIButton()
            btn.backgroundColor = UIColor.customColor(.gray)
            btn.setTitle("다음", for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.layer.cornerRadius = 10
            btn.addTarget(self, action: #selector(touchNextBtnEvent), for: .touchUpInside)
            return btn
        }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        // Do any additional setup after loading the view.
        setViewHierarchy()
        setConstraints()
    }
    
    let emailborder = CALayer()
    let checkNumborder = CALayer()
    
    override func viewDidLayoutSubviews() {
            
        emailborder.frame = CGRect(x: 0, y: emailTextField.frame.size.height+12, width: emailTextField.frame.width, height: 1)
        emailborder.backgroundColor = UIColor.customColor(.gray).cgColor
        emailTextField.layer.addSublayer(emailborder)
        
        checkNumborder.frame = CGRect(x: 0, y: checkNumTextField.frame.size.height+12, width: checkNumTextField.frame.width, height: 1)
        checkNumborder.backgroundColor = UIColor.customColor(.gray).cgColor
        checkNumTextField.layer.addSublayer(checkNumborder)
            
        }


    private func setViewHierarchy() {
        
        view.addSubview(titleLabel)
        view.addSubview(schoolTextField)
        view.addSubview(majorTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(checkNumLabel)
        view.addSubview(checkNumTextField)
        view.addSubview(checkNumButton)
        view.addSubview(checkEmailButton)
        view.addSubview(nextButton)
    }
    
    private func setConstraints(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        schoolTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(84)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        majorTextField.snp.makeConstraints { make in
            make.top.equalTo(schoolTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        checkEmailButton.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(65)
            make.centerY.equalTo(emailTextField)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        checkNumButton.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(65)
            make.centerY.equalTo(checkNumTextField)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(majorTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
        }
    
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(emailLabel)
            make.trailing.equalTo(checkEmailButton.snp.leading).offset(-14)
        }
        
        checkNumLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(25)
        }
        
        checkNumTextField.snp.makeConstraints { make in
            make.top.equalTo(checkNumLabel.snp.bottom).offset(8)
            make.leading.equalTo(emailLabel)
            make.trailing.equalTo(checkNumButton.snp.leading).offset(-14)
        }
    
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }
    
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    var school = false
    var major = false
    var email = false
    var auth = false
    
    @objc func handleSchoolTfDidChange(_ textField: UITextField) {
        schoolTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        school = true
        if(school && major && email && auth){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    @objc func handleMajorTfDidChange(_ textField: UITextField) {
        majorTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        major = true
        if(school && major && email && auth){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    @objc func emailTfDidChange(_ textField: UITextField) {
        emailborder.backgroundColor = UIColor.customColor(.blue).cgColor
        emailTextField.layer.addSublayer(emailborder)
        emailLabel.textColor = UIColor.customColor(.blue)
        checkEmailButton.backgroundColor = UIColor.customColor(.blue)
        email = true
        if(school && major && email && auth){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    @objc func authNumTfDidChange(_ textField: UITextField) {
        checkNumborder.backgroundColor = UIColor.customColor(.blue).cgColor
        checkNumTextField.layer.addSublayer(checkNumborder)
        checkNumLabel.textColor = UIColor.customColor(.blue)
        checkNumButton.backgroundColor = UIColor.customColor(.blue)
        auth = true
        if(school && major && email && auth){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    @objc func touchNextBtnEvent() {
        if(nextButton.backgroundColor == UIColor.customColor(.blue)){
            let nextVC = MakeAccountViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

}
