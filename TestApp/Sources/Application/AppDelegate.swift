
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appRouter: ApplicationRouter!
    var applicationDIContainer = ApplicationDIContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        
        appRouter = ApplicationRouter(
            window: window!,
            diContainer: applicationDIContainer.container
        )
        appRouter.presentStartupScreen()
        
        return true
    }
}


// MARK: - Private Methods

private extension AppDelegate {
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
