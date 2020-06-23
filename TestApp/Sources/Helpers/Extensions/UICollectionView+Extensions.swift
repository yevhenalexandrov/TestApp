import UIKit


extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(cell: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
}
