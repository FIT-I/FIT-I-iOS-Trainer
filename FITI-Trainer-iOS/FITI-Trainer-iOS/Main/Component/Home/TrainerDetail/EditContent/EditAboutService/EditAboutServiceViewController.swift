//
//  EditAboutServiceViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import UIKit
import SnapKit
import Moya

class EditAboutServiceViewController: UIViewController {
    
    private let provider = MoyaProvider<EditProfileServices>()
    static var userInfo = UserInfo()

    //MARK: - UI Components
    // 상단 제목
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 상세 설명"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Noto Sans", size: 20.0)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    // 상단 회색 바
    private lazy var rectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        return view
    }()
    
    private var introTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.customColor(.boxGray)
        textView.textColor = UIColor.customColor(.darkGray)
        textView.layer.cornerRadius = 16
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15.0)
        //textview.text = bodyIntro.introTextView.text
        textView.textContainerInset =  UIEdgeInsets(top: 0, left: 18, bottom: 10, right: 18)
        textView.text = "다양한 자격증을 바탕으로 친절하게 지도해드립니다. 스포애니 3년의 경력을 믿어주세요~!운동 지도를 비롯하여 저만의 체계적인 식단관리표를 활용하여 PT를 진행할 예정입니다. 단기간의 다이어트는 물론 장기적으로 신체 변화를 가져오는 것 또한 자신이 있습니다. 주 2회의 대면 지도를 권장하며 자세한 커리큘럼은 쪽지를 통해 상세히 설명해 드리겠습니다."
        
        return textView
    }()
    
    private lazy var requestButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.blue)
        btn.layer.cornerRadius = 10
        btn.setTitle("확인", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customColor(.blue).cgColor
         btn.addTarget(self, action: #selector(tapOKBtn), for: .touchUpInside)
        return btn
    }()
    
    // 스크롤 뷰
    private lazy var contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
    }
    
    
    let aboutService = AboutServiceView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setIntroLayout()
        setViewLayer()
        setServerData()
        self.dismissKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setServerData()
    }
    
    func setIntroLayout() {
        contentScrollView.addSubviews(introLabel, rectView, aboutService,introTextView, requestButton)
        view.addSubview(contentScrollView)
        
        view.backgroundColor = .systemBackground
        
        aboutService.backgroundColor = UIColor.customColor(.boxGray)
        introTextView.backgroundColor = UIColor.customColor(.boxGray)
        
    }
    func setViewLayer() {
        aboutService.layer.cornerRadius = 16
        requestButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        //MARK: - scrollViewLayout
        contentScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        //MARK: - containerViewLayout
        
        introLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        rectView.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(5)
        }
        
        aboutService.snp.makeConstraints {
            $0.top.equalTo(rectView.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.height.equalTo(160)
        }
        
        introTextView.snp.makeConstraints {
            $0.top.equalTo(aboutService.snp.bottom).offset(-95)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.bottom.equalTo(requestButton.snp.top).offset(-20)
        }
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOKBtn(sender: UIBarButtonItem) {
        postServer()
    }
    
}

extension EditAboutServiceViewController{
    
    func postServer(){
        let param = ChangeInfoRequest.init(TrainerDetailViewController.userInfo.userName, TrainerDetailViewController.userInfo.cost, TrainerDetailViewController.userInfo.intro, self.introTextView.text)
        provider.request(.changeInfo(param: param)) { response in
                switch response {
                case .success(let moyaResponse):
                    do {
                        print("success")
                        let responseData = try moyaResponse.map(GetTrainerInfoResponse.self)
                        
                        TrainerDetailViewController.userInfo.service = responseData.result.service ?? "작성된 소개글이 없습니다."
                        HomeViewController.userInfo.service = responseData.result.service ?? "작성된 소개글이 없습니다."
                       
                        self.navigationController?.popViewController(animated: true)
                        
                    } catch(let err) {

                        print(err.localizedDescription)
                    }
                case .failure(let err):

                    print(err.localizedDescription)
            }
        }
    }
    
    func setServerData(){
        self.introTextView.text = TrainerDetailViewController.userInfo.service
    }
}
