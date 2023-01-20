//
//  BottomPhotoView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//

import UIKit
import SnapKit

class BottomPhotoView: UIView {
    let images = ["dummy1.svg","dummy1.svg","dummy1.svg","dummy1.svg"]
//    let row : CGFloat = 1
    let space : CGFloat = 10
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
    
//    var photoScrollView : UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .green
//        scrollView.showsVerticalScrollIndicator = true
//        return scrollView
//    }()
    
    lazy var photoTopStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoImage,photoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private var editerChoiceCV: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 217, height: 204)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
//    private var imageData = [
//                    UIImage(named: "dummy1.svg"),
//                    UIImage(named: "dummy1.svg"),
//                    UIImage(named: "dummy1.svg")
//    ]
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        editerChoiceCV.backgroundColor = .clear
        setLayout()
        editerChoiceCV.register(BookCVC.self, forCellWithReuseIdentifier: BookCVC.identifier)
        editerChoiceCV.delegate = self
        editerChoiceCV.dataSource = self
        editerChoiceCV.showsHorizontalScrollIndicator = false
    }
    
    /// <#Description#>
    private func setLayout(){
//        photoScrollView.addSubviews(editerChoiceCV)
        self.addSubview(photoTopStackView)
        self.addSubview(photoLineView)
//        self.addSubview(editerChoiceCV)
        self.addSubview(editPhotoButton)
        self.addSubview(editerChoiceCV)
//        self.addSubview(photoScrollView)


        
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
//        editerChoiceCV.snp.makeConstraints { make in
//            make.top.equalTo(photoLineView.snp.bottom).offset(6)
//            make.leading.trailing.bottom.equalToSuperview()
//
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.leading.trailing.equalTo(safeAreaLayoutGuide)
//
//        }
        editerChoiceCV.snp.makeConstraints { make in
            make.top.equalTo(photoLineView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BottomPhotoView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = editerChoiceCV.dequeueReusableCell(withReuseIdentifier: BookCVC.identifier, for: indexPath) as! BookCVC
        cell.editerChoiceImageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    //셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - (space * (3 - 1))
//        let width = collectionView.frame.height / 3
        return CGSize(width: width, height: width)
    }

    //좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    
}
