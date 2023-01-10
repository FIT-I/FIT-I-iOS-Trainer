//
//  TabBarController.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/11.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    let homeVC = HomeViewController()
    let communityVC = CommunityViewController()
    let chatVC = ChatViewController()
    let myPageVC = MyPageViewController()
    
    // 탭바 터치 바운스 이벤트
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.1, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    // 탭바 터치 바운스 이벤트
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.first as? UIImageView else {
            return
        }
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setUpTabBar()
    }
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    func setUpTabBar(){
        self.tabBar.tintColor = UIColor.customColor(.blue)
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .systemBackground
        
        homeVC.title = "홈"
        communityVC.title = "커뮤니티"
        chatVC.title = "채팅"
        myPageVC.title = "마이페이지"
        
        let ViewControllers:[UIViewController] = [homeVC,communityVC,chatVC,myPageVC]
        // assign view controllers to tab bar
        self.setViewControllers(ViewControllers, animated: true)
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        communityVC.tabBarItem.image = UIImage(systemName: "globe.asia.australia")
        chatVC.tabBarItem.image = UIImage(systemName: "ellipsis.bubble")
        myPageVC.tabBarItem.image = UIImage(systemName: "person")
        
        //네비게이션 뷰컨으로 푸쉬했을 때 밑에 바가 사라지지 않도록
        self.hidesBottomBarWhenPushed = false
        viewWillLayoutSubviews()
    }
    
}
