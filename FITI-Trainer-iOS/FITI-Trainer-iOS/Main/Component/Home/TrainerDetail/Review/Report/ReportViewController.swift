//
//  ReportViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/14.
//

import UIKit
import SnapKit
import Then
import Moya

class ReportViewController: UIViewController {
    
    private let trainerProvider = MoyaProvider<TrainerServices>()
    static var reviewerIdx : Int = 0

    //MARK: - UI Components
    
    private lazy var reportLabel: UILabel = {
        let label = UILabel()
        label.text = "신고하기"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Noto Sans", size: 20.0)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    private lazy var rectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.boxGray)
        return view
    }()
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "신고하기 사유 확인이 불가능한 경우 해당 신고는 무효됩니다."
        label.textAlignment = .center
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Noto Sans", size: 20.0)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    private lazy var requestButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.customColor(.blue)
        btn.layer.cornerRadius = 10
        btn.setTitle("신고하기", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.customColor(.blue).cgColor
        btn.addTarget(self, action: #selector(reportBtnEvent), for: .touchUpInside)
        return btn
    }()
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.gray)
        view.layer.cornerRadius = 8
        return view
    }()
    private lazy var reportingimgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "report.svg")
        return imgView
    }()
    private lazy var middleLabel: UILabel = {
        let label = UILabel()
        label.text = "신고하기 사유 확인이 불가능한 경우 해당 신고는 미조치됩니다."
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 진행중 문제가 생겼다면 증빙자료(사진, 녹취록, 대화 내역)와 함께 이메일 fitiofficial@naver.com로 접수해주세요. 신고 결과는 별도의 안내를 드리지 않습니다."
        label.textColor = UIColor.customColor(.darkGray)
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 3
        return label
    }()
    private lazy var contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
    }
    var reportStackView = ReportView()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        self.topLabel.numberOfLines = 0
        setNavigationController()
        setViewHierarchy()
        setConstraints()

    }

    private func setViewHierarchy() {
        view.addSubviews(reportLabel, rectView, contentScrollView, requestButton)
        contentScrollView.addSubviews(topLabel, grayView, reportingimgView, middleLabel, reportStackView, bottomLabel)
    }

    private func setConstraints() {
        reportStackView.layer.cornerRadius = 8
        reportLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
        }
        rectView.snp.makeConstraints {
            $0.top.equalTo(reportLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(5)
        }
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(rectView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(rectView.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(49)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-48)
            make.height.equalTo(54)
        }
        grayView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(70)
        }
        reportingimgView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
        }
        middleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(40)
            make.leading.equalTo(reportingimgView.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-29)
        }
        reportStackView.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(19)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(186)
        }
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(reportStackView.snp.bottom).offset(15)
            make.height.equalTo(70)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        requestButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
    }

    // MARK: - @objc Func

    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @objc func reportBtnEvent(){
        if self.reportStackView.reportReason == "" {
            showToast(message: "신고 사유를 선택해주세요.")
        }else {
//            let reportData = ReportRequest(customerId: TrainerDetailViewController.userInfo.reviewDto[ReportViewController.reviewerIdx].customerIdx, reason: self.reportStackView.reportReason)
//            self.reportAlert(reportData: reportData)
            self.reportAlert()

        }
    }
    
    // MARK: - Func

    func setNavigationController(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    func setBackgroundColor(){
        view.backgroundColor = .systemBackground
        reportStackView.backgroundColor = UIColor.customColor(.boxGray)
    }
    
    //MARK: -  func reportAlert(reportData:ReportRequest){
    func reportAlert(){
        let alert = UIAlertController(title: "신고하기", message: "정말 신고하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "계정신고", style: .default, handler: { okAction in
//            self.postReportServer(body: reportData)
//            print(reportData)
        })
        let noAction = UIAlertAction(title: "취소", style: .destructive, handler: { okAction in
        })
        alert.addAction(noAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-170, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func showExceptionNotification(description:String){
        let alertController = UIAlertController(
            title: description,
            message: "이미 신고한 트레이너입니다.",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Network

extension ReportViewController {
    func postReportServer(body:ReportRequest){
        self.trainerProvider.request(.report(param: body)){ response in
            switch response {
            case .success(let moyaResponse):
                do{
                    let reportResponse = try moyaResponse.map(ReportResponse.self)
                    if reportResponse.isSuccess == false {
                        self.showExceptionNotification(description: reportResponse.message ?? "")
                    }else {
                        self.showToast(message: "신고에 성공하였습니다.")
                    }
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
}
