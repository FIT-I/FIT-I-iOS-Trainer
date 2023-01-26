//
//  SceneDelegate.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/08.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(rootViewController: SignInViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }
}
