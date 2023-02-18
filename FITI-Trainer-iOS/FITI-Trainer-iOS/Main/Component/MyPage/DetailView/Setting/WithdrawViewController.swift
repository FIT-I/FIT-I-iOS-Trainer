//
//  WithdrawViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//
import UIKit
import SnapKit
import Moya

class WithdrawViewController: UIViewController {
    
    // MARK: - Properties
    
    let realm = RealmService()
    private let myPageProvider = MoyaProvider<MyPageServices>()
    
    // MARK: - UI Components
    
    private lazy var appImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "finialLogOut.svg")
        return imgView
    }()
    
    private lazy var goBackBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.skyblue1)
        btn.layer.cornerRadius = 8
        btn.setTitle("계정 유지", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
        return btn
    }()
    
    private lazy var finialWithDrawBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.boxGray)
        btn.layer.cornerRadius = 8
        btn.setTitle("계정 탈퇴", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.addTarget(self, action: #selector(withDraw), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalTo(finialWithDrawBtn.snp.top).offset(-15)
        }
        finialWithDrawBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    // MARK: - @objc Func
    
    @objc func backBtn(){
        let nextVC = TabBarController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func withDraw(){
        self.withDrawServer()
    }
}

extension WithdrawViewController {
    func withDrawServer(){
        myPageProvider.request(.withDraw){ [self] response in
            switch response{
            case .success(let moyaResponse):
                do{
                    let responseData = try moyaResponse.map(WithDrawResponse.self)
                    try! realm.localRealm?.write {
                        realm.localRealm?.deleteAll()
                    }
                    if responseData.isSuccess == true {
                        let alert = UIAlertController(title: "회원탈퇴", message: "정상적으로 탈퇴되었습니다.", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "확인", style: .default, handler: { okAction in
                            let signInView = SignInViewController()
                            self.navigationController?.pushViewController(signInView, animated: true)
                        })
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        let alert = UIAlertController(title: "회원탈퇴", message: "탈퇴에 실패하였습니다. 다시 시도해주세요.", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "확인", style: .default, handler: { okAction in
                        })
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
  
            
        }
    }
}

