//
//  SearchViewController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/15.
//

import UIKit
import MapKit
import SnapKit
import Then
import Moya

class SearchViewController: UIViewController {
    // MARK: - Properties
    private var searchCompleter = MKLocalSearchCompleter() /// 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() /// 검색 결과를 담는 변수
    private let myPageProvider = MoyaProvider<MyPageServices>()
    
    let topView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 15.0)
        label.text = "도시, 우편번호 또는 공항 위치 입력"
        label.textColor = UIColor.customColor(.blue)
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    
    let searchBar = UISearchBar().then {
        $0.becomeFirstResponder()
        $0.keyboardAppearance = .dark
        $0.showsCancelButton = false
        $0.searchBarStyle = .minimal
        $0.searchTextField.leftView?.tintColor = .customColor(.blue)
        $0.searchTextField.textColor = .black
        $0.searchTextField.tintColor = .black
        $0.searchTextField.font = .systemFont(ofSize: 14)
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색",
                                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.customColor(.blue).withAlphaComponent(0.5)])
    }

    var cancelButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("취소", for: .normal)
        btn.setTitleColor(UIColor.customColor(.blue), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        btn.addTarget(self, action: #selector(touchupCancelButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    let lineView = UIView().then {
        $0.backgroundColor = .customColor(.boxGray)
    }
    
    let searchTV = UITableView().then {
        $0.backgroundColor = .systemBackground
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "leftIcon.svg"), style: .plain, target: self, action: #selector(backTapped))
        
        self.dismissKeyboard()
        
        configUI()
        setupBlurEffect()
        setupAutoLayout()
        setupSearchBar()
        setupSearchCompleter()
        setupTableView()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        topView.addSubview(visualEffectView)
    }
    
    func setupAutoLayout() {
        
        view.addSubview(topView)
        view.addSubview(searchTV)
        
        topView.addSubview(titleLabel)
        topView.addSubview(searchBar)
        topView.addSubview(cancelButton)
        topView.addSubview(lineView)
        
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalTo(cancelButton.snp.leading).offset(-2)
            make.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(20)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(3)
        }
        
        searchTV.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupTableView() {
        searchTV.delegate = self
        searchTV.dataSource = self
        searchTV.register(SearchTVC.self, forCellReuseIdentifier: "SearchTVC")
        searchTV.separatorStyle = .none
    }
    
    func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address /// resultTypes은 검색 유형인데 address는 주소를 의미
    }
    
    // MARK: - @objc
    @objc func touchupCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func petchLocationSetting(location:String){
        self.myPageProvider.request(.locationSetting(location)){ response in
            switch response {
            case .success(let response):
                do {
                    let responseData = try response.map(patchLocationResponse.self)
                    print(responseData.isSuccess)
                    print(responseData.message)
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getMyPageServer(){
        self.myPageProvider.request(.myPage){ response in
            switch response {
                case .success(let moyaResponse):
                    do {
                        let responseData = try moyaResponse.map(MyPageResponse.self)
                        MyPageViewController.MyInfo.userName = responseData.result.userName
                        MyPageViewController.MyInfo.profile = responseData.result.profile
                        MyPageViewController.MyInfo.email = responseData.result.email
                        MyPageViewController.MyInfo.location = responseData.result.location ?? ""
                        print(responseData)
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }

    
}



// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    /// 검색 결과 선택 시에 (취소/추가)버튼이 있는 VC이 보여야 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchReqeust = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchReqeust)
        search.start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            
            // 위치의 풀네임 출력
            print(placeMark.title ?? placeMark.title!)
            
            let alert = UIAlertController(title: "매칭 위치", message: "\(placeMark.title ?? placeMark.title!) 위치로 변경할건가요?", preferredStyle: UIAlertController.Style.alert)
            
            let noAction = UIAlertAction(title: "아니요", style: .destructive, handler: { okAction in
            })
            
            let okAction = UIAlertAction(title: "예", style: .default, handler: { okAction in
                let location = placeMark.title ?? placeMark.title!
                self.petchLocationSetting(location: location)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.getMyPageServer()
                }
                self.dismiss(animated: true)
            })
            
            alert.addAction(noAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVC", for: indexPath) as? SearchTVC
        else { return UITableViewCell() }
        cell.countryLabel.text = searchResults[indexPath.row].title
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    // 검색창의 text가 변하는 경우에 searchBar가 delegate에게 알리는데 사용하는 함수
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText를 queryFragment로 넘겨준다.
        searchCompleter.queryFragment = searchText
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchViewController: MKLocalSearchCompleterDelegate {
    // 자동완성 완료 시에 결과를 받는 함수
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // completer.results를 통해 검색한 결과를 searchResults에 담아줍니다
        searchResults = completer.results
        searchTV.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // 에러 확인
        print(error.localizedDescription)
    }
}

