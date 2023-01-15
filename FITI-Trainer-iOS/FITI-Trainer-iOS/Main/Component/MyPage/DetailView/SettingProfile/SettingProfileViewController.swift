//
//  SettingProfileViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class SettingProfileViewController: UIViewController {

    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "프로필 수정"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    // 상단 뷰
    var topStackView = TopStackView()
    
    // 회색 라인 뷰
    var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        return view
    }()
    
    // 하단 뷰
    var bottomInfoView = BottomInfoView()

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
    
    func setViewHierarchy(){
        
        setBtnEvent()
        
        view.addSubview(myPageTitleLabel)
        view.addSubview(topStackView)
        view.addSubview(progressView)
        view.addSubview(bottomInfoView)
    }
    
    func setConstraints(){
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(30)
//            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        bottomInfoView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            
        }
    }
    
    func setBtnEvent(){
        topStackView.settingUserProfile.addTarget(self, action: #selector(settingUserName), for: .touchUpInside)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func settingUserName(){
        let nextVC = SettingUserNameViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}

