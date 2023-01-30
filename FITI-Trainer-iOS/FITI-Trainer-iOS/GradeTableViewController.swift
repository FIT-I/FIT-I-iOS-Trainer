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
    
    private let gradeImage : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named:"gradeTable.svg")
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        pagingTimer()
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyPageServer()
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
                    print(moyaResponse.statusCode)
                    print(moyaResponse.response)
                    let responseData = try moyaResponse.map(MyPageResponse.self)
                    MyPageViewController.MyInfo.userName = responseData.result.userName
                    MyPageViewController.MyInfo.profile = responseData.result.profile
                    MyPageViewController.MyInfo.email = responseData.result.email
                    MyPageViewController.MyInfo.location = responseData.result.location ?? ""
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
