//
//  BookCVC.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import Foundation
import UIKit
import SnapKit
import Then

class BookCVC: UICollectionViewCell {
    
    private let editerChoiceImageView = UIImageView()
    
    
    
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
    
    func dataBind(image : UIImage) {
        editerChoiceImageView.image = image
    }
    
    private func setLayout() {
        contentView.addSubview(editerChoiceImageView)
        
        editerChoiceImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
    }
    
}


