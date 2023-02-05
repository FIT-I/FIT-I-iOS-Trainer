//
//  MatchingResultViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/05.
//

import UIKit
import SnapKit
import Moya

class MatchingResultViewController: UIViewController {
    
    static var specificUser = MatchingUser()
    static var id = 0
    private let matchingProvider = MoyaProvider<MatchingService>()
    let matchingResultSheet = MatchingResultSheet()
    
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
        view.addSubview(progressView)
        view.addSubview(matchingResultSheet)
        matchingResultSheet.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
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
        matchingResultSheet.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(370)
        }
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - set Server
    
    func setSeverData(){
        self.titleLabel.text = RequestResultViewController.specificUser.name
        matchingResultSheet.hourPriceLabel.text = "\(RequestResultViewController.specificUser.pricePerHour)"+"원"
        matchingResultSheet.totalPriceLabel.text = "\(RequestResultViewController.specificUser.totalPrice)"+"원"
        matchingResultSheet.meetingDate.text = "\(RequestResultViewController.specificUser.matchingStart)"+"~"+"\(RequestResultViewController.specificUser.matchingFinish) "+"총 \(RequestResultViewController.specificUser.matchingPeriod ?? 0)일"
        matchingResultSheet.pickUp.text = RequestResultViewController.specificUser.pickUpType
        
        if(RequestResultViewController.specificUser.pickUpType == "트레이너님이 와주세요."){
            matchingResultSheet.lineView4.isHidden = false
            matchingResultSheet.pickUpLocation.isHidden = false
            matchingResultSheet.userPickUpLocation.isHidden = false
            matchingResultSheet.userPickUpLocation.text = RequestResultViewController.specificUser.location
        } else {
            matchingResultSheet.lineView4.isHidden = true
            matchingResultSheet.pickUpLocation.isHidden = true
            matchingResultSheet.userPickUpLocation.isHidden = true
        }
    }
}


