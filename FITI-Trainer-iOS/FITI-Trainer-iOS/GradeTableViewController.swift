//
//  GradeTableViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/10.
//
import Foundation
import UIKit
import SnapKit
import Moya

class GradeTableViewController: UIViewController {
    
    let provider = MoyaProvider<MyPageServices>()
    let TrainerProvider = MoyaProvider<TrainerServices>()
    let matchingProvider = MoyaProvider<MatchingService>()
    
    private let gradeImage : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named:"gradeTable.svg")
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true

        pagingTimer()
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyPageServer()
        getTrainerServer()
        getMatchingServer()
    }

    private func setViewHierarchy() {
        view.addSubview(gradeImage)
    }
    
    private func setConstraints(){
        
        gradeImage.snp.makeConstraints { make in
            make.height.equalTo(597)
            make.width.equalTo(349)
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func pagingTimer() {
            let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (Timer) in
                self.pagingMove()
            }
        }
    
    func pagingMove() {
        let nextVC = TabBarController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func getMyPageServer(){
        self.provider.request(.myPage){ response in
            switch response {
            case .success(let moyaResponse):
                do{
//                    print(moyaResponse.statusCode)
//                    print(moyaResponse.response)
                    let responseData = try moyaResponse.map(MyPageResponse.self)
                    MyPageViewController.MyInfo.userName = responseData.result.userName
                    MyPageViewController.MyInfo.profile = responseData.result.profile
                    MyPageViewController.MyInfo.email = responseData.result.email
                    MyPageViewController.MyInfo.location = responseData.result.location ?? ""
                    HomeViewController.userInfo.email = responseData.result.email
                    print(responseData)

                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getTrainerServer(){
        self.TrainerProvider.request(.loadTrainer){ response in
            switch response {
            case .success(let moyaResponse):
                do{
//                    print(moyaResponse.statusCode)
//                    print(moyaResponse.response)
                    let responseData = try moyaResponse.map(GetTrainerInfoResponse.self)
                    HomeViewController.userInfo.userName = responseData.result.name
                    HomeViewController.userInfo.intro = responseData.result.intro ?? "작성된 소개글이 없습니다."
                    HomeViewController.userInfo.grade = responseData.result.grade
                    HomeViewController.userInfo.school = responseData.result.school
                    HomeViewController.userInfo.level = responseData.result.levelName
                    HomeViewController.userInfo.category = responseData.result.category ?? "pt"
                    HomeViewController.userInfo.matching_state = responseData.result.matching_state
                    MyPageViewController.didProfileShown = responseData.result.matching_state
                    
                    print(responseData)

                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getMatchingServer(){
        self.matchingProvider.request(.loadMatchingList){response in
            switch response {
            case .success(let moyaResponse):
                do{
                    let responseData = try moyaResponse.map(MatchingListResponse.self)
                    CommunityViewController.matchingList = responseData.result
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)

            }
        }
    }
    

}
