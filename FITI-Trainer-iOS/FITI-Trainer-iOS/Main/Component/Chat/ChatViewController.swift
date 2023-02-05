//
//  ChatViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import Foundation
import UIKit
import SnapKit
import Moya

class ChatViewController: UIViewController {
    
    static var matchingSuccessList = [MatchingSuccessResult]()
    let matchingProvider = MoyaProvider<MatchingService>()
    var matchingId = 0
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "수락한 요청 내역"
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
    
    // 받은 요청을 보여주는 테이블 뷰
    let finishMatchingTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        finishMatchingTableView.register(ChatTableCell.self, forCellReuseIdentifier: ChatTableCell.identifier)
        finishMatchingTableView.delegate = self
        finishMatchingTableView.dataSource = self
        
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        finishMatchingTableView.reloadData()
    }
    
    func setViewHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(finishMatchingTableView)
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
        
        finishMatchingTableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - FIXME:  extension: tableView (community view에서 딸려서 온 내용 제거하기)

extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let touchedCell = tableView.cellForRow(at: indexPath) as! ChatTableCell
        
        matchingId = touchedCell.id
        let nextVC = MatchingResultViewController()
        MatchingResultViewController.id = touchedCell.id
        getSpecificUserServer(matchingIdx: matchingId)
//        print(MatchingResultViewController.id)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatViewController.matchingSuccessList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableCell.identifier, for: indexPath) as? ChatTableCell ?? ChatTableCell()

        cell.bindingMatchingSuccess(model: ChatViewController.matchingSuccessList[indexPath.row])
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - set Server

extension ChatViewController {
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
