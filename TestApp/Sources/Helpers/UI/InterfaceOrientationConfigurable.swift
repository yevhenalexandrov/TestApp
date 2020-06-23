import UIKit


protocol InterfaceOrientationConfigurable {
    
    func update(supportedInterfaceOrientation orientation: UIInterfaceOrientationMask)
    func update(shouldAutorotate: Bool)
}
