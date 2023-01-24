//
//  EditPhotoTableCell.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class EditPhotoTableCell: UICollectionViewCell {
    
    static let identifier = "EditPhotoCell"
    
    let editerChoiceImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
//        img.layer.cornerRadius = 5
//        img.layer.masksToBounds = true
        return img
    }()

    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.backgroundColor = .clear
        editerChoiceImageView.contentMode = .scaleToFill
        setLayout()
        editerChoiceImageView.layer.cornerRadius = 12
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func dataBind(image : UIImage) {
//        editerChoiceImageView.image = image
//    }
    
    private func setLayout() {
        contentView.addSubview(editerChoiceImageView)
        
        
        self.backgroundColor = .systemGroupedBackground
        
        addSubview(editerChoiceImageView)
                
        editerChoiceImageView.snp.makeConstraints { make in
//            make.top.bottom.leading.trailing.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
    }
    
}



