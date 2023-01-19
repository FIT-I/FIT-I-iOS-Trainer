//
//  emailCheckViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import UIKit
import SnapKit

class emailCheckViewController: UIViewController {
    
    var isAllTrue = [false,false]
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "트레이너 인증"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let emailTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
                    string: "학교 이메일을 입력해주세요",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        return tf
    }()
    
    private let warningLabelForEmail : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Noto Sans", size: 10)
        return label
    }()
    
    private let warningLabelForAuth : UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let authTextField : UITextField = {
        let tf = UITextField()
        tf.isHidden = true
//        tf.attributedPlaceholder = NSAttributedString(
//                    string: "인증코드 6자리를 입력해주세요",
//                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
//                )
//        tf.layer.borderColor = UIColor.white.cgColor
        
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.attributedPlaceholder = NSAttributedString(
                    string: "인증코드 6자리를 입력해주세요",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
//        tf.addTarget(self, action: #selector(handleAuthTfDidChange), for: .editingChanged)
        return tf
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleEmailTfDidChange(_:)), name: UITextField.textDidChangeNotification, object: emailTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAuthTfDidChange(_:)), name: UITextField.textDidChangeNotification, object: authTextField)
        
        // Do any additional setup after loading the view.
        setViewHierarchy()
        setConstraints()
        
        self.dismissKeyboard()

    }

    private func setViewHierarchy() {
        
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        progressView.addSubview(grayView)
        view.addSubview(emailTextField)
        view.addSubview(authTextField)
        view.addSubview(nextButton)
        view.addSubview(warningLabelForAuth)
        view.addSubview(warningLabelForEmail)
    }
    
    private func setConstraints(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        grayView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(68)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        warningLabelForEmail.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(3)
            make.leading.equalTo(emailTextField).offset(10)
        }
        
        authTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        warningLabelForAuth.snp.makeConstraints { make in
            make.top.equalTo(authTextField.snp.bottom).offset(3)
            make.leading.equalTo(authTextField).offset(10)
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
    
    
    var nextBtn = 0
    
    @objc func handleSchoolTfDidChange(_ textField: UITextField) {
        if(emailTextField.text != ""){
            nextButton.backgroundColor = UIColor.customColor(.blue)
            emailTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        }
        nextBtn = 1
    }
    
    @objc func handleAuthTfDidChange(_ notification: Notification) {
        
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count < 6  {
                    warningLabelForAuth.text = "6자리를 입력해주세요"
                    warningLabelForAuth.textColor = .red
                    authTextField.layer.borderColor = UIColor.red.cgColor

                    self.isAllTrue[1] = false
                }else if(text.count == 6){
                    warningLabelForAuth.text = ""
                    warningLabelForAuth.textColor = .clear
                    authTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
                    nextButton.backgroundColor = UIColor.customColor(.blue)

                    self.isAllTrue[1] = true
                }else{
                    warningLabelForAuth.text = "6자리를 입력해주세요"
                    warningLabelForAuth.textColor = .red
                    authTextField.layer.borderColor = UIColor.red.cgColor
                    
                    self.isAllTrue[1] = false

                }
            }
        }
    }
    
    @objc func touchNextBtnEvent() {
        print(nextBtn)
        if(isAllTrue[1]){
            let nextVC = MakeAccountViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        } else if(isAllTrue[0]){ //올바른 이메일 형식이 입력되었을 때
            //major  textField 활성화
            authTextField.isHidden = false
            warningLabelForEmail.isHidden = true
            //버튼 다시 회색으로
            nextButton.backgroundColor = UIColor.customColor(.gray)
    
        }
    }
    
    @objc func handleEmailTfDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count < 1  {
                    warningLabelForEmail.text = "이메일을 입력해주세요."
                    warningLabelForEmail.textColor = .red
                    emailTextField.layer.borderColor = UIColor.red.cgColor

                    self.isAllTrue[0] = false
                }else{
                    if checkEmail(str: text) == false {
                        warningLabelForEmail.text = "올바르지 않은 이메일 형식입니다."
                        warningLabelForEmail.textColor = .red
                        emailTextField.layer.borderColor = UIColor.red.cgColor

                        self.isAllTrue[0] = false
                    }
                    else {
                        warningLabelForEmail.text = "올바른 이메일 형식입니다."
                        warningLabelForEmail.textColor = UIColor.customColor(.green)
                        emailTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
                        nextButton.backgroundColor = UIColor.customColor(.blue)

                        self.isAllTrue[0] = true
                    }
                }
            }
        }
    }
    
    //이메일 형식 검사 함수 - true || false 반환
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        print("check")
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    

}

