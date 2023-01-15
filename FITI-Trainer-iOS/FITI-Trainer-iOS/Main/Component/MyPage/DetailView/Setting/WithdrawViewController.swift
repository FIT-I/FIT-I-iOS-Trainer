//
//  WithdrawViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class WithdrawViewController: UIViewController {

    
    var appImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "finialLogOut.svg")
        return imgView
    }()
    
    var goBackBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.skyblue1)
        btn.layer.cornerRadius = 8
        btn.setTitle("계정 유지", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
        return btn
    }()
    
    var finialWithDrawBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.boxGray)
        btn.layer.cornerRadius = 8
        btn.setTitle("계정 탈퇴", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        
        setViewHierarchy()
        setConstraints()
    }
    
    func setViewHierarchy(){
        view.addSubview(appImage)
        view.addSubview(finialWithDrawBtn)
        view.addSubview(goBackBtn)
    }
    
    func setConstraints(){
        appImage.snp.makeConstraints { make in
            make.width.equalTo(231)
            make.height.equalTo(260)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
        goBackBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(500)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        finialWithDrawBtn.snp.makeConstraints { make in
            make.top.equalTo(goBackBtn.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func backBtn(){
        let nextVC = TabBarController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

