//
//  MainTabBarController.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
        selectedIndex = FlowTabBarItem.Gallery.rawValue
        delegate = self
    }
    
    private func setupTabBar() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = AppColor.backgroundLight
        tabBar.unselectedItemTintColor = AppColor.backgroundSliderHighlighted
        tabBar.tintColor = AppColor.backgroundAccent
    }
    
    private func setupViewControllers() {
        var viewControllersArray: [UIViewController] = []
        FlowTabBarItem.allCases.forEach { item in
            switch item {
            case .Favorites:
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    break
                case .pad, .tv, .carPlay, .mac, .vision, .unspecified:
                    let vc = UIViewController()
                    let tabBarItem = UITabBarItem(title: nil, image: item.icon, selectedImage: item.icon)
                    vc.tabBarItem = tabBarItem
                    viewControllersArray.append(vc)

                @unknown default:
                    break
                }
            case .Gallery:
                let vm = NewPhotosViewModel()
                let vc = NewPhotosViewController(vm: vm)
                let tabBarItem = UITabBarItem(title: nil, image: item.icon, selectedImage: item.icon)
                vc.tabBarItem = tabBarItem
                viewControllersArray.append(vc)
            case .Messages, .Profile, .Search, .VideoChat:
                let vc = UIViewController()
                let tabBarItem = UITabBarItem(title: nil, image: item.icon, selectedImage: item.icon)
                vc.tabBarItem = tabBarItem
                viewControllersArray.append(vc)
            }
        }
        viewControllers = viewControllersArray
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

}
