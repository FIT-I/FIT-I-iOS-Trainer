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
    
    private let announceFirstLabel : UILabel = {
        let label = UILabel()
        label.text = "*자격증 업데이트를 통해 언제든지 Level-UP 할 수 있습니다. "
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let announceSecLabel : UILabel = {
        let label = UILabel()
        label.text = "  My page내의 자격증 업데이트 칸을 이용해주세요."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.customColor(.blue)
        return label
    }()
    
    private let announceStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
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
        announceStackView.addArrangedSubview(announceFirstLabel)
        announceStackView.addArrangedSubview(announceSecLabel)

        view.addSubview(announceStackView)
    }
    
    private func setConstraints(){
        
        gradeImage.snp.makeConstraints { make in
            make.height.equalTo(395)
            make.width.equalTo(349)
            make.center.equalToSuperview()
        }
        
        announceStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-90)
            make.leading.equalToSuperview().offset(43)
            make.trailing.equalToSuperview().offset(-42)
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
