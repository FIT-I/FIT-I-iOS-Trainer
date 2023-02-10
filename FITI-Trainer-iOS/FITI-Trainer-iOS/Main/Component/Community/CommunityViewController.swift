//
//  CommunityViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import UIKit
import SnapKit
import Moya

class CommunityViewController: UIViewController {
    
    static var matchingList = [MatchingResult]()
    let matchingProvider = MoyaProvider<MatchingService>()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "받은 요청 확인"
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
    
    private var noRequestImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "noRequest.svg")
        imgView.isHidden = true
        return imgView
    }()
    
    // 받은 요청을 보여주는 테이블 뷰
    let requestTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        requestTableView.register(CommunityTableCell.self, forCellReuseIdentifier: CommunityTableCell.identifier)
        requestTableView.delegate = self
        requestTableView.dataSource = self
        
        setViewHierarchy()
        setConstraints()
        
        if(CommunityViewController.matchingList.count == 0){
            noRequestImage.isHidden = false
            titleLabel.isHidden = true
            progressView.isHidden = true
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestTableView.reloadData()
    }
    
    func setViewHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(requestTableView)
        view.addSubview(noRequestImage)
    }
    
    func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        requestTableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        noRequestImage.snp.makeConstraints { make in
            make.height.equalTo(233)
            make.width.equalTo(173)
            make.centerX.centerY.equalToSuperview()
        }
    }
}

//MARK: -  extension: tableView

extension CommunityViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let touchedCell = tableView.cellForRow(at: indexPath) as! CommunityTableCell
        print(touchedCell.id)
        self.getSpecificUserServer(matchingIdx: touchedCell.id)
        let nextVC = RequestResultViewController()
        RequestResultViewController.id = touchedCell.id
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
       
    }
}


extension CommunityViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommunityViewController.matchingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableCell.identifier, for: indexPath) as? CommunityTableCell ?? CommunityTableCell()
        
        cell.bindingMatchingList(model: CommunityViewController.matchingList[indexPath.row])
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - set Server

extension CommunityViewController{
    func getSpecificUserServer(matchingIdx:Int){
        self.matchingProvider.request(.specificUser(matchingIdx)){ response in
            switch response {
            case .success(let moyaResponse):
                do {
                    print("its me")
                    print(moyaResponse.statusCode)
                    let responseData = try moyaResponse.map(SpecificUserResponse.self)
                    RequestResultViewController.specificUser.pricePerHour = responseData.result.pricePerHour ?? ""
                    RequestResultViewController.specificUser.totalPrice = responseData.result.totalPrice ?? ""
                    RequestResultViewController.specificUser.matchingStart = responseData.result.matchingStart ?? ""
                    RequestResultViewController.specificUser.matchingFinish = responseData.result.matchingFinish ?? ""
                    RequestResultViewController.specificUser.location = responseData.result.location ?? ""
                    RequestResultViewController.specificUser.matchingPeriod = responseData.result.matchingPeriod
                    RequestResultViewController.specificUser.name = responseData.result.name ?? "사용자 이름이 없습니다."
                    if(responseData.result.pickUpType == "TRAINER_GO"){
                        RequestResultViewController.specificUser.pickUpType = "트레이너님이 와주세요."
                    } else {
                        RequestResultViewController.specificUser.pickUpType = "고객이 직접 갈게요."
                    }
                    print(responseData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)

            }
            
        }
    }
}
                                              
