//
//  BaseCoordinator.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import UIKit
//переход с верхнего уровня на нижний и обратно.
typealias Action = (() -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: LoginBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
        
    }
    //func resetToRoot() - метод который может катить к обратному контроллеру
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
//func showDetailScreen() - метод перейти на след/экран (переход на тот или иной экран)
protocol ProfileBaseCoordinator: Coordinator {
    func showDetailScreen()
}

protocol FeedBaseCoordinator: Coordinator {
    func showDetailScreen()
}
//func moveTo(flow: AppFlow) - метод который позволит переключаться между flow
protocol LoginBaseCoordinator: Coordinator {
    var profileCoordinator: ProfileBaseCoordinator { get }
    var feedCoordinator: FeedBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}
