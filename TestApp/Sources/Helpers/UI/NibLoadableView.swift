import UIKit


public protocol NibLoadableView: class {
    
    static var nibName: String { get }
}


extension NibLoadableView where Self: UIView {
    
    static public var nibName: String {
        return String(describing: self)
    }
}
