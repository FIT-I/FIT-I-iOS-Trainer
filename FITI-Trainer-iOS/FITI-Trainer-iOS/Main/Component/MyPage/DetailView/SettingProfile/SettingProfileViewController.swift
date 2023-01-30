//
//  SettingProfileViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class SettingProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
//            make.width.equalTo(100)
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
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func tappedProfile(_ gesture: UITapGestureRecognizer) {
            self.present(profileAlertController, animated: true, completion: nil)
    }
    
    func changeProfileNormal() {
        topStackView.settingUserProfile.image = UIImage(named: "reviewerIcon.svg")
        
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
    
    private func setServerData(){
        topStackView.userName.text = MyPageViewController.MyInfo.userName
        bottomInfoView.userEmail.text = MyPageViewController.MyInfo.email
        bottomInfoView.userLocation.text = MyPageViewController.MyInfo.location
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

