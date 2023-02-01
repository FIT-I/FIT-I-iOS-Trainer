//
//  EditCategoryViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/31.
//

import UIKit
import SnapKit
import Moya

class EditCategoryViewController: UIViewController {
    
    private let provider = MoyaProvider<EditProfileServices>()
    private let TrainerProvider = MoyaProvider<TrainerServices>()
    private var selectedCategory = ""

    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "카테고리 선택"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
        return view
    }()
    
    var priceTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "5가지 중 한가지를 선택해주세요."
        label.textColor = UIColor.black
        return label
    }()
    
    private let nextBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.gray)
        btn.layer.cornerRadius = 8
        btn.setTitle("다음", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        
        return btn
    }()

    // 왼쪽 버튼 부분
    var priceStackView = EditCategoryView()
    
    // 오른쪽 금액 Label 부분
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))

        // Do any additional setup after loading the view.
        setViewHierarchy()
        setConstraints()
        setButtonEvent()
        self.dismissKeyboard()
    }
    
    private func setViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(priceTitleLabel)
        view.addSubview(nextBtn)
        view.addSubview(priceStackView)
    }
    
    private func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        priceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(30)
        }
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview()
        }
        nextBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func setButtonEvent(){
        priceStackView.freePickBtn.addTarget(self, action: #selector(freeCheckBtnEvent), for: .touchUpInside)
        priceStackView.firstPickBtn.addTarget(self, action: #selector(firstCheckBtnEvent), for: .touchUpInside)
        priceStackView.secondPickBtn.addTarget(self, action: #selector(secondCheckBtnEvent), for: .touchUpInside)
        priceStackView.thirdPickBtn.addTarget(self, action: #selector(thirdCheckBtnEvent), for: .touchUpInside)
        priceStackView.fourthPickBtn.addTarget(self, action: #selector(fourthCheckBtnEvent), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tapNextBtnEvent), for: .touchUpInside)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - 버튼 logic -> 버튼이 하나만 눌리도록!
    
    var checkPosition = -1
    lazy var btnArr: [UIButton] = [
                    priceStackView.freePickBtn,
                    priceStackView.firstPickBtn,
                    priceStackView.secondPickBtn,
                    priceStackView.thirdPickBtn,
                    priceStackView.fourthPickBtn,
                            ]
    
    @objc func freeCheckBtnEvent(){
        if(checkPosition == -1 || checkPosition == 0){
            priceStackView.freePickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        } else{
            btnArr[checkPosition].setImage(UIImage(named: "emptyBox.svg"), for: .normal)
            priceStackView.freePickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        }
        checkPosition = 0
        nextBtn.backgroundColor = UIColor.customColor(.blue)


    }
    
    @objc func firstCheckBtnEvent(){
        if(checkPosition == -1 || checkPosition == 1){
            priceStackView.firstPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        } else{
            btnArr[checkPosition].setImage(UIImage(named: "emptyBox.svg"), for: .normal)
            priceStackView.firstPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        }
        checkPosition = 1
        nextBtn.backgroundColor = UIColor.customColor(.blue)
    }
    
    @objc func secondCheckBtnEvent(){
        if(checkPosition == -1 || checkPosition == 2){
            priceStackView.secondPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        } else{
            btnArr[checkPosition].setImage(UIImage(named: "emptyBox.svg"), for: .normal)
            priceStackView.secondPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        }
        checkPosition = 2
        nextBtn.backgroundColor = UIColor.customColor(.blue)

    }
    
    @objc func thirdCheckBtnEvent(){
        if(checkPosition == -1 || checkPosition == 3){
            priceStackView.thirdPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        } else{
            btnArr[checkPosition].setImage(UIImage(named: "emptyBox.svg"), for: .normal)
            priceStackView.thirdPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        }
        checkPosition = 3
        nextBtn.backgroundColor = UIColor.customColor(.blue)

    }
    
    @objc func fourthCheckBtnEvent(){
        if(checkPosition == -1 || checkPosition == 4){
            priceStackView.fourthPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        } else{
            btnArr[checkPosition].setImage(UIImage(named: "emptyBox.svg"), for: .normal)
            priceStackView.fourthPickBtn.setImage(UIImage(named: "check.fill.svg"), for: .normal)
        }
        checkPosition = 4
        nextBtn.backgroundColor = UIColor.customColor(.blue)

    }
    
    @objc func tapNextBtnEvent(){
        if(nextBtn.backgroundColor == UIColor.customColor(.blue)){
            patchServer()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.getServer()
            }
//            getServer()
        }
    }
    
    func selectedCost() -> String {

        switch checkPosition {

        case 0:
            selectedCategory = "pt"

        case 1:
            selectedCategory = "diet"

        case 2:
            selectedCategory = "food"

        case 3:
            selectedCategory = "rehab"

        case 4:
            selectedCategory = "friend"

        default:
            selectedCategory = HomeViewController.userInfo.category
        }

        return selectedCategory
    }
    
}

//MARK: - patch Server

extension EditCategoryViewController{
    
    func patchServer(){
        let param = ChangeCategoryRequest.init(category: selectedCost())
        provider.request(.changeCategory(param: param)) { response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("success")
                    let responseData = try moyaResponse.map(ChangeCategoryResponse.self)
                    print(responseData)
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)

            }
        }
    }
    
    func getServer(){
        self.TrainerProvider.request(.loadTrainer){ response in
            switch response {
            case .success(let moyaResponse):
                do{
//                    print(moyaResponse.statusCode)
//                    print(moyaResponse.response)
                    let responseData = try moyaResponse.map(GetTrainerInfoResponse.self)
                    TrainerDetailViewController.userInfo.category = responseData.result.category ?? "pt"
                    HomeViewController.userInfo.category = responseData.result.category ?? "pt"
                    print(responseData)
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


