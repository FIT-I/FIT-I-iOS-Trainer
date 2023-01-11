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
    
    var isHeartFull : Bool = false
    
    //MARK: - UI Components
    
    // 네비 뷰
    private let toolBarContainerView : UIView = {
        let view = UIView()
        return view
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
    
    private lazy var reviewTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // 사진 뷰
    let bottomPhotoView = BottomPhotoView()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setButtonEvent()
        setLayout()
        register()
    }
    
    func setButtonEvent(){
        bodyReviewView.reviewDetailBtn.addTarget(self, action: #selector(moveToReviewTableView), for: .touchUpInside)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    
    
    @objc func moveToReviewTableView(){
        let nextVC = ReviewViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

//MARK: - Extension

extension TrainerDetailViewController {
    
    //MARK: - register
    
    private func register() {
        reviewTableView.register(PreviewReviewTableCell.self,
                                 forCellReuseIdentifier: PreviewReviewTableCell.identifier
        )
    }
    
    //MARK: - setLayout
    
    func setLayout() {
        
        //MARK: addSubViews
        view.addSubviews(contentScrollView, toolBarContainerView)
        contentScrollView.addSubviews(
            headView,
            bodyPriceView,
            bodyIntroView,
            bodyIntroAboutService,
            bodyReviewView,
            reviewTableView,
            bottomPhotoView
        )
        
        //MARK: - naviViewLayout
        
        // testColors
//        headView.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        toolBarContainerView.backgroundColor = .systemBackground
        bodyPriceView.backgroundColor = UIColor.customColor(.boxGray)
        bodyIntroView.backgroundColor = UIColor.customColor(.boxGray)
        bodyIntroAboutService.backgroundColor = UIColor.customColor(.boxGray)
        
        //MARK: - toolBarLayout
        
        toolBarContainerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(64)
        }
        
        
        //MARK: - scrollViewLayout
        contentScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(toolBarContainerView.snp.top)
        }
        
        //MARK: - containerViewLayout
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
//            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
        }
        bodyPriceView.snp.makeConstraints {
//            $0.top.equalTo(headView.snp.bottom).offset(25)
            $0.top.equalTo(headView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(130)
        }
        
        bodyIntroView.snp.makeConstraints {
            $0.top.equalTo(bodyPriceView.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(130)
        }
        
        bodyIntroAboutService.snp.makeConstraints {
            $0.top.equalTo(bodyIntroView.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(220)
        }
        
        bodyReviewView.snp.makeConstraints {
            $0.top.equalTo(bodyIntroAboutService.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        reviewTableView.snp.makeConstraints {
            $0.top.equalTo(bodyReviewView.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(250)
        }
        
        bottomPhotoView.snp.makeConstraints {
            $0.top.equalTo(reviewTableView.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview()
        }

    }
}

//MARK: - ReviewTableView Delegate
extension TrainerDetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: PreviewReviewTableCell.identifier, for: indexPath) as? PreviewReviewTableCell else { return UITableViewCell() }
        
        reviewCell.dataBind(model: reviewDummy[indexPath.row])
//        reviewCell.selectionStyle = .none
        return reviewCell
    }
}


extension TrainerDetailViewController : UITableViewDelegate {
    
}
