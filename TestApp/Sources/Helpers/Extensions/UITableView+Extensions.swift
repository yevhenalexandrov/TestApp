
import UIKit


extension UITableView {
    
    public func register<T: UITableViewCell>(cell: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("no cell with identifier \(T.defaultReuseIdentifier) could be dequeued")
        }
        return cell
    }
    
}
