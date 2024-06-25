import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        let manualCallController = UINavigationController(rootViewController: ManualCallController())
        manualCallController.tabBarItem.title = "Manual"
        
        let straightforwardController = UINavigationController(rootViewController: StraightForwardController())
        straightforwardController.tabBarItem.title = "Straight"
        
        let customAnimationController = UINavigationController(rootViewController: CustomAnimationController())
        customAnimationController.tabBarItem.title = "Custom"
        
        let navigationController = UINavigationController(rootViewController: NavigationCallController())
        navigationController.tabBarItem.title = "Navigation"
        
        let windowController = UINavigationController(rootViewController: WindowCallController())
        windowController.tabBarItem.title = "Window"
        
        viewControllers = [straightforwardController, manualCallController, customAnimationController, navigationController, windowController]
    }
}
