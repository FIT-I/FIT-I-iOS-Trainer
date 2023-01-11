//
//  HomeViewController.swift
//  FITI
//
//  Created by 홍준혁 on 2023/01/01.
//

import UIKit
import SnapKit

// 개인 PT
class HomeViewController: UIViewController {

    // line 뷰
    let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        return view
    }()
    
    // 트레이너 보여주는 테이블 뷰
    let trainerTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.\
        signInViewAddUI()
        signInViewSetUI()
    }
    
    func signInViewAddUI(){
//        view.addSubview(lineView)
        view.addSubview(trainerTableView)
    }
    
    func signInViewSetUI(){
//        lineView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.leading.trailing.equalToSuperview()
//        }
        trainerTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    @objc func tapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        }

    }


