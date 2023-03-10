//
//  UpdateViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import SnapKit

class UpdateViewController: UIViewController {
    
    var myPageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "자격증 업데이트"
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    var updateImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "update.svg")
        return img
    }()
    
    var updateCommentImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "updateComment.svg")
        return img
    }()
    
    private lazy var updateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateImage, updateCommentImage])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 49
        
        return stackView
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
        view.addSubview(updateStackView)
    }
    
    func setConstraints(){
        myPageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        updateStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}

