//
//  SignInViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import Foundation
import UIKit
import SnapKit

class SignInViewController: UIViewController {

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "CUSTOMER LOG_IN"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Noto Sans", size: 24)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    
    let idTextField : UITextField = {
        let tf = UITextField()
        
        tf.attributedPlaceholder = NSAttributedString(
                string: "아이디",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.blue)]
            )
        tf.layer.cornerRadius = 10
        tf.borderStyle = .none
        
        return tf
    }()

    let passwordTextField : UITextField = {
        let tf = UITextField()

        //placeholder 색 지정
        tf.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.blue)]
        )

        return tf
    }()

    let findPasswordButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .none
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        return btn
    }()

    let signUpButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .none
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(signUpBtnEvent), for: .touchUpInside)
        return btn
    }()

    private let horizontalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.

        signInViewAddUI()
        signInViewSetUI()

    }
    
    //bottom stroke
    override func viewDidLayoutSubviews() {

        let idborder = CALayer()
        let pwborder = CALayer()

        pwborder.frame = CGRect(x: 0, y: passwordTextField.frame.size.height+12, width: passwordTextField.frame.width, height: 1)
        pwborder.backgroundColor = UIColor.customColor(.blue).cgColor
        passwordTextField.layer.addSublayer(pwborder)
        
        idborder.frame = CGRect(x: 0, y: idTextField.frame.size.height + 12, width: idTextField.frame.width, height: 1)
        idborder.backgroundColor = UIColor.customColor(.blue).cgColor
        idTextField.layer.addSublayer(idborder)
    }

    func signInViewAddUI(){

        
        horizontalStackView.addArrangedSubview(findPasswordButton)
        horizontalStackView.addArrangedSubview(signUpButton)

        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(horizontalStackView)
    }


    func signInViewSetUI(){

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }


    }
    
    @objc func signUpBtnEvent(){
        let nextVC = PolicyViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}
