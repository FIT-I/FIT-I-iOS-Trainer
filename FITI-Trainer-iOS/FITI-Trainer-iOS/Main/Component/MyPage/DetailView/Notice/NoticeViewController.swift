//
//  NoticeViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class NoticeViewController: UIViewController {
    
    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 25.0)
        label.text = "공지사항"
        label.textColor = UIColor.black
        return label
    }()
    
    private var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
        return view
    }()
    
    private var touchLineBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(tapUpdateEvent), for: .touchUpInside)
//        btn.backgroundColor = .systemMint
        return btn
    }()
    
    private var touchSecLineBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(tapPrivacyEvent), for: .touchUpInside)
//        btn.backgroundColor = .systemMint
        return btn
    }()
    
    
    
    let bottomLabelStack = NoticeLabelView()
    let bottomBtnStack = NoticeBtnView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setViewHierarchy()
        setConstraints()
        setBtnEvents()
    }
    
    func setViewHierarchy(){
        view.addSubview(myPageTitleLabel)
        view.addSubview(progressView)
        view.addSubview(touchLineBtn)
        view.addSubview(bottomLabelStack)
        view.addSubview(bottomBtnStack)
        view.addSubview(touchSecLineBtn)



    }
    
    func setConstraints(){
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        bottomLabelStack.snp.makeConstraints { make in
            make.top.equalTo(progressView).offset(18)
            make.leading.equalToSuperview().offset(20)
            
        }
        
        bottomBtnStack.snp.makeConstraints { make in
            make.top.equalTo(bottomLabelStack)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        touchLineBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(progressView).offset(20)
            make.height.equalTo(bottomLabelStack.updateNoticeLabel)
        }
        
        touchSecLineBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(bottomLabelStack.privacyNoticeLabel)
            make.height.equalTo(bottomLabelStack.updateNoticeLabel)
        }
    }
    
    func setBtnEvents(){
//        let tapNoticeLabel = UITapGestureRecognizer(target: self, action: #selector(tapUpdateEvent))
//        let tapPrivacyLabel = UITapGestureRecognizer(target: self, action: #selector(tapPrivacyEvent))
//        bottomStack.updateNoticeDateLabel.addGestureRecognizer(tapNoticeLabel)
//        bottomStack.privacyNoticeLabel.addGestureRecognizer(tapPrivacyLabel)
//
//        bottomStack.goUpdateNoticeBtn.addTarget(self, action: #selector(tapUpdateEvent), for: .touchUpInside)
//        bottomStack.goPrivacyNoticeBtn.addTarget(self, action: #selector(tapPrivacyEvent), for: .touchUpInside)
       

    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapUpdateEvent(){
        let nextVC = UpdateNoticeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func tapPrivacyEvent(){
        let nextVC = PrivacyNoticeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }


}

