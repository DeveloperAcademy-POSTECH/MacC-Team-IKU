//
//  SceneDelegate.swift
//  IKU
//
//  Created by Shin Jae Ung on 2022/11/10.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        //탭바컨트롤러의 생성
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        //첫번째 화면은 일단
        let storyViewController = UINavigationController(rootViewController: UIHostingController<StoryView>(rootView: StoryView()))
        storyViewController.navigationBar.tintColor = .black
        let historyViewController = UINavigationController(rootViewController: HistoryViewController())
        historyViewController.navigationBar.tintColor = .black
    
        
        //탭바로 사용하기 위한 뷰 컨트롤러들 설정
        tabBarController.setViewControllers([storyViewController,historyViewController], animated: false)
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.tabBar.backgroundColor = .ikuBackgroundBlue
        
        //탭바 이미지 설정
        guard let items = tabBarController.tabBar.items else { return }
        items[0].image = UIImage(named: "StrabismusTestIcon")
        items[0].title = "Strabismus Test"
        items[1].image = UIImage(systemName: "list.dash.header.rectangle")
        items[1].title =  "Test Record"

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
