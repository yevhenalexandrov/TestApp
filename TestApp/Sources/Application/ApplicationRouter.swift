
import UIKit
import Swinject


class ApplicationRouter {
    
    enum RoutingSection {
        case inputList
    }
    
    private var window: UIWindow
    private let diContainer: Container
    private var routingSection: RoutingSection = .inputList
    
    init(window: UIWindow, diContainer: Container) {
        self.window = window
        self.diContainer = diContainer
    }
    
    func presentStartupScreen() {
        switch routingSection {
        case .inputList:
            presentInputListModule()
        }
    }
    
    // MARK: - Private methods
    
    private func presentInputListModule() {
        let configurator = InputListModuleConfigurator(diContainer: diContainer)
        let (moduleView, _) = configurator.moduleViewAndInput()
        
        let navigationController = UINavigationController(rootViewController: moduleView)
        navigationController.navigationBar.prefersLargeTitles = true
        
        window.switchRootViewController(navigationController)
    }
}
