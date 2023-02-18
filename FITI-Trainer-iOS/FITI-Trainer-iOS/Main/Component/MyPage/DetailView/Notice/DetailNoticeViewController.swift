//
//  NoticeLabelView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/17.
//

import UIKit

import SnapKit

class DetailNoticeViewController: UIViewController {
    
    lazy var introTextView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.textColor = UIColor.black
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.font = UIFont.systemFont(ofSize: 15.0)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setViewLayer()
        setNavigationController()
    }
    
    func setViewLayer() {
        view.addSubview(introTextView)
        introTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setNavigationController(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
