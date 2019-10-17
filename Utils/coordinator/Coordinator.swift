//
//  Coordinator.swift
//

import UIKit

public protocol Coordinator: AnyObject {
    var rootViewController: UIViewController { get }
    func start()
}

public protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func childCoordinatorDidFinish(_ child: Coordinator)
}

public extension ParentCoordinator {
    func childCoordinatorDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
            }
        }
    }
}

public protocol ChildCoordinator: Coordinator {
    var parentCoordinator: ParentCoordinator? { get }
    func finish()
}

public extension ChildCoordinator {
    func finish() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
}
