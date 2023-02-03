//
//  RequestResultViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//

import UIKit
import SnapKit

class RequestResultViewController: UIViewController {
    
    static var specificUser = MatchingUser()
    let requestSheet = RequestSheet()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "매칭요청 확인"
        label.textColor = UIColor.customColor(.blue)
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

    private let acceptBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.blue)
        btn.layer.cornerRadius = 8
        btn.setTitle("수락하기", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customColor(.blue).cgColor
        btn.addTarget(self, action: #selector(acceptEvent), for: .touchUpInside)
        return btn
    }()
    private let rejectBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.gray)
        btn.layer.cornerRadius = 8
        btn.setTitle("거절하기", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customColor(.gray).cgColor
        btn.addTarget(self, action: #selector(rejectEvent), for: .touchUpInside)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        // Do any additional setup after loading the view.
        setSeverData()
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setSeverData()
        setViewHierarchy()
        setConstraints()
    }
    
    func setViewHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(acceptBtn)
        view.addSubview(rejectBtn)
        view.addSubview(progressView)
        view.addSubview(requestSheet)
        requestSheet.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
//        requestSheet.layer.cornerRadius = 8

    }
    
    func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        rejectBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-30)
        }
        acceptBtn.snp.makeConstraints { make in
            make.bottom.equalTo(rejectBtn.snp.top).offset(-10)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            
        }
        requestSheet.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(370)
        }
        
    }
    
    @objc func acceptEvent(){
        let alert = UIAlertController(title: "매칭 요청", message: "매칭을 수락하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

        let accecptAction = UIAlertAction(title: "수락", style: .default, handler: { okAction in
//            let nextVC = CommunityViewController()
//            self.navigationController?.pushViewController(nextVC, animated: true)
            self.navigationController?.popViewController(animated: true)
        })
        
        let noAction = UIAlertAction(title: "취소", style: .destructive, handler: { okAction in
        })
        
        alert.addAction(noAction)
        alert.addAction(accecptAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func rejectEvent(){
        let alert = UIAlertController(title: "매칭 요청", message: "매칭을 거절하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

        let rejectAction = UIAlertAction(title: "거절", style: .default, handler: { okAction in
//            let nextVC = CommunityViewController()
//            self.navigationController?.pushViewController(nextVC, animated: true)
            self.navigationController?.popViewController(animated: true)

        })
        
        let noAction = UIAlertAction(title: "취소", style: .destructive, handler: { okAction in
        })
        
        alert.addAction(noAction)
        alert.addAction(rejectAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func setSeverData(){
        requestSheet.hourPriceLabel.text = "\(RequestResultViewController.specificUser.pricePerHour)"+"원"
        requestSheet.totalPriceLabel.text = "\(RequestResultViewController.specificUser.totalPrice)"+"원"
        requestSheet.meetingDate.text = "\(RequestResultViewController.specificUser.matchingStart)"+"~"+"\(RequestResultViewController.specificUser.matchingFinish) "+"총 \(RequestResultViewController.specificUser.matchingPeriod ?? 0)일"
        requestSheet.pickUp.text = RequestResultViewController.specificUser.pickUpType
        
        if(RequestResultViewController.specificUser.pickUpType == "트레이너님이 와주세요."){
            requestSheet.lineView4.isHidden = false
            requestSheet.pickUpLocation.isHidden = false
            requestSheet.userPickUpLocation.isHidden = false
            requestSheet.userPickUpLocation.text = RequestResultViewController.specificUser.location
        } else {
            requestSheet.lineView4.isHidden = true
            requestSheet.pickUpLocation.isHidden = true
            requestSheet.userPickUpLocation.isHidden = true
        }

    }

}


