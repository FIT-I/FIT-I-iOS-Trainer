//
//  EditPhotoViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/14.
//

import Foundation
import UIKit
import SnapKit
import PhotosUI
import Moya

class EditPhotoViewController: UIViewController {
    //선택한 이미지를 저장할 배열
    var itemProviders: [NSItemProvider] = []
    static var imageArray : [UIImage] = []
    let imageProvider = MoyaProvider<EditProfileServices>()
    
//    var bottomPhotoView = BottomPhotoView()

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
    
    var addImageImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "addImage.svg")
        img.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width/3 - (15 + 7.5))
            make.height.equalTo(UIScreen.main.bounds.width/3 - (15 + 7.5))
        }
        return img
    }()
    
    private var editerPhotoChoiceCV: UICollectionView = {
        let itemSize : CGFloat = UIScreen.main.bounds.width/3 - (15 + 7.5)
        let itemSpacing : CGFloat = 15
        
        //flowLayout의 인스턴스
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        //collectionView의 인스턴스
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        cv.backgroundColor = .clear
        cv.clipsToBounds = true
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        editerPhotoChoiceCV.backgroundColor = .clear
        editerPhotoChoiceCV.register(EditPhotoTableCell.self, forCellWithReuseIdentifier: EditPhotoTableCell.identifier)
        editerPhotoChoiceCV.delegate = self
        editerPhotoChoiceCV.dataSource = self
        editerPhotoChoiceCV.showsHorizontalScrollIndicator = false
    
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(editerPhotoChoiceCV)
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
        
        editerPhotoChoiceCV.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func selectImagePicker(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 20 - (EditPhotoViewController.imageArray.count)
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func postImageServer() {
       let param = AddBottomImageRequest.init(ectImage: )
    }
}

//MARK: - collectionView Extension
extension EditPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EditPhotoViewController.imageArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastIndex = self.editerPhotoChoiceCV.lastIndexpath().row
        
        if(lastIndex == indexPath.row){
            selectImagePicker()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let lastIndex = self.editerPhotoChoiceCV.lastIndexpath().row
        let cell = editerPhotoChoiceCV.dequeueReusableCell(withReuseIdentifier: EditPhotoTableCell.identifier, for: indexPath) as! EditPhotoTableCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        if(indexPath.row == lastIndex){
            cell.editerChoiceImageView.image = UIImage(named: "addImage.svg")
            return cell
        }else{
//            cell.editerChoiceImageView.image = UIImage(named: images[indexPath.row])
            cell.editerChoiceImageView.image = EditPhotoViewController.imageArray[indexPath.row]

            return cell
        }
        
    }
    
}

//MARK: - PHPicker Extension
extension EditPhotoViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        //PHPicker 닫기
        picker.dismiss(animated: true)
        
        itemProviders = results.map(\.itemProvider)
        for item in itemProviders {
             if item.canLoadObject(ofClass: UIImage.self) {
                 item.loadObject(ofClass: UIImage.self) { image, error in
                     DispatchQueue.main.async {
                         guard let image = image as? UIImage else { return }
                         EditPhotoViewController.imageArray.append(image)
                         print(EditPhotoViewController.imageArray)
                         self.editerPhotoChoiceCV.reloadData()
                     }
                 }
             }
         }
    }
}
