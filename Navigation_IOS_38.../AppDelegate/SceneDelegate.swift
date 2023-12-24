//
//  SceneDelegate.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//
import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let appConfiguration: AppConfiguration = AppConfiguration.notFound
        NetworkService.request(for: appConfiguration)
        
        let window = UIWindow(windowScene: scene)
        let fileManagerService = FileManagerService()
        let controller = ListViewController(fileManagerService: fileManagerService)
        controller.title = "Documents"
        let named = UIImage(named: "Image 1")
        controller.tabBarItem = UITabBarItem(title: "Documents", image: UIImage(systemName: "Image 1"), tag: 0)
        let navigationController = UINavigationController(rootViewController: controller)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
    }
    
    private func createFeedViewController() -> UINavigationController {
        let feedViewController = PostViewController(post: Post(author: "", description: "", image: "", likes: 0, views: 0))
        feedViewController.title = "Лента"
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
        
    }
    
    private func createProfileViewController() -> UINavigationController {
        let profileViewController = LogInViewController.init(user: .init(login: "", firstName: "", avatar: .init(), status: ""), viewModel: ProfileVMImp.init())
        let factory = MyLogInFactory()
        let inspector = factory.makeLoginInspector()
        profileViewController.delegate = inspector
        
        profileViewController.title = "Профиль"
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        return UINavigationController(rootViewController: profileViewController)
    }
    
    private func createTabBarController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        UITabBar.appearance().backgroundColor = .systemGray6
        tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
        
        return tabBarController
        
    }
    
    //
    func sceneDidDisconnect(_ scene: UIScene) {
        
        func logoutUser(completion: @escaping(Result<Void, Error>) -> Void) {
            do {
                try Auth.auth().signOut()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
        }
        
        
    }
}
