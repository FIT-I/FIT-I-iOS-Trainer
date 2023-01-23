//
//  EditPhotoViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/14.
//

import Foundation
import UIKit
import SnapKit
import BSImagePicker

class EditPhotoViewController: UIViewController {
    
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "사진 수정"
        label.textColor = UIColor.black
        return label
    }()
    
    var progressView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        view.snp.makeConstraints { make in
            make.height.equalTo(5)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(progressView)
    }
    
    private func setConstraints(){
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func addPhotoEvent(_ sender: Any){
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 10
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
//        self.presentImagePicker(imagePicker,
//                                select: <#T##((PHAsset) -> Void)?##((PHAsset) -> Void)?##(_ asset: PHAsset) -> Void#>,
//                                deselect: <#T##((PHAsset) -> Void)?##((PHAsset) -> Void)?##(_ asset: PHAsset) -> Void#>,
//                                cancel: <#T##(([PHAsset]) -> Void)?##(([PHAsset]) -> Void)?##([PHAsset]) -> Void#>,
//                                finish: <#T##(([PHAsset]) -> Void)?##(([PHAsset]) -> Void)?##([PHAsset]) -> Void#>)
    }
    
}

