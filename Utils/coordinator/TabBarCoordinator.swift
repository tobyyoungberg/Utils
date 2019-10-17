//
//  TabBarCoordinator.swift
//

import UIKit

public protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get }
    var tabs: [TabCoordinator] { get }
}

public protocol TabCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
    var tabImage: UIImage? { get }
    var tabTitle: String? { get }

    func configureTab()
}

public extension TabBarCoordinator {
    var rootViewController: UIViewController {
        return tabBarController
    }

    func start() {
        tabs.forEach {
            $0.configureTab()
            $0.start()
        }
        let viewControllers = tabs.map { $0.rootViewController }
        tabBarController.setViewControllers(viewControllers, animated: false)
    }
}

public extension TabCoordinator {
    var rootViewController: UIViewController {
        return navigationController
    }

    func configureTab() {
        navigationController.tabBarItem = UITabBarItem(title: tabTitle, image: tabImage, selectedImage: tabImage)
    }
}
