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
    
    let deleteImgButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "minus.svg"), for: .normal)
        btn.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        return btn
    }()
    
    let editerChoiceImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let cellView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var cellStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editerChoiceImageView,deleteImgButton])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = -20
        return stackView
    }()

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        editerChoiceImageView.contentMode = .scaleAspectFill
        setLayout()
        editerChoiceImageView.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.backgroundColor = .systemGroupedBackground
        addSubview(cellStackView)
    
        cellStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



