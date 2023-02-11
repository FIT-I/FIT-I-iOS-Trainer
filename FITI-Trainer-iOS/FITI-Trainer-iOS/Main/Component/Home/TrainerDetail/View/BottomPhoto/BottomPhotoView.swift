//
//  BottomPhotoView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit
import SnapKit

class BottomPhotoView: UIView {
    
    let editPhotoView = EditPhotoViewController()
    let space : CGFloat = 10
//    var takenImage : [UIImage] = []
    
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
    
    var editPhotoButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "edit.svg"), for: .normal)
        return btn
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
    
    var editerChoiceCV: UICollectionView = {
        
        //flowLayout의 인스턴스
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5.0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 125, height: 125)
        
        //collectionView의 인스턴스
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        cv.contentInset = .zero
        cv.backgroundColor = .clear
        cv.clipsToBounds = true
        cv.backgroundColor = .green
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViewHierarchy()
        setLayout()
        editerChoiceCV.backgroundColor = .clear
        editerChoiceCV.register(BottomCVC.self, forCellWithReuseIdentifier: BottomCVC.identifier)
        editerChoiceCV.delegate = self
        editerChoiceCV.dataSource = self
        editerChoiceCV.showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewHierarchy(){
        self.addSubview(photoTopStackView)
        self.addSubview(photoLineView)
        self.addSubview(editPhotoButton)
        self.addSubview(editerChoiceCV)
    }
    
    private func setLayout(){
       
        photoTopStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(photoTopStackView)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        photoLineView.snp.makeConstraints { make in
            make.top.equalTo(photoTopStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        editerChoiceCV.snp.makeConstraints { make in
            make.top.equalTo(photoLineView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
}


//MARK: - collectionView Extension

extension BottomPhotoView: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return editPhotoView.imageArray.count
        return EditPhotoViewController.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = editerChoiceCV.dequeueReusableCell(withReuseIdentifier: BottomCVC.identifier, for: indexPath) as! BottomCVC
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.editerChoiceImageView.image = EditPhotoViewController.imageArray[indexPath.row]
        return cell
    }

    //좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
}

