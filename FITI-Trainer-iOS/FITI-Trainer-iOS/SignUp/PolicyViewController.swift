//
//  PolicyViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/08.
//

import Foundation
import UIKit
import SnapKit

class PolicyViewController: UIViewController {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "이용약관"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    //약관 전체 동의 UI
    private let acceptAllLabel : UILabel = {
        let label = UILabel()
        label.text = "전체동의"
        label.font = UIFont(name: "Noto Sans", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let acceptAllButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "check.svg"), for: .normal)
        btn.addTarget(self, action: #selector(selectBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    private let lineStackView0 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
//        stackView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
//        stackView.layer.cornerRadius = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    var grayView : UIView = {
            let view = UIView()
        view.backgroundColor = UIColor.customColor(.blue)
            view.snp.makeConstraints { make in
                make.height.equalTo(0.5)
            }
            return view
        }()
    
    
    //서비스 약관 동의 UI
    private let acceptLabel1 : UILabel = {
        let label = UILabel()
        label.text = "(필수) 서비스 이용약관 동의"
        label.font = UIFont(name: "Noto Sans", size: 15)
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let acceptButton1 : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "check.svg"), for: .normal)
        btn.addTarget(self, action: #selector(selectBtn1Event), for: .touchUpInside)
        return btn
    }()
    
    private let lineStackView1 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        return stackView
    }()
    
    //개인정보 약관 동의 UI
    private let acceptLabel2 : UILabel = {
        let label = UILabel()
        label.text = "(필수) 개인정보 처리 방침 동의"
        label.font = UIFont(name: "Noto Sans", size: 15)
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let acceptButton2 : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "check.svg"), for: .normal)
        btn.addTarget(self, action: #selector(selectBtn2Event), for: .touchUpInside)
        return btn
    }()

    
    private let lineStackView2 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        return stackView
    }()
    
    //전자금융거래 약관 동의 UI
    private let acceptLabel3 : UILabel = {
        let label = UILabel()
        label.text = "(필수) 전자금융거래 이용약관 동의"
        label.font = UIFont(name: "Noto Sans", size: 15)
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let acceptButton3 : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "check.svg"), for: .normal)
        btn.addTarget(self, action: #selector(selectBtn3Event), for: .touchUpInside)
        return btn
    }()
    
    private let lineStackView3 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var  globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lineStackView1,lineStackView2,lineStackView3])
//        lineStackView0.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(12)
//        }
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let nextButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.gray)
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
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
        
        // Do any additional setup after loading the view.
        setViewHierarchy()
        setConstraints()
        
        self.dismissKeyboard()
    }
    
    private func setViewHierarchy() {
        view.addSubview(titleLabel)
        
        lineStackView0.addArrangedSubview(acceptAllButton)
        lineStackView0.addArrangedSubview(acceptAllLabel)
        
        lineStackView1.addArrangedSubview(acceptButton1)
        lineStackView1.addArrangedSubview(acceptLabel1)

        lineStackView2.addArrangedSubview(acceptButton2)
        lineStackView2.addArrangedSubview(acceptLabel2)

        lineStackView3.addArrangedSubview(acceptButton3)
        lineStackView3.addArrangedSubview(acceptLabel3)
        
        view.addSubview(lineStackView0)
        view.addSubview(grayView)
        view.addSubview(globalStackView)
        view.addSubview(nextButton)

    }
    
    private func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
            
        }
        
//        acceptAllLabel.snp.makeConstraints { make in
//            make.leading.equalTo(acceptAllButton.snp.trailing).offset(12)
//            make.trailing.equalTo(globalStackView)
//        }
        
        lineStackView0.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(84)
            make.leading.equalToSuperview().offset(20)
            
        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(lineStackView0.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        globalStackView.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
    
    var count = 0
    var tapBtn = false
    var tapBtn1 = false
    var tapBtn2 = false
    var tapBtn3 = false
    var tapNextBtn = false

    @objc func selectBtn1Event() {
        if(tapBtn1 == false){
            acceptButton1.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            tapBtn1 = true
            count+=1
            
            //3개의 버튼 중 해당 버튼이 마지막으로 눌리는 버튼일 때(3개가 다 체크되는 순간, 전체 동의 버튼도 같이 체크되도록)
            if(count == 3){
                acceptAllButton.setImage(UIImage(named: "check.fill.svg"), for: .normal)
                tapBtn = true
                nextButton.backgroundColor = UIColor.customColor(.blue)
                tapNextBtn = true
            }
            
        } else{
            acceptButton1.setImage(UIImage(named: "check.svg"), for: .normal)
            tapBtn1 = false
            count-=1
            
            //눌린 버튼이 3개에서 2개가 되는 순간, 전체동의 버튼 해제
            if(count == 2){
                acceptAllButton.setImage(UIImage(named: "check.all.svg"), for: .normal)
                tapBtn = false
                nextButton.backgroundColor = UIColor.customColor(.gray)
                tapNextBtn = false
        
            }
            
            
        }
        
    }
    
    @objc func selectBtn2Event() {
        if(tapBtn2 == false){
            acceptButton2.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            tapBtn2 = true
            count+=1
            
            if(count == 3){
                acceptAllButton.setImage(UIImage(named: "check.fill.svg"), for: .normal)
                tapBtn = true
                nextButton.backgroundColor = UIColor.customColor(.blue)
                tapNextBtn = true
            }
            
        } else{
            acceptButton2.setImage(UIImage(named: "check.svg"), for: .normal)
            tapBtn2 = false
            count-=1
            
            if(count == 2){
                acceptAllButton.setImage(UIImage(named: "check.all.svg"), for: .normal)
                tapBtn = false
                nextButton.backgroundColor = UIColor.customColor(.gray)
                tapNextBtn = false
            }
        }
        
    }
    
    @objc func selectBtn3Event() {
        if(tapBtn3 == false){
            acceptButton3.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            tapBtn3 = true
            count+=1
            
            if(count == 3){
                acceptAllButton.setImage(UIImage(named: "check.fill.svg"), for: .normal)
                tapBtn = true
                nextButton.backgroundColor = UIColor.customColor(.blue)
                tapNextBtn = true
            }
            
        } else{
            acceptButton3.setImage(UIImage(named: "check.svg"), for: .normal)
            tapBtn3 = false
            count-=1
            
            if(count == 2){
                acceptAllButton.setImage(UIImage(named: "check.all.svg"), for: .normal)
                tapBtn = false
                nextButton.backgroundColor = UIColor.customColor(.gray)
                tapNextBtn = false
            }
        }
        
    }
    
    @objc func selectBtnEvent() {
        if(tapBtn == false){
            acceptAllButton.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            acceptButton1.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            acceptButton2.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            acceptButton3.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            acceptButton3.setImage(UIImage(named: "check.fill.svg"), for: .normal)
            count = 3
            tapBtn = true
            tapBtn1 = true
            tapBtn2 = true
            tapBtn3 = true
            nextButton.backgroundColor = UIColor.customColor(.blue)
            tapNextBtn = true
            

        } else{
            acceptAllButton.setImage(UIImage(named: "check.all.svg"), for: .normal)
            acceptButton1.setImage(UIImage(named: "check.svg"), for: .normal)
            acceptButton2.setImage(UIImage(named: "check.svg"), for: .normal)
            acceptButton3.setImage(UIImage(named: "check.svg"), for: .normal)
            count = 0
            tapBtn = false
            tapBtn1 = false
            tapBtn2 = false
            tapBtn3 = false
            nextButton.backgroundColor = UIColor.customColor(.gray)
            tapNextBtn = false
        }
        
    }
    
    @objc func touchNextBtnEvent() {
        if(nextButton.backgroundColor == UIColor.customColor(.blue)){
            let nextVC = TrainerCheckViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
