//
//  PrivacyNoticeViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/16.
//
import UIKit
import SnapKit

class PrivacyNoticeViewController: UIViewController {

    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 25.0)
        label.text = "공지사항"
        label.textColor = UIColor.black
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setViewHierarchy()
        setConstraints()
    }
    
    func setViewHierarchy(){
        view.addSubview(myPageTitleLabel)
        view.addSubview(progressView)

    }
    
    func setConstraints(){
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(myPageTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }


}



