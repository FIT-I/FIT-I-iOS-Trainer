//
//  MakeAccountViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/10.
//

import Foundation
import UIKit
import SnapKit

class MakeAccountViewController: UIViewController {
    var isAllTrue = [false,false,false,false]

    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "회원가입"
        label.textColor = UIColor.customColor(.blue)
        return label
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
    
    var nameTextField : UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = true
        tf.attributedPlaceholder = NSAttributedString(
            string: "이름을 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
        )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(nameTfDidChange), for: .editingChanged)
        return tf
    }()
    
    var emailTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
            string: "이메일을 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
        )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(emailTfDidChange), for: .editingChanged)
        return tf
    }()
    
    var pwTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
            string: "비밀번호를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
        )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    var checkPwTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
            string: "비밀번호를 확인해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
        )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.isSecureTextEntry = true
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(pwCheckTfDidChange), for: .editingChanged)
        return tf
    }()
    
    var pwRuleLabel : UILabel = {
        let label = UILabel()
        label.text = "(영문, 숫자, 특수문자(! @ # $ % ^ & + =) 를 포함해 5자 이상으로 입력해주세요)"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    var wrongPwLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.systemBackground
        return label
    }()
    
    var pwEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
        btn.addTarget(self, action: #selector(touchPwEyeBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    var pwCheckEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
        btn.addTarget(self, action: #selector(touchCheckEyeBtnEvent), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePwTfDidChange(_:)), name: UITextField.textDidChangeNotification, object: pwTextField)
        
        setViewHierarchy()
        setConstraints()
        
        self.dismissKeyboard()

    }

    private func setViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(pwTextField)
        view.addSubview(pwRuleLabel)
        view.addSubview(checkPwTextField)
        view.addSubview(pwEyeButton)
        view.addSubview(pwCheckEyeButton)
        view.addSubview(wrongPwLabel)
    }
    
    private func setConstraints(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(84)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)

        }

        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)

        }

        pwRuleLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(3)
            make.leading.equalTo(pwTextField).offset(20)
        }

        checkPwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwRuleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)

        }

        pwEyeButton.snp.makeConstraints { make in
            make.height.equalTo(13.64)
            make.centerY.equalTo(pwTextField)
            make.trailing.equalTo(pwTextField).offset(-20)
        }

        pwCheckEyeButton.snp.makeConstraints { make in
            make.height.equalTo(13.64)
            make.centerY.equalTo(checkPwTextField)
            make.trailing.equalTo(checkPwTextField).offset(-20)
        }

        wrongPwLabel.snp.makeConstraints { make in
            make.top.equalTo(checkPwTextField.snp.bottom).offset(1)
            make.leading.equalTo(checkPwTextField).offset(20)
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
    
    @objc func touchNextBtnEvent() {
        if(nextButton.backgroundColor == UIColor.customColor(.blue)){
            let nextVC = GradeTableViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    var isPwEyeBtnTap = false
    var isCheckEyeBtnTap = false
    var email = false
    var name = false
    var pw = false
    var pwCheck = false
    
    @objc func touchPwEyeBtnEvent() {
        if(isPwEyeBtnTap == false){
            pwEyeButton.setImage(UIImage(named: "eye.blue.svg"), for: .normal)
            pwTextField.isSecureTextEntry = false
            isPwEyeBtnTap = true

        } else{
            pwEyeButton.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
            pwTextField.isSecureTextEntry = true
            isPwEyeBtnTap = false
        }
    }
    
    @objc func touchCheckEyeBtnEvent() {
        if(isCheckEyeBtnTap == false){
            checkPwTextField.isSecureTextEntry = false
            pwCheckEyeButton.setImage(UIImage(named: "eye.blue.svg"), for: .normal)
            isCheckEyeBtnTap = true

        } else{
            pwCheckEyeButton.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
            checkPwTextField.isSecureTextEntry = true
            isCheckEyeBtnTap = false
        }
    }
    
    @objc func nameTfDidChange() {
        nameTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        name = true
        if(email && name && pw && pwCheck){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
        }
    
    @objc func emailTfDidChange() {
        emailTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        email = true
        if(email && name && pw && pwCheck){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
        }
    
    @objc func pwCheckTfDidChange() {
        checkPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor

        if(pwTextField.text == ""){
            wrongPwLabel.text = "비밀번호를 먼저 입력해주세요"
            wrongPwLabel.textColor = UIColor.red
        } else if(checkPwTextField.text != pwTextField.text){
            wrongPwLabel.text = "비밀번호가 일치하지 않습니다."
            wrongPwLabel.textColor = UIColor.red
        } else{
            wrongPwLabel.textColor = UIColor.systemBackground
            pwRuleLabel.textColor = .systemBackground
            pwCheck = true
        }
        if(email && name && pw && pwCheck){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    func checkPw(str: String) -> Bool {
        let pwRegex = "^(?=.*[A-Za-z])(?=.*[!@#$%^&+=])(?=.*[0-9]).{5,}"
//        let emailRegex = "^([A-Za-z\d@!%*?&]).{5,}"
//        print("check")
        return  NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: str)
    }
    
    @objc func handlePwTfDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if checkPw(str: text) == false  {
                    pwRuleLabel.textColor = UIColor.red
                    pwTextField.layer.borderColor = UIColor.red.cgColor
                    pw = false

                }else{
                    isAllTrue[2] = true
                    pwRuleLabel.textColor = UIColor.customColor(.green)
                    pwRuleLabel.text = "사용 가능한 비밀번호입니다."
                    pwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
                    pw = true
                    if(email && name && pw && pwCheck){
                        nextButton.backgroundColor = UIColor.customColor(.blue)
                    }
                }
            }
        }
    }

    
}




