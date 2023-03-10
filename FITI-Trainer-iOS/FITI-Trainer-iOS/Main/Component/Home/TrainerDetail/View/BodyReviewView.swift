//
//  BodyReviewView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import UIKit
import SnapKit

class BodyReviewView : UIView {
    
    //MARK: - Properties
    static var previewReviewData = [ReviewDto]()
    
    //MARK: - UI Components
    private lazy var reviewView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.layer.borderColor = UIColor.customColor(.boxGray).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var reviewImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewIcon.svg")
        return imgView
    }()
    
    private lazy var reviewLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "후기 5건"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var emptyReviewLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "작성된 후기가 없습니다."
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    private lazy var reviewGradeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "평균 4.3"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    private lazy var bodyReviewLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    lazy var reviewDetailBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.systemBackground
        btn.setImage(UIImage(named: "rightBtn"), for: .normal)
        btn.backgroundColor = UIColor.customColor(.boxGray)
//        btn.addTarget(self, action: #selector(moveToReviewTableView), for: .touchUpInside)
        return btn
    }()
    
    // 리뷰 테이블 뷰
    private lazy var reviewTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.customColor(.boxGray)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var reviewTopLeftStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewImage,reviewLabel,reviewGradeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)

        setViewHierarchy()
        setConstraints()
        register()
        setServerData()
    }
    
    func setViewHierarchy(){
        self.addSubview(reviewTopLeftStackView)
        self.addSubview(reviewDetailBtn)
        self.addSubview(bodyReviewLineView)
        self.addSubview(reviewTableView)
    }
    
    func setConstraints(){
        
        reviewTopLeftStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        reviewDetailBtn.snp.makeConstraints { make in
            make.centerY.equalTo(reviewTopLeftStackView)
            make.trailing.equalToSuperview().offset(-20)
        }
        bodyReviewLineView.snp.makeConstraints { make in
            make.top.equalTo(reviewTopLeftStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-22)
        }
        reviewTableView.snp.makeConstraints { make in
            make.top.equalTo(bodyReviewLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-22)
            make.height.equalTo(270)
        }
    }
    
    func setEmptyLable(isEmpty:Int){
        if isEmpty != 0 {
            self.emptyReviewLabel.isHidden = true
        }else {
            self.emptyReviewLabel.isHidden = false
        }
    }

}

// MARK: - Extension

extension BodyReviewView {
    private func register() {
        reviewTableView.register(PreviewReviewTableCell.self,
                                 forCellReuseIdentifier: PreviewReviewTableCell.identifier
        )
    }
    
    private func setServerData(){
        reviewLabel.text = "후기 \(TrainerDetailViewController.userInfo.reviewDto?.count ?? 0)건"
        reviewGradeLabel.text = "평균 \(TrainerDetailViewController.userInfo.grade)"
    }
}
extension BodyReviewView : UITableViewDelegate {}
extension BodyReviewView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.setEmptyLable(isEmpty: TrainerDetailViewController.userInfo.reviewDto?.count ?? 0)
        let cellNum = TrainerDetailViewController.userInfo.reviewDto?.count ?? 0
        switch cellNum {
        case 0...3:
            return cellNum
        default:
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewCell = tableView.dequeueReusableCell(withIdentifier: PreviewReviewTableCell.identifier, for: indexPath) as? PreviewReviewTableCell ?? PreviewReviewTableCell()
        reviewCell.dataBind(model: BodyReviewView.previewReviewData[indexPath.row])
        reviewCell.selectionStyle = .none
        return reviewCell
    }
}
