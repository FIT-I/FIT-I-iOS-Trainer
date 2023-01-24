//
//  CommunityViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import UIKit
import SnapKit

class CommunityViewController: UIViewController {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 20.0)
        label.text = "보낸 요청 확인"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
        return view
    }()
    
    // 받은 요청을 보여주는 테이블 뷰
    let requestTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        requestTableView.register(CommunityTableCell.self, forCellReuseIdentifier: CommunityTableCell.identifier)
        requestTableView.delegate = self
        requestTableView.dataSource = self
        
        setViewHierarchy()
        setConstraints()
    }
    
    func setViewHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(requestTableView)
    }
    
    func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        requestTableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension CommunityViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell did touched")
        let nextVC = RequestResultViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension CommunityViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableCell.identifier, for: indexPath)
//        cell.binding()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
