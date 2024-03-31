//
//  AppCoordinator.swift
//  MovieTask
//
//  Created by Al-attar on 28/03/2024.
//

import Foundation
import UIKit

protocol Coordinator{
    var Main: MainNavigator {get}
    var navgationController: UINavigationController? {get}
    func start()
}

class AppCoordinator: Coordinator{
    
    var window: UIWindow
    
    lazy private var tabbar: TabBarController = {
        return TabBarController(coordinator: self)
    }()
    
    lazy var Main: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    var navgationController: UINavigationController?{
        if let navgationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
            return navgationController
        }else  if let navgationController = tabbar.selectedViewController as? UINavigationController{
            return navgationController
        }else{
            print("Error to navgation in app coordinator")
            return nil
        }
        
    }
    
    init(window: UIWindow = UIWindow()){
        self.window = window
    }
    
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    
    var rootViewController: UIViewController{
        return tabbar
    }
}


