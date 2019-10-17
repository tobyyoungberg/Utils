//
//  Coordinator.swift
//

import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController { get }
    func start()
}

protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func childCoordinatorDidFinish(_ child: Coordinator)
}

extension ParentCoordinator {
    func childCoordinatorDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
            }
        }
    }
}

protocol ChildCoordinator: Coordinator {
    var parentCoordinator: ParentCoordinator? { get }
    func finish()
}

extension ChildCoordinator {
    func finish() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
}
