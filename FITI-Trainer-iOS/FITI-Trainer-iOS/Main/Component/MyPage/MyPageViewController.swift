//
//  MyPageViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import UIKit
import SnapKit
import Moya
import Realm

class MyPageViewController: UIViewController {
    
    static var MyInfo = UserInfo()
    private let myPageProvider = MoyaProvider<MyPageServices>()
    private let TrainerProvider = MoyaProvider<TrainerServices>()
    static var didProfileShown = true
    
    //MARK: - set UI
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
            make.height.equalTo(5)
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true
        
        setServerData()
        getMyPageServer()
        setViewLayer()
        setViewHierarchy()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setServerData()
        getMyPageServer()
        if(MyPageViewController.didProfileShown){
            self.notiView.showProfileBtn.setImage(UIImage(named: "ON.svg"), for: .normal)
        } else {
            self.notiView.showProfileBtn.setImage(UIImage(named: "OFF.svg"), for: .normal)
        }
    }
    
    //MARK: - set Function
    
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
        bottomBtn.userOpenChatBtn.addTarget(self, action: #selector(openChatBtnEvent), for: .touchUpInside)
        midProfileStackView.fixProfileBtn.addTarget(self, action: #selector(settingProfileBtnEvent), for: .touchUpInside)
        notiView.showProfileBtn.addTarget(self, action: #selector(patchSwitchServer), for: .touchUpInside)
    }
    
    @objc func settingProfileBtnEvent(){
        let nextVC = SettingProfileViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func updateBtnEvent(){
        let nextVC = UpdateViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func openChatBtnEvent(){
        let nextVC = setOpenChatViewController()
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
    
    //MARK: - set server
    
    func getMyPageServer(){
        self.myPageProvider.request(.myPage){ response in
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
                    
                    print(responseData)

                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    @objc func patchSwitchServer(){
        self.myPageProvider.request(.showProfile){ response in
            switch response {
            case .success(let moyaResponse):
                do{
                    let responseData = try moyaResponse.map(MyMatchingResponse.self)
                    if(MyPageViewController.didProfileShown){
                        self.notiView.showProfileBtn.setImage(UIImage(named: "OFF.svg"), for: .normal)
                        self.getTrainerServer()

                    }else {
                        self.notiView.showProfileBtn.setImage(UIImage(named: "ON.svg"), for: .normal)
                        self.getTrainerServer()

                    }
                    MyPageViewController.didProfileShown = !MyPageViewController.didProfileShown
                    print(responseData)
                } catch(let err){
                    print(err.localizedDescription)
                    self.showFailAlert()
                }
            case .failure(let err):
                print(err.localizedDescription)
                self.showFailAlert()
            }
        }
    }
    
    func setServerData(){
        midProfileStackView.name.text = MyPageViewController.MyInfo.userName
        midProfileStackView.userId.text = MyPageViewController.MyInfo.email
        if(MyPageViewController.MyInfo.profile == "trainerProfile"){
            self.midProfileStackView.reviewerImage.image = UIImage(named: "reviewerIcon.svg")
        } else{
            let profileURL = URL(string: MyPageViewController.MyInfo.profile)
            self.midProfileStackView.reviewerImage.kf.setImage(with: profileURL)
        }
    }
    
    func showFailAlert(){
        let alert = UIAlertController(title: " 실패", message: "이메일 또는 비밀번호를 확인해주세요.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in
            MyPageViewController.didProfileShown = !MyPageViewController.didProfileShown
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getTrainerServer(){
        TrainerProvider.request(.loadTrainer){ response in
            switch response {
            case .success(let moyaResponse):
                do{
                    let responseData = try moyaResponse.map(GetTrainerInfoResponse.self)
                    TrainerDetailViewController.userInfo.matching_state = responseData.result.matching_state
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



