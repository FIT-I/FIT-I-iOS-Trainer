//
//  TrainerDetailViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
// Debug > Attach to Process > FITI-Trainer-iOS.

import Foundation
import UIKit
import SnapKit
import Then
import Moya
import Photos
import Kingfisher

class TrainerDetailViewController: UIViewController {
    //MoyaTarget과 상호작용하는 MoyaProvider를 생성하기 위해 MoyaProvider인스턴스 생성
    private let profileInfoProvider = MoyaProvider<EditProfileServices>()
    private let TrainerProvider = MoyaProvider<TrainerServices>()
    static var userInfo = UserInfo()
    private var setCategory = ""
    private var setBackGround = UIImage(named: "blueScreen.svg")

    
    //MARK: - UI Components
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
        picker.sourceType = .photoLibrary
            return picker
        }()
    
    var noticeImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "notice.svg")
        
        return img
    }()
    
    private lazy var contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
    }
    
    //MARK: -
    let headView = HeadView()
    
    //카테고리 선택
    let categoryView = CategoryView()
    
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
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        
        setButtonEvent()
        setViewLayer()
        setLayout()
        setServerDate()
//        imageDecoding()
        getTrainerServer()
        changeBackAlertEvent()
        changeProfileAlertEvent()
        bottomPhotoView.editerChoiceCV.reloadData()
//        print("====================================================")
//        let backImg = UIImage(named: "blueScreen.svg")
//        let imageData:NSData = backImg!.pngData()! as NSData
//        let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
//        print(strBase64)
//        print("====================================================")

        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setServerDate()
        getTrainerServer()
        bottomPhotoView.editerChoiceCV.reloadData()
    }
    
    //MARK: - Func
    func setButtonEvent(){
        bodyReviewView.reviewDetailBtn.addTarget(self, action: #selector(moveToReviewTableView), for: .touchUpInside)
        bodyPriceView.editBodyPriceButton.addTarget(self, action: #selector(editBodyPriceBtnEvent), for: .touchUpInside)
        categoryView.editBodyPriceButton.addTarget(self, action: #selector(editCategoryBtnEvent), for: .touchUpInside)
        bodyIntroView.editBodyIntroButton.addTarget(self, action: #selector(editBodyIntroBtnEvent), for: .touchUpInside)
        bodyIntroAboutService.editAboutServiceButton.addTarget(self, action: #selector(editAboutServiceBtnEvent), for: .touchUpInside)
        bottomPhotoView.editPhotoButton.addTarget(self, action: #selector(editPhotoBtnEvent), for: .touchUpInside)
        headView.reviewerImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedProfile)))
    }
    
    func setViewLayer(){
        categoryView.layer.cornerRadius = 8
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
    
    @objc func editCategoryBtnEvent(){
        let nextVC = EditCategoryViewController()
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
    
    @objc func editPhotoBtnEvent(){
        let nextVC = EditPhotoViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    
    
    @objc func moveToReviewTableView(){
        let nextVC = ReviewViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    let backAlertController = UIAlertController(title: "배경 이미지 변경", message: "사진 앨범에서 선택 또는 기본 이미지", preferredStyle: .actionSheet)
    
    func changeBackAlertEvent() {
            let photoLibraryAlertAction = UIAlertAction(title: "앨범에서 선택", style: .default) {
                (action) in
                self.openBackAlbum() // 아래에서 설명 예정.
            }
            let normalImgAlertAction = UIAlertAction(title: "기본 이미지로 변경", style: .default) {(action) in
                self.changeBackNormal()
                self.patchBackgroundImage(image: UIImage(named: "blueScreen.svg")!)
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

    @objc func tappedProfileTest(tapGestureRecognizer: UITapGestureRecognizer) {
        print("akjfak;jfkasjflkasdklfjasdk;fjas;kldfaklsdfjklasdflkjasdf;jkasdfkjas;kdfjaskdfjjalskdf")

     }

    func changeProfileNormal() {
        headView.reviewerImage.image = UIImage(named: "reviewerIcon.svg")

    }

    let profileAlertController = UIAlertController(title: "프로필 이미지 변경", message: "사진 앨범에서 선택 또는 기본 이미지", preferredStyle: .actionSheet)

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
    
    func changeBackNormal() {
        topView.image = UIImage(named: "blueScreen.svg")
    }
    
    @objc func tappedEditBtn() {
            self.present(backAlertController, animated: true, completion: nil)
    }

    @objc func tappedProfile(_ sender: UITapGestureRecognizer) {
        print("klsjfakl;sfj;asdl")
             self.present(profileAlertController, animated: true, completion: nil)
     }
    
}

//MARK: - Extension

extension TrainerDetailViewController {
    
    func setLayout() {
        
        //MARK: addSubViews
        view.addSubviews(contentScrollView)
        contentScrollView.addSubviews(
            topView,
            editBackImageButton,
            categoryView,
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
        categoryView.backgroundColor = UIColor.customColor(.boxGray)
        bodyPriceView.backgroundColor = UIColor.customColor(.boxGray)
        bodyIntroView.backgroundColor = UIColor.customColor(.boxGray)
        bodyIntroAboutService.backgroundColor = UIColor.customColor(.boxGray)
        bodyReviewView.backgroundColor = UIColor.customColor(.boxGray)
        
    
        
        //MARK: - scrollViewLayout
        contentScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(180)
        }
        
        editBackImageButton.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(6)
            make.trailing.equalTo(topView).offset(-15)
        }
        
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview()
        }
        
        categoryView.snp.makeConstraints {
            $0.top.equalTo(noticeImage.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(86)
        }
        
        noticeImage.snp.makeConstraints { make in
            make.top.equalTo(headView.gradeStackView.snp.bottom).offset(25)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(categoryView.snp.top).offset(-20)
        }
    
        bodyPriceView.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(86)
        }
        
        bodyIntroView.snp.makeConstraints {
            $0.top.equalTo(bodyPriceView.snp.bottom).offset(25)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(bodyIntroView.introTextView).offset(5)

        }
        
        bodyIntroAboutService.snp.makeConstraints {
            $0.top.equalTo(bodyIntroView.snp.bottom).offset(25)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(bodyIntroAboutService.introServiceTextView).offset(5)
        }
        
        bodyReviewView.snp.makeConstraints {
            $0.top.equalTo(bodyIntroAboutService.snp.bottom).offset(25)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(350)
        }
        
        bottomPhotoView.snp.makeConstraints {
            $0.top.equalTo(bodyReviewView.snp.bottom).offset(5)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview()
        }
    }
    
    func selectedCost() -> String {

        switch TrainerDetailViewController.userInfo.category {

        case "pt":
            setCategory = "개인 PT"

        case "diet":
            setCategory = "다이어트"

        case "food":
            setCategory = "식단관리"

        case "rehab":
            setCategory = "재활치료"

        case "friend":
            setCategory = "운동친구"

        default:
            setCategory = HomeViewController.userInfo.category
        }

        return setCategory
    }
}

//MARK: - UIImagePicker Delegate
extension TrainerDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

//            var newImage: UIImage? = nil // update 할 이미지

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
//            topView.contentMode = .scaleAspectFit
            topView.image = image
            patchBackgroundImage(image: image)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
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

//MARK: - ServerData
extension TrainerDetailViewController{
    func setServerDate(){
//        EditPhotoViewController.imageArray.removeAll()
        self.headView.name.text = TrainerDetailViewController.userInfo.userName
        self.headView.levelIcon.image =  UIImage(named: "\(TrainerDetailViewController.userInfo.level).svg")
        self.headView.grade.text = "\(TrainerDetailViewController.userInfo.grade)"
        self.headView.school.text = TrainerDetailViewController.userInfo.school
        self.categoryView.choosedCategoryLabel.text = selectedCost()
        self.bodyPriceView.priceForTimeLabel.text = "\(TrainerDetailViewController.userInfo.cost)"
        self.bodyIntroView.introTextView.text = TrainerDetailViewController.userInfo.intro
        self.bodyIntroAboutService.introServiceTextView.text = TrainerDetailViewController.userInfo.service
        
        if(TrainerDetailViewController.userInfo.profile == "trainerProfile"){
            self.headView.reviewerImage.image = UIImage(named: "reviewerIcon.svg")
        } else{
            let profileURL = URL(string: TrainerDetailViewController.userInfo.profile)
            self.headView.reviewerImage.kf.setImage(with: profileURL)
        }
        
        if(TrainerDetailViewController.userInfo.backGround == ""){
            self.topView.image = UIImage(named: "blueScreen.svg")!
        } else{
            let backgroundURL = URL(string: TrainerDetailViewController.userInfo.backGround)
            self.topView.kf.setImage(with: backgroundURL)
        }
//        for index in 0..<TrainerDetailViewController.userInfo.imageList.count{
//            let serverImage = UIImageView()
//            let imageURL = URL(string: TrainerDetailViewController.userInfo.imageList[index])
//            serverImage.kf.setImage(with: imageURL)
//            EditPhotoViewController.imageArray.append(serverImage.image ?? UIImage())
//        }
        
        
    }
    
    func getTrainerServer(){
        self.TrainerProvider.request(.loadTrainer){ response in
            switch response {
            case .success(let moyaResponse):
                do{
//                    print(moyaResponse.statusCode)
//                    print(moyaResponse.response)
                    let responseData = try moyaResponse.map(GetTrainerInfoResponse.self)
                    TrainerDetailViewController.userInfo.cost = responseData.result.cost
                    EditBodyIntroViewController.userInfo.intro = responseData.result.intro ?? "작성된 소개글이 없습니다."
                    EditAboutServiceViewController.userInfo.service = responseData.result.service ?? "작성된 상세설명이 없습니다."
                    
//                    print(responseData)

                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    func patchBackgroundImage(image: UIImage){
        profileInfoProvider.request(.uploadBackground(param: image)) { response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("TrainerDetailVC - patchBackgroundImage ==============================================================")
                    let image = try JSONDecoder().decode(ChangeProfileResponse.self, from: moyaResponse.data)
                        print(image)
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
                
            }
        }
    }
}
