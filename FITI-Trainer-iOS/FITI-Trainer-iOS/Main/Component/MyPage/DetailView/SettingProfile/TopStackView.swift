//
//  TopStackView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import Foundation
import SnapKit
import UIKit

class TopStackView : UIView {
    
    var settingUserProfile : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewerIcon.svg")
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
//        imgView.contentMode = .scaleAspectFit
//        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var userName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "김동현"
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var globalStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingUserProfile,userName])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
            let picker = UIImagePickerController()
            picker.delegate = self

//            picker.allowsEditing = true

            return picker
        }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.addSubview(globalStackView)
    }
    
    private func setConstraints() {
        
        globalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        settingUserProfile.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
}

extension TopStackView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
//            var newImage: UIImage? = nil // update 할 이미지
            
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            settingUserProfile.image = image
//            self.settingUserProfile.contentMode = .scaleAspectFit
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
            
//        editPhotoButton.setImage(newImage, for: .normal)
        //self.photoImage.image = newImage // 받아온 이미지를 update
            picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
        }
}
