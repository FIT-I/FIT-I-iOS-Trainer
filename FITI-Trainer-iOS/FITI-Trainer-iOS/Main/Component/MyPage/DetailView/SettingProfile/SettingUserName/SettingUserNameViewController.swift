//
//  SettingUserNameViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import SnapKit
import UIKit

class SettingUserNameViewController : UIViewController {
    
    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "프로필 수정"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewerIcon.svg")
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        return imgView
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "닉네임 수정"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var userNameTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "새로운 닉네임 입력"
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        self.dismissKeyboard()
        
        setViewHierarchy()
        setConstraints()
    }
    
    
    private func setViewHierarchy() {
        view.addSubview(myPageTitleLabel)
        view.addSubview(reviewerImage)
        view.addSubview(titleLabel)
        view.addSubview(userNameTextField)
    }
    
    private func setConstraints() {
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        reviewerImage.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewerImage.snp.bottom).offset(50)
            make.leading.equalTo(30)
        }
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}

