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

class BottomCVC: UICollectionViewCell {
    
    static let identifier = "CustomCollectionCell"
    
    
    let editerChoiceImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
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
    

    
    private func setLayout() {
        contentView.addSubview(editerChoiceImageView)
        self.backgroundColor = .systemGroupedBackground
        addSubview(editerChoiceImageView)

        editerChoiceImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}


