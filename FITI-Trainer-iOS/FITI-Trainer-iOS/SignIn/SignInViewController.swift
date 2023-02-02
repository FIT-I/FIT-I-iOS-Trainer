//
//  SignInViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import Foundation
import UIKit
import SnapKit
import Moya

class SignInViewController: UIViewController {
    
    private let provider = MoyaProvider<SignServices>()
    let realm = RealmService()

    //MARK: - UI Component
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Trainer-Login"
        label.textColor = UIColor.customColor(.blue)
        label.font = UIFont(name: "Noto Sans", size: 24)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    lazy var idTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
                    string: "아이디",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(handleIdTfDidChange), for: .editingChanged)
        
        return tf
    }()

    lazy var passwordTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
                    string: "비밀번호",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(.gray)]
                )
        tf.layer.borderColor = UIColor.customColor(.gray).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = UIColor.customColor(.blue)
        tf.isSecureTextEntry = true
        tf.setLeftPaddingPoints(10)
        tf.addTarget(self, action: #selector(handlePwTfDidChange), for: .editingChanged)

        return tf
    }()

    lazy var findPasswordButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .none
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(findPwBtnEvent), for: .touchUpInside)

        return btn
    }()

    lazy var signUpButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .none
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(signUpBtnEvent), for: .touchUpInside)
        return btn
    }()

    private let horizontalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var nextButton : UIButton = {
           let btn = UIButton()
            btn.backgroundColor = UIColor.customColor(.gray)
            btn.setTitle("로그인", for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Noto Sans", size: 0)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.layer.cornerRadius = 10
            btn.addTarget(self, action: #selector(touchNextBtnEvent), for: .touchUpInside)
            return btn
        }()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        self.navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.topItem?.title = ""
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.hidesBackButton = true

        signInViewAddUI()
        signInViewSetUI()
        
//        self.realm.resetDB()
                
        if checkRealmToken() {
            print(self.realm.getToken())
            ifSuccessPushHome()
        }

        self.dismissKeyboard()
    }

    //MARK: - Func

    func signInViewAddUI(){

        
        horizontalStackView.addArrangedSubview(findPasswordButton)
        horizontalStackView.addArrangedSubview(signUpButton)

        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(horizontalStackView)
        view.addSubview(nextButton)
        
    }


    func signInViewSetUI(){

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(10)
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }

    }
    
//    @objc func backTapped(sender: UIBarButtonItem) {
//        navigationController?.popViewController(animated: true)
//    }
    
    func checkRealmToken()->Bool{
        if realm.getToken() == ""{
            return false
        }else{
            return true
        }
    }
    
    @objc func signUpBtnEvent(){
        
        let nextVC = PolicyViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func findPwBtnEvent(){
        
        let nextVC = FindPwViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    var id = false
    var pw = false
    
    @objc func handleIdTfDidChange(){
        
        idTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        id = true
        
        
        if(id && pw){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    @objc func handlePwTfDidChange(){
        passwordTextField.layer.borderColor = UIColor.customColor(.blue).cgColor
        pw = true
        
        if(id && pw){
            nextButton.backgroundColor = UIColor.customColor(.blue)
        }
    }
    
    func postServer(){
        // server
        let param = SignInRequest.init(self.idTextField.text ?? "" ,self.passwordTextField.text ?? "")
        print(param)
        self.provider.request(.signIn(param: param)){ response in
            switch response {
                case .success(let moyaResponse):
                    do {
                        print(moyaResponse.statusCode)
                        let responseData = try moyaResponse.map(SignInResponse.self)
                        self.addTokenInRealm(item: responseData.result.accessToken)
                        self.ifSuccessPushHome()
                    } catch(let err) {
                        print(err.localizedDescription)
                        self.showFailAlert()
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                self.showFailAlert()
            }
        }
    }
        
    func addTokenInRealm(item:String){
        // add token in realm
        realm.addToken(item: item)
        print(realm.getToken())
    }
    
    @objc func touchNextBtnEvent() {
        switch checkRealmToken() {
        case false :
            // 서버 통신
            if((idTextField.text != "") && (passwordTextField.text != "")){
                self.postServer()
            }
        default:
            ifSuccessPushHome()
        }
    }
    
    private func ifSuccessPushHome(){
        let nextVC = GradeTableViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func showFailAlert(){
        let alert = UIAlertController(title: "로그인 실패", message: "이메일 또는 비밀번호를 확인해주세요.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in
            self.idTextField.text = ""
            self.passwordTextField.text = ""
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
