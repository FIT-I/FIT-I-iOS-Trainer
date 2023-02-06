//
//  resetPwViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class resetPwViewController: UIViewController {

    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "비밀번호 변경"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var newPwLabel : UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    var newPwCheckLabel : UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호 확인"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    private let newPwTextField : UITextField = {
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
        tf.isSecureTextEntry = true
        tf.setLeftPaddingPoints(10)
//        tf.addTarget(self, action: #selector(newPwTfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let checkPwTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
                    string: "비밀번호를 확인해주세요.",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.isSecureTextEntry = true
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(pwCheckTfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let pwRuleLabel : UILabel = {
        let label = UILabel()
        label.text = "(영문, 숫자, 특수문자(! @ # $ % ^ & + =) 를 포함해 5자 이상으로 입력해주세요)"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    private let wrongPwLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.systemBackground
        return label
    }()
    
    let pwEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
        btn.addTarget(self, action: #selector(touchPwEyeBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    let pwCheckEyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
        btn.addTarget(self, action: #selector(touchCheckEyeBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    let changePwBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.gray)
        btn.setTitle("비밀번호 변경", for: .normal)
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
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePwTfDidChange(_:)), name: UITextField.textDidChangeNotification, object: newPwTextField)
        
        setViewHierarchy()
        setConstraints()
        
        self.dismissKeyboard()
    }
    
    func setViewHierarchy(){
        view.addSubview(myPageTitleLabel)
        view.addSubview(newPwLabel)
        view.addSubview(newPwTextField)
        view.addSubview(pwRuleLabel)
        view.addSubview(newPwCheckLabel)
        view.addSubview(checkPwTextField)
        view.addSubview(pwEyeButton)
        view.addSubview(pwCheckEyeButton)
        view.addSubview(wrongPwLabel)
        view.addSubview(changePwBtn)
    }
    
    func setConstraints(){
        
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        newPwLabel.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(59)
            make.leading.equalToSuperview().offset(25)
        }
        
        newPwTextField.snp.makeConstraints { make in
            make.top.equalTo(newPwLabel.snp.bottom).offset(3)
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        pwRuleLabel.snp.makeConstraints { make in
            make.top.equalTo(newPwTextField.snp.bottom).offset(1)
            make.leading.equalToSuperview().offset(30)
        }
        
        newPwCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(newPwTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(25)
        }
        
        checkPwTextField.snp.makeConstraints { make in
            make.top.equalTo(newPwCheckLabel.snp.bottom).offset(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        pwEyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(newPwTextField)
            make.trailing.equalTo(newPwTextField).offset(-20)
        }
        
        pwCheckEyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkPwTextField)
            make.trailing.equalTo(checkPwTextField).offset(-20)
        }
        
        wrongPwLabel.snp.makeConstraints { make in
            make.top.equalTo(checkPwTextField.snp.bottom).offset(1)
            make.leading.equalTo(checkPwTextField).offset(10)
        }
        
        changePwBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchNextBtnEvent(sender: UIBarButtonItem) {
        if(wrongPwLabel.textColor == UIColor.customColor(.green)){
            navigationController?.popViewController(animated: true)
        }
    }
    
    var isPwEyeBtnTap = false
    var isCheckEyeBtnTap = false
    
    @objc func touchPwEyeBtnEvent() {
        if(isPwEyeBtnTap == false){
            pwEyeButton.setImage(UIImage(named: "eye.blue.svg"), for: .normal)
            newPwTextField.isSecureTextEntry = false
            isPwEyeBtnTap = true
            
        } else{
            pwEyeButton.setImage(UIImage(named: "eye.gray.svg"), for: .normal)
            newPwTextField.isSecureTextEntry = true
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
    
//    @objc func newPwTfDidChange(sender: UIBarButtonItem) {
//        if(newPwTextField.text != ""){
//            newPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
//            newPwLabel.textColor = UIColor.customColor(.blue)
//            pwRuleLabel.textColor = .systemBackground
//        }
//        if(newPwTextField.text != checkPwTextField.text){
//            wrongPwLabel.textColor = UIColor.red
//            checkPwTextField.layer.borderColor = UIColor.red.cgColor
//            wrongPwLabel.text = "비밀번호가 일치하지 않습니다."
//            newPwCheckLabel.textColor = UIColor.red
//        }
//        if(newPwTextField.text == checkPwTextField.text){
//            wrongPwLabel.text = "새로운 비밀번호와 일치합니다."
//            wrongPwLabel.textColor = UIColor.customColor(.green)
//            checkPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
//            newPwLabel.textColor = UIColor.customColor(.blue)
//            newPwCheckLabel.textColor = UIColor.customColor(.blue)
//            changePwBtn.backgroundColor = UIColor.customColor(.blue)
//
//        }
//    }
    
//    @objc func checkPwTfDidChange(sender: UIBarButtonItem) {
//        if(newPwTextField.text == checkPwTextField.text){
//            wrongPwLabel.text = "새로운 비밀번호와 일치합니다."
//            wrongPwLabel.textColor = UIColor(red: 0.08, green: 0.58, blue: 0.00, alpha: 1.00)
//            checkPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
//            newPwLabel.textColor = UIColor.customColor(.blue)
//            newPwCheckLabel.textColor = UIColor.customColor(.blue)
//            changePwBtn.backgroundColor = UIColor.customColor(.blue)
//
//        }else{
//            wrongPwLabel.textColor = UIColor.red
//            checkPwTextField.layer.borderColor = UIColor.red.cgColor
//            newPwCheckLabel.textColor = UIColor.red
//
//        }
//    }
    
    //비밀번호 유효성 검사 함수
    func checkPw(str: String) -> Bool {
        let pwRegex = "^(?=.*[A-Za-z])(?=.*[!@#$%^&+=])(?=.*[0-9]).{5,}"
        return  NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: str)
    }
    
    //비밀번호 입력 시 실행 함수
    @objc func handlePwTfDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if checkPw(str: text) == false  {
                    newPwLabel.textColor = UIColor.red
                    pwRuleLabel.textColor = UIColor.red
                    newPwTextField.layer.borderColor = UIColor.red.cgColor
                }else{
                    pwRuleLabel.textColor = UIColor.customColor(.green)
                    pwRuleLabel.text = "사용 가능한 비밀번호입니다."
                    newPwLabel.textColor = UIColor.customColor(.blue)
                    newPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
                }
            }
        }
    }
    
    @objc func pwCheckTfDidChange() {
        checkPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        pwRuleLabel.textColor = .systemBackground

        if(newPwTextField.text == ""){
            wrongPwLabel.text = "비밀번호를 먼저 입력해주세요"
            newPwTextField.layer.borderColor = UIColor.red.cgColor
            newPwCheckLabel.textColor = UIColor.red
            wrongPwLabel.textColor = UIColor.red
        } else if(checkPwTextField.text != newPwTextField.text){
            wrongPwLabel.text = "비밀번호가 일치하지 않습니다."
            checkPwTextField.layer.borderColor = UIColor.red.cgColor
            newPwCheckLabel.textColor = UIColor.red
            wrongPwLabel.textColor = UIColor.red
        } else{
            wrongPwLabel.text = "비밀번호가 일치합니다."
            checkPwTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
            wrongPwLabel.textColor = UIColor.customColor(.green)
            newPwCheckLabel.textColor = UIColor.customColor(.blue)
            changePwBtn.backgroundColor = UIColor.customColor(.blue)
        }
    }
}


