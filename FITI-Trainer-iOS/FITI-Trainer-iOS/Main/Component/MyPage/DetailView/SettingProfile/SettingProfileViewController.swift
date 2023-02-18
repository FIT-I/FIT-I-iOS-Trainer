//
//  SettingProfileViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit
import Moya

class SettingProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let profileInfoProvider = MoyaProvider<EditProfileServices>()
    private let myPageProvider = MoyaProvider<MyPageServices>()

    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "프로필 수정"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    // 상단 뷰
    var topStackView = TopStackView()
    
    // 회색 라인 뷰
    var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        return view
    }()
    
    // 하단 뷰
    var bottomInfoView = BottomInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        self.dismissKeyboard()
        setServerData()
        setViewHierarchy()
        setConstraints()
        setBtnEvent()
        changeProfileAlertEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setServerData()
    }
    
    func setViewHierarchy(){
        
        view.addSubview(myPageTitleLabel)
        view.addSubview(topStackView)
        view.addSubview(progressView)
        view.addSubview(bottomInfoView)
    }
    
    func setConstraints(){
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        bottomInfoView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            
        }
    }
    
    func setBtnEvent(){

        topStackView.settingUserProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedProfile)))
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        LoadingView.showLoading()
        self.patchProfileImage(image: topStackView.settingUserProfile.image!)
    }
    
    @objc func tappedProfile(_ gesture: UITapGestureRecognizer) {
            self.present(profileAlertController, animated: true, completion: nil)
    }
    
    func changeProfileNormal() {
        topStackView.settingUserProfile.image = UIImage(named: "reviewerIcon.svg")
//        deleteProfileImage()
        
    }
    
    let profileAlertController = UIAlertController(title: "프로필 이미지 변경", message: "사진 앨범에서 선택 또는 기본 이미지", preferredStyle: .actionSheet)
    
    @objc func changeProfileAlertEvent() {
            let photoLibraryAlertAction = UIAlertAction(title: "앨범에서 선택", style: .default) {
                (action) in
                self.openProfileAlbum() // 아래에서 설명 예정.
            }
            let normalImgAlertAction = UIAlertAction(title: "기본 이미지로 변경", style: .default) {(action) in
                self.changeProfileNormal() // 아래에서 설명 예정.
            }
            let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            self.profileAlertController.addAction(photoLibraryAlertAction)
            self.profileAlertController.addAction(normalImgAlertAction)
            self.profileAlertController.addAction(cancelAlertAction)
            guard let alertControllerPopoverPresentationController
                    = profileAlertController.popoverPresentationController
            else {return}
            prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
    func openProfileAlbum() {
        // headView의 image에 대한 delegate는 headView의 image 선언부에 존재한다.
        topStackView.imagePicker.allowsEditing = true
        present(topStackView.imagePicker, animated: true, completion: nil)
    }
}
extension SettingProfileViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController =
      self.profileAlertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect
            = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }

    }
}

extension SettingProfileViewController{
    func patchProfileImage(image: UIImage){
        let parameters = image
        profileInfoProvider.request(.uploadProfile(param: parameters)) { response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("TrainerDetailVC - patchProfileImage ==============================================================")
//                    let responseData = try moyaResponse.map(ChangeProfileResponse.self)
                    let image = try JSONDecoder().decode(ChangeProfileResponse.self, from: moyaResponse.data)
                    print(image)
//                    LoadingView.hideLoading()
                    self.getMyPageServer()
                    
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)

            }
            
        }
    }
    
    private func setServerData(){
        topStackView.userName.text = MyPageViewController.MyInfo.userName
        bottomInfoView.userEmail.text = MyPageViewController.MyInfo.email
        bottomInfoView.userLocation.text = MyPageViewController.MyInfo.location
        if(MyPageViewController.MyInfo.profile == "trainerProfile"){
            self.topStackView.settingUserProfile.image = UIImage(named: "reviewerIcon.svg")
        } else{
            let profileURL = URL(string: MyPageViewController.MyInfo.profile)
            self.topStackView.settingUserProfile.kf.setImage(with: profileURL)
        }
        bottomInfoView.openChatLink.text = RequestResultViewController.specificUser.openChat
    }
    
    func getMyPageServer(){
        self.myPageProvider.request(.myPage){ response in
            switch response {
            case .success(let moyaResponse):
                do{
//                    print(moyaResponse.statusCode)
//                    print(moyaResponse.response)
                    let responseData = try moyaResponse.map(MyPageResponse.self)
                    MyPageViewController.MyInfo.profile = responseData.result.profile
                    print(responseData)
                    LoadingView.hideLoading()
                    self.navigationController?.popViewController(animated: true)

                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

