//
//  GradeTableViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/10.
//
import Foundation
import UIKit
import SnapKit

class GradeTableViewController: UIViewController {
    
    private let gradeImage : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named:"gradeTable.svg")
            return imageView
        }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        pagingTimer()
        // Do any additional setup after loading the view.
        setViewHierarchy()
        setConstraints()
    }

    private func setViewHierarchy() {
        view.addSubview(gradeImage)
    }
    
    private func setConstraints(){
        
        gradeImage.snp.makeConstraints { make in
            make.height.equalTo(597)
            make.width.equalTo(349)
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func pagingTimer() {
            let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (Timer) in
                self.pagingMove()
            }
        }
    
    func pagingMove() {
        let nextVC = TabBarController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}
