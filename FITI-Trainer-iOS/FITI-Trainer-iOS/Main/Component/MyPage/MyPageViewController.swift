//
//  MyPageViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    var didProfileShown = true
    var delegate: isProfileShown?
    
    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "마이페이지"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var settingBtn : UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(98)
        }
        btn.setImage(UIImage(named: "gearshape.svg"), for: .normal)
        btn.addTarget(self, action: #selector(settingBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    private var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        return view
    }()

    // 프로필 스택 뷰
    let midProfileStackView = ProfileView()
    
    // 알림 뷰
    let notiView = NotificationSwitch()
    
    // line 뷰
    let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        return view
    }()
    
    // 하단 뷰
    let bottomView = BottomView()
    let bottomBtn = BottomBtnView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
        setViewLayer()
        setViewHierarchy()
        setConstraints()
        
    }
    
    func setViewLayer(){
        notiView.layer.cornerRadius = 10
    }
    
    func setViewHierarchy(){
        
        self.setBtnEvents()

        view.addSubview(myPageTitleLabel)
        view.addSubview(settingBtn)
        view.addSubview(progressView)
        view.addSubview(midProfileStackView)
        view.addSubview(notiView)
        view.addSubview(lineView)
        view.addSubview(bottomView)
        view.addSubview(bottomBtn)
    }
    
    func setConstraints(){

        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        settingBtn.snp.makeConstraints { make in
            make.centerY.equalTo(myPageTitleLabel)
            make.trailing.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        midProfileStackView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-23)
            make.height.equalTo(85)
        }
        notiView.snp.makeConstraints { make in
            make.top.equalTo(midProfileStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(notiView.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        bottomBtn.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc func settingBtnEvent(){
        let nextVC = SettingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    func setBtnEvents(){
        bottomBtn.updateBtn.addTarget(self, action: #selector(updateBtnEvent), for: .touchUpInside)
        bottomBtn.userLocationBtn.addTarget(self, action: #selector(localtionBtnEvent), for: .touchUpInside)
        bottomBtn.noticeBtn.addTarget(self, action: #selector(noticeBtnEvent), for: .touchUpInside)
        bottomBtn.resetPwBtn.addTarget(self, action: #selector(resetPwBtnEvent), for: .touchUpInside)
        bottomBtn.clauseBtn.addTarget(self, action: #selector(clauseBtnEvent), for: .touchUpInside)
        midProfileStackView.fixProfileBtn.addTarget(self, action: #selector(settingProfileBtnEvent), for: .touchUpInside)
        notiView.showProfileBtn.addTarget(self, action: #selector(showProfileBtnEvent), for: .touchUpInside)
    }
    
    @objc func settingProfileBtnEvent(){
        let nextVC = SettingProfileViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func updateBtnEvent(){
        let nextVC = UpdateViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func localtionBtnEvent(){
        let nextVC = SearchViewController()
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func noticeBtnEvent(){
        let nextVC = NoticeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func clauseBtnEvent(){
        let nextVC = ClauseViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func resetPwBtnEvent(){
        let nextVC = resetPwViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
        
    @objc func showProfileBtnEvent(){
        if(didProfileShown == true){
            notiView.showProfileBtn.setImage(UIImage(named: "OFF.svg"), for: .normal)
            didProfileShown = false
            delegate?.isShown(isProfileShown: didProfileShown)
        }else{
            notiView.showProfileBtn.setImage(UIImage(named: "ON.svg"), for: .normal)
            didProfileShown = true
            delegate?.isShown(isProfileShown: didProfileShown)

        }
    }
}

//MARK: - protocol

protocol isProfileShown{
    func isShown(isProfileShown: Bool)
}
