//
//  ReviewViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit
import SnapKit

class ReviewViewController: UIViewController {
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.text = "리뷰 전체보기"
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 20.0)
        return lb
    }()
    
    // 리뷰를 보여주는 테이블 뷰
    let reviewTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        
        reviewTableView.register(ReviewTableCell.self, forCellReuseIdentifier: ReviewTableCell.identifier)
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        
        setViewHierarchy()
        setConstraints()
        
    }
    
    func setViewHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(reviewTableView)
    }
    
    func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        reviewTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }


}


extension ReviewViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell did touched")
    }
}


extension ReviewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableCell.identifier, for: indexPath)
//        cell.binding()
        cell.selectionStyle = .none
    
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
}
