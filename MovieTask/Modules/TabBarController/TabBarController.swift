//
//  TabBarController.swift
//  MovieTask
//
//  Created by Al-attar on 28/03/2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    let coordinator: Coordinator!
    var window: UIWindow?
    
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum TabBarItem:Int, CaseIterable{
        case nowPlaying
        case popular
        case upcoming
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        setupTabBarUI()
    }
    
    private func setupTabBarUI(){
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .none
    }
    
    private func setupTabBarItems(){
        self.viewControllers =  TabBarItem.allCases.map({
            let view = viewControllerForTabBarItem($0)
            let navgtion = UINavigationController(rootViewController: view)
            return navgtion
        })
    }
    
    func viewControllerForTabBarItem(_ item: TabBarItem) -> UIViewController{
        switch item{
        case .nowPlaying:
            let view = coordinator.Main.viewcontroller(for: .nowPlaying)
            view.tabBarItem = tabBarItem(for: item)
            return view
        case .popular:
            let view = coordinator.Main.viewcontroller(for: .popular)
            view.tabBarItem = tabBarItem(for: item)
            return view
        case .upcoming:
            let view = coordinator.Main.viewcontroller(for: .upcoming)
            view.tabBarItem = tabBarItem(for: item)
            return view
        }
    }
    
    private func tabBarItem(for item: TabBarItem) -> UITabBarItem?{
        let tabBarItem: UITabBarItem
        switch item{
        case .nowPlaying:
            tabBarItem = .init(
                title: "Now Playing",
                image: #imageLiteral(
                    resourceName: "UnselectStory"
                ),
                selectedImage: #imageLiteral(
                    resourceName: "UnselectStory"
                )
            )
        case .popular:
            tabBarItem = .init(
                title: "Popular",
                image: #imageLiteral(
                    resourceName: "UnselectStory"
                ),
                selectedImage: #imageLiteral(
                    resourceName: "UnselectStory"
                )
            )
        case .upcoming:
            tabBarItem = .init(
                title: "Upcoming",
                image: #imageLiteral(
                    resourceName: "UnselectStory"
                ),
                selectedImage: #imageLiteral(
                    resourceName: "UnselectStory"
                )
            )
        }
        return tabBarItem
    }
    
}
