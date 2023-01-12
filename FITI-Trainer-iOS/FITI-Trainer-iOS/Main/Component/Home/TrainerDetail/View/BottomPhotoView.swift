//
//  BottomPhotoView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit
import SnapKit

class BottomPhotoView: UIView {
    
    // 하단 뷰
    var photoImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "camera.svg")
        return imgView
    }()
    
    var photoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "사진 및 자격증"
        label.textColor = UIColor.black
        return label
    }()
    
    var photoLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.darkGray)
        return view
    }()
    
    lazy var photoTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoImage,photoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private var editerChoiceCV: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 217, height: 204)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    private var imageData = [
                    UIImage(named: "dummy1.svg"),
                    UIImage(named: "dummy1.svg"),
                    UIImage(named: "dummy1.svg")
    ]
    
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        editerChoiceCV.backgroundColor = .clear
        setLayout()
        editerChoiceCV.register(BookCVC.self, forCellWithReuseIdentifier: "1")
        editerChoiceCV.delegate = self
        editerChoiceCV.dataSource = self
        editerChoiceCV.showsHorizontalScrollIndicator = false
    }
    
    private func setLayout(){
        self.addSubview(photoTopStackView)
        self.addSubview(photoLineView)
        self.addSubview(editerChoiceCV)
        
        photoTopStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        photoLineView.snp.makeConstraints { make in
            make.top.equalTo(photoTopStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        editerChoiceCV.snp.makeConstraints { make in
            make.top.equalTo(photoLineView.snp.bottom).offset(6)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BottomPhotoView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = editerChoiceCV.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath) as! BookCVC
        cell.dataBind(image: imageData[indexPath.row]!)
        return cell
    }
    
    
}
