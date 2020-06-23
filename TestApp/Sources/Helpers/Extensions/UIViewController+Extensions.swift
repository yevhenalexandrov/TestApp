
import UIKit


extension UIViewController {
    
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}


extension UIViewController {

    func presentAlertWithTitleAndMessage(title: String?, message: String?, options: String..., completion: @escaping (_ view: UIAlertController, _ index: Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for (index, option) in options.enumerated() {
            let action = UIAlertAction(title: option, style: .default) { action in
                completion(alertController, index)
            }
            alertController.addAction(action)
        }
        
        topMostViewController().present(alertController, animated: true, completion: nil)
    }
}


public extension UIViewController {
    
    func setNavigationItemTitle(_ title: String) {
        self.navigationItem.title = title
    }
}


public extension UIViewController {
    
    func setKeyboardDismissable() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
