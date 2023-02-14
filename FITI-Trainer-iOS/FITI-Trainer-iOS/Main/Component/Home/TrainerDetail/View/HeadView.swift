//
//  HeadView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import SnapKit
import UIKit

class HeadView : UIView {
    
    // 상단 뷰
    var reviewerImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "reviewerIcon.svg")
        imgView.layer.cornerRadius = 23
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
//        imgView.contentMode = .scaleAspectFill
//        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var name : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.textColor = UIColor.black
        return label
    }()
    
    var levelIcon : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var starIcon : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star.svg")
        return image
    }()
    
    var grade : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var license : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "자격증 5개"
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    var school : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = UIColor.customColor(.darkGray)
        return label
    }()
    
    lazy var nameStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,levelIcon])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .trailing
        return stackView
    }()
    
    lazy var rateStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starIcon,grade])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var gradeStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rateStackView,license,school])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
            let picker = UIImagePickerController()
            picker.delegate = self
            return picker
        }()
    
//    lazy var globalStackView : UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [nameStackView,gradeStackView])
//        stackView.axis = .vertical
//        stackView.spacing = 6
//        stackView.alignment = .leading
//
//        return stackView
//    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)
        self.backgroundColor = .red
//        ifImageViewTouched()
        setViewHierarchy()
        setConstraints()
    }
    
//    func ifImageViewTouched(){
//           //클릭 가능하도록 설정
//        self.reviewerImage.isUserInteractionEnabled = true
//           //제쳐스 추가
//       }
    
    func setViewHierarchy(){
        self.addSubview(reviewerImage)
        self.addSubview(name)
        self.addSubview(levelIcon)
        self.addSubview(gradeStackView)
    }
    
    func setConstraints(){
        reviewerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.height.width.equalTo(70)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(reviewerImage.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(30)
        }
        
        levelIcon.snp.makeConstraints { make in
            make.bottom.equalTo(name)
            make.leading.equalTo(name.snp.trailing).offset(10)
        }
        
        gradeStackView.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(2)
            make.leading.equalTo(name)
        }
    }
}

extension HeadView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            reviewerImage.image = image
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
            picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
        }
}
