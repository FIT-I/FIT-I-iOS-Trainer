//
//  TrainerDetailViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import UIKit
import SnapKit

class TrainerDetailViewController: UIViewController {
    
    var isHeartFull : Bool = false

    // 상단 뷰
    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "김동현"
        label.textColor = UIColor.black
        return label
    }()
    
    var starIcon : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(systemName: "wand.and.stars")
        return image
    }()
    
    var runIcon : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(systemName: "figure.run")
        return image
    }()
    
    var foodIcon : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(systemName: "heart.text.square")
        return image
    }()
    
    var recycleIcon : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(systemName: "person.2.wave.2")
        return image
    }()
    
    var purpose : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "개인PT"
        label.textColor = UIColor.black
        return label
    }()
    
    var distance : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "1Km"
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    var grade : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "평점4.3"
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    var license : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "자격증 5개"
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    var school : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "숭실대"
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    lazy var iconStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starIcon,purpose])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,iconStackView])
        stackView.axis = .horizontal
        stackView.spacing = 13
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var gradeStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [grade,license,school])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var topStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView,gradeStackView])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading

        return stackView
    }()
    
    // 관리비용 뷰
    var priceView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.layer.borderColor = UIColor.customColor(.boxGray).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()

    // 관리비용 스택 뷰
    let priceStackView = PriceStackView()
    
    // 소개 뷰
    var introView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.layer.borderColor = UIColor.customColor(.boxGray).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    var introImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "introIcon.svg")
        return imgView
    }()
    
    var introLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "소개 글"
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var introTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introImage,introLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    var introTextView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.customColor(.boxGray)
        textView.textColor = UIColor.customColor(.darkGray)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.text = "다양한 자격증을 바탕으로 친절하게 지도해드립니다. 스포애니 3년의 경력을 믿어주세요~!"
        return textView
    }()
    
    lazy var introStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introTopStackView,introTextView])

        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    
    // 후기 뷰
    var reviewView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.layer.borderColor = UIColor.customColor(.boxGray).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    var reviewImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewIcon.svg")
        return imgView
    }()
    
    var reviewLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "후기 5건"
        label.textColor = UIColor.black
        return label
    }()
    
    var reviewGradeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "평균 4.3"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var reviewDetailBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        btn.addTarget(self, action: #selector(moveToReviewTableView), for: .touchUpInside)
        return btn
    }()
    
    lazy var reviewTopLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewImage,reviewLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    lazy var reviewTopRigthStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewGradeLabel,reviewDetailBtn])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var reviewTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewTopLeftStackView,reviewTopRigthStackView])
        stackView.axis = .horizontal
        stackView.spacing = 160
        stackView.alignment = .trailing
        return stackView
    }()
    
    var reviewLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.darkGray)
        return view
    }()
    
    // 최근 리뷰
    var reviewerName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "박윤빈"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var reviewDate : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "2023.1.1"
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    var reviewGrade : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "평점 4.5"
        label.textColor = UIColor.customColor(.gray)
        return label
    }()
    
    lazy var reviewMiddleTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerName,reviewDate,reviewGrade])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .trailing
        return stackView
    }()
    
    var reviewTextView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.customColor(.boxGray)
        textView.textColor = UIColor.customColor(.darkGray)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 10.0)
        textView.text = "다양한 자격증을 바탕으로 친절하게 지도해드립니다. 스포애니 3년의 경력을 믿어주세요~!"
        return textView
    }()
    
    lazy var reviewStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewTopStackView,reviewLineView,reviewMiddleTopStackView,reviewTextView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()

    // 관리비용, 소개, 후기 뷰들의 스택뷰
    lazy var middleStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceView,introView,reviewView])
        priceView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        introView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        reviewView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
//        stackView.backgroundColor = .green
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // 하단 탭바 뷰
    private let toolBarContainerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let matchingRequest : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.blue)
        btn.layer.cornerRadius = 8
        btn.setTitle("매칭 요청", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customColor(.blue).cgColor
        btn.addTarget(self, action: #selector(matchingRequestTouched), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        signInViewAddUI()
        signInViewSetUI()
        
    }
    
    func signInViewAddUI(){
        
//        toolBarContainerView.addSubview(matchingRequest)
        
        priceView.addSubview(priceStackView)
        introView.addSubview(introStackView)
        reviewView.addSubview(reviewStackView)
        
        view.addSubview(topStackView)
        view.addSubview(middleStackView)
        view.addSubview(toolBarContainerView)
    }
    
    func signInViewSetUI(){
        
        // 전체 틀
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        middleStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(65)
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-130)
        }
        
        // priceView 내부
        priceStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
        }
        
        // introView 내부
        introStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
//            make.leading.equalTo(topStackView)
//            make.trailing.equalTo(topStackView)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        // reviewView 내부
        reviewStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalTo(topStackView)
            make.trailing.equalTo(topStackView)
        }
        
        toolBarContainerView.snp.makeConstraints { make in
            make.top.equalTo(middleStackView.snp.bottom).offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
//        matchingRequest.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-40)
//            make.leading.equalTo(heartBtn.snp.trailing).offset(10)
//            make.trailing.equalToSuperview().offset(-14)
//        }

    }
    
    @objc func matchingRequestTouched(){
//        let nextVC = PickServiceViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func moveToReviewTableView(){
//        let nextVC = ReviewViewController()
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
//    @objc func heartTouchEvent(){
//        if isHeartFull == false {
//            self.isHeartFull = true
//            self.heartBtn.setImage(UIImage(named: "heart.fill.svg"), for: .normal)
//        }else{
//            self.isHeartFull = false
//            self.heartBtn.setImage(UIImage(named: "heart.svg"), for: .normal)
//        }
//    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

