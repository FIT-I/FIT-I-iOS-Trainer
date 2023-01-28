//
//  HomeViewController.swift
//  FITI
//
//  Created by 홍준혁 on 2023/01/01.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {

    var didProfileShown : Bool = true
    private let myPageView = MyPageViewController()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Connects college students with consumers."
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Inter", size: 15.0)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private lazy var rectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        return view
    }()
    
    private lazy var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let trainerTitleImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "trainerTitle.svg")
        return img
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.blue)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김동현"
        label.textColor = UIColor.customColor(.blue)
        //label.font = UIFont(name: "Noto Sans", size: 24.0)
        label.font = UIFont(name: "Avenir-Black", size: 25.0)
        //label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "bricksky.soongsil@ac.kr"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var ptIcon: UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(named: "personalPt.svg")  // 임시
        return image
    }()
    
    private lazy var slashLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Noto Sans", size: 14.0)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private lazy var goldIcon: UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(named: "Gold.svg")
        return image
    }()
    
    private lazy var yellowstarIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star.svg")
        return image
    }()
    
    private lazy var gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "4.3"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var dotLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "."
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var licenseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "보유 자격증 5개"
        label.textColor = UIColor.black
        return label
    }()
    
    
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "숭실대학교 재학"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.customColor(.blue)
        textView.backgroundColor = UIColor.customColor(.boxGray)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 12.0)
        textView.textContainer.maximumNumberOfLines = 3
        textView.textContainer.lineBreakMode = .byTruncatingTail

        // 더미 데이터
        textView.text = "Pt 센터 경력 3년. 스포애니 상도점에서 대표 트레이너로 근무한 경험이 있습니다. 가르치는 것은 자신있습니다. 가르치는 것은 자신있습니다. 가르치는 것은 자신있습니다. 가르치는 것은 자신있습니다. "
        return textView
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.blue)
        return view
    }()
    
    private lazy var profileButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .none
        btn.setImage(UIImage(named: "editProfile.svg"), for: .normal)
        btn.addTarget(self, action: #selector(touchNextBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
//        stackView.backgroundColor = .brown

        return stackView
    }()
    
    private lazy var ptStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ptIcon,slashLabel,goldIcon])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .trailing
        
        return stackView
    }()
    
    private lazy var starStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yellowstarIcon, gradeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 3.43
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var gradeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starStackView,licenseLabel,schoolLabel])
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ptStackView, gradeStackView])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading

        return stackView
    }()
    
    
    private lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView, textStackView, introTextView])
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var unShownImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profileHidden.svg")
        img.isHidden = true
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        trainerEditViewAddUI()
        trainerEditViewSetUI()
        self.setDelegate()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
//        print(didProfileShown)

    }
    

    func trainerEditViewAddUI() {
        view.addSubview(titleLabel)
        view.addSubview(rectView)
        view.addSubview(boxView)
        view.addSubview(trainerTitleImage)
        view.addSubview(lineView)

        view.addSubview(allStackView)
        view.addSubview(underlineView)
        view.addSubview(profileButton)
        view.addSubview(unShownImage)
    }
    
    func trainerEditViewSetUI(){
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        rectView.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(5)
        }
        
        boxView.snp.makeConstraints{ make in
            make.top.equalTo(rectView.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-128)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            
        }

        trainerTitleImage.snp.makeConstraints { make in
            make.top.equalTo(boxView).offset(15)
            make.centerX.equalTo(boxView)
        }

        lineView.snp.makeConstraints{ make in
            make.top.equalTo(trainerTitleImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(1)
        }
     
        allStackView.snp.makeConstraints{ make in
            make.top.equalTo(lineView.snp.bottom).offset(40)
            make.leading.equalTo(boxView).offset(30)
            make.trailing.equalTo(boxView).offset(-30)
        }

        underlineView.snp.makeConstraints{ make in
            make.bottom.equalTo(boxView).offset(-70)
            make.leading.equalTo(boxView).offset(20)
            make.trailing.equalTo(boxView).offset(-20)
            make.height.equalTo(1)
        }

        profileButton.snp.makeConstraints{ make in
            make.top.equalTo(underlineView.snp.bottom).offset(10)
            make.trailing.equalTo(boxView).offset(-15)
        }
        
        unShownImage.snp.makeConstraints { make in
            make.centerY.equalTo(boxView).offset(20)
            make.centerX.equalTo(boxView)
        }

    }
    
    @objc func touchNextBtnEvent() {
            let nextVC = TrainerDetailViewController()
            navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setDelegate(){
        self.myPageView.delegate = self
    }

}

protocol isProfileShown: AnyObject {
    func isShown(isProfileShown: Bool)
}

extension HomeViewController: isProfileShown{
    func isShown(isProfileShown: Bool) {
//        if(isProfileShown){
//            allStackView.isHidden = false
//            unShownImage.isHidden = true
//        } else{
//            allStackView.isHidden = true
//            unShownImage.isHidden = false
//
//        }
        print(isProfileShown)
    }
}
