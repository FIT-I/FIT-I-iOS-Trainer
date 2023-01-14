//
//  TrainerDetailViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import Foundation
import UIKit
import SnapKit
import Then

class TrainerDetailViewController: UIViewController {
        
    //MARK: - UI Components
    
    // 상단 뷰
    var topView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "blueScreen.svg")
        return imgView
    }()
    
    var editBackImageButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "edit.svg"), for: .normal)
        btn.addTarget(self, action: #selector(tappedEditBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var imagePicker: UIImagePickerController = {
            let picker = UIImagePickerController()
//            picker.delegate = self
//            picker.allowsEditing = true

            return picker
        }()
    
    var noticeImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "notice.svg")
        return img
    }()
    
    // 스크롤 뷰
    private lazy var contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
    }
    
    //MARK: -
    let headView = HeadView()
    
    // 관리 비용
    let bodyPriceView = BodyPriceView()
    
    // 소개 글 목차 뷰
    let bodyIntroView = BodyIntroView()
    
    // 서비스 줄거리
    let bodyIntroAboutService = BodyIntroAboutServiceView()
    
    // 리뷰
    let bodyReviewView = BodyReviewView()
    
    // 사진 뷰
    let bottomPhotoView = BottomPhotoView()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setButtonEvent()
        setViewLayer()
        setLayout()
        changeBackAlertEvent()
        changeProfileAlertEvent()
    }
    
    func setButtonEvent(){
        bodyReviewView.reviewDetailBtn.addTarget(self, action: #selector(moveToReviewTableView), for: .touchUpInside)
        bodyPriceView.editBodyPriceButton.addTarget(self, action: #selector(editBodyPriceBtnEvent), for: .touchUpInside)
        bodyIntroView.editBodyIntroButton.addTarget(self, action: #selector(editBodyIntroBtnEvent), for: .touchUpInside)
        bodyIntroAboutService.editAboutServiceButton.addTarget(self, action: #selector(editAboutServiceBtnEvent), for: .touchUpInside)
        headView.reviewerImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedProfile)))
    }
    
    func setViewLayer(){
        bodyPriceView.layer.cornerRadius = 8
        bodyIntroView.layer.cornerRadius = 8
        bodyIntroAboutService.layer.cornerRadius = 8
        bodyReviewView.layer.cornerRadius = 8
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editBodyPriceBtnEvent(){
        let nextVC = EditBodyPriceViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func editBodyIntroBtnEvent(){
        let nextVC = EditBodyIntroViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func editAboutServiceBtnEvent(){
        let nextVC = EditAboutServiceViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    
    
    @objc func moveToReviewTableView(){
        let nextVC = ReviewViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func editBackBtnTapped(_ sender: UITapGestureRecognizer) {
        print(" topView 수정 버튼 클릭됨")
        present(imagePicker, animated: true)

    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        print(" imageView 클릭됨")
        present(headView.imagePicker, animated: true)

    }
    
    let backAlertController = UIAlertController(title: "배경 이미지 변경", message: "사진 앨범에서 선택 또는 기본 이미지", preferredStyle: .actionSheet)
    let profileAlertController = UIAlertController(title: "프로필 이미지 변경", message: "사진 앨범에서 선택 또는 기본 이미지", preferredStyle: .actionSheet)
    
    func changeBackAlertEvent() {
            let photoLibraryAlertAction = UIAlertAction(title: "앨범에서 선택", style: .default) {
                (action) in
                self.openBackAlbum() // 아래에서 설명 예정.
            }
            let normalImgAlertAction = UIAlertAction(title: "기본 이미지로 변경", style: .default) {(action) in
                self.changeBackNormal() // 아래에서 설명 예정.
            }
            let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            self.backAlertController.addAction(photoLibraryAlertAction)
            self.backAlertController.addAction(normalImgAlertAction)
            self.backAlertController.addAction(cancelAlertAction)
            guard let alertControllerPopoverPresentationController
                    = backAlertController.popoverPresentationController
            else {return}
            prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
    func changeProfileAlertEvent() {
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
    
    func openBackAlbum() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    func openProfileAlbum() {
        // headView의 image에 대한 delegate는 headView의 image 선언부에 존재한다.
        headView.imagePicker.allowsEditing = true
        present(headView.imagePicker, animated: true, completion: nil)
    }
    
    
    func changeBackNormal() {
        topView.image = UIImage(named: "blueScreen.svg")
    }
    
    func changeProfileNormal() {
        headView.reviewerImage.image = UIImage(named: "reviewerIcon.svg")
    }
    
    
    @objc func tappedEditBtn(_ gesture: UITapGestureRecognizer) {
            self.present(backAlertController, animated: true, completion: nil)
    }
    
    @objc func tappedProfile(_ gesture: UITapGestureRecognizer) {
            self.present(profileAlertController, animated: true, completion: nil)
    }
    
}

//MARK: - Extension

extension TrainerDetailViewController {
    
    //MARK: - setLayout
    
    func setLayout() {
        
        //MARK: addSubViews
        view.addSubviews(contentScrollView)
        contentScrollView.addSubviews(
            topView,
            editBackImageButton,
            headView,
            noticeImage,
            bodyPriceView,
            bodyIntroView,
            bodyIntroAboutService,
            bodyReviewView,
            bottomPhotoView
        )
        
        //MARK: - naviViewLayout
        
        // testColors
        view.backgroundColor = .systemBackground
        bodyPriceView.backgroundColor = UIColor.customColor(.boxGray)
        bodyIntroView.backgroundColor = UIColor.customColor(.boxGray)
        bodyIntroAboutService.backgroundColor = UIColor.customColor(.boxGray)
        bodyReviewView.backgroundColor = UIColor.customColor(.boxGray)
        
        //MARK: - toolBarLayout
    
        
        //MARK: - scrollViewLayout
        contentScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        //MARK: - containerViewLayout
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(180)
            make.width.equalTo(390)
        }
        
        editBackImageButton.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(6)
            make.trailing.equalTo(topView).offset(-15)
        }
        
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview()
        }
        
        noticeImage.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(bodyPriceView.snp.top).offset(-20)
        }
        
        bodyPriceView.snp.makeConstraints {
            $0.top.equalTo(noticeImage.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(86)
        }
        
        bodyIntroView.snp.makeConstraints {
            $0.top.equalTo(bodyPriceView.snp.bottom).offset(25)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(160)
        }
        
        bodyIntroAboutService.snp.makeConstraints {
            $0.top.equalTo(bodyIntroView.snp.bottom).offset(25)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(250)
        }
        
        bodyReviewView.snp.makeConstraints {
            $0.top.equalTo(bodyIntroAboutService.snp.bottom).offset(25)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(350)
        }
        
        bottomPhotoView.snp.makeConstraints {
            $0.top.equalTo(bodyReviewView.snp.bottom).offset(25)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview()
        }
        
    }
}
extension TrainerDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
//            var newImage: UIImage? = nil // update 할 이미지
            
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
//            topView.contentMode = .scaleAspectFit
            topView.image = image
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
            
//        editPhotoButton.setImage(newImage, for: .normal)
        //self.photoImage.image = newImage // 받아온 이미지를 update
            picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
        }
}

extension TrainerDetailViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController =
      self.backAlertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect
            = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
    }
}

