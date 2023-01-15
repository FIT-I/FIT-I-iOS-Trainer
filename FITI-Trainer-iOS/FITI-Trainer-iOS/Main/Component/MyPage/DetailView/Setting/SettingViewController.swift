//
//  SettingViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    var appImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "realLogOut.svg")
        return imgView
    }()
    
    var logOutBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.boxGray)
        btn.layer.cornerRadius = 8
        btn.setTitle("로그아웃", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.addTarget(self, action: #selector(logOutBtnEvent), for: .touchUpInside)
        return btn
    }()

    var withDrawBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.boxGray)
        btn.layer.cornerRadius = 8
        btn.setTitle("회원탈퇴", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.addTarget(self, action: #selector(withDrawBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setViewHierarchy()
        setConstraints()
        
    }
    
    func setViewHierarchy(){
        view.addSubview(appImage)
        view.addSubview(logOutBtn)
        view.addSubview(withDrawBtn)
    }
    
    func setConstraints(){
        appImage.snp.makeConstraints { make in
            make.width.equalTo(209)
            make.height.equalTo(219)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
        logOutBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(500)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        withDrawBtn.snp.makeConstraints { make in
            make.top.equalTo(logOutBtn.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func logOutBtnEvent(){
        let alert = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let noAction = UIAlertAction(title: "취소", style: .destructive, handler: { okAction in
        })
        
        let okAction = UIAlertAction(title: "로그아웃", style: .default, handler: { okAction in
        })
        
        alert.addAction(noAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func withDrawBtnEvent(){
        let nextVC = WithdrawViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }


}

