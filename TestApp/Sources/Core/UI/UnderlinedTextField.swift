
import UIKit


@IBDesignable class UnderlinedTextField: UITextField {

    private let border = CALayer()

    @IBInspectable var borderColorField: UIColor = UIColor.white {
        didSet {
            setup()
        }
    }

    @IBInspectable var borderWidthField: CGFloat = 0.5 {
        didSet {
            setup()
        }
    }

    override init(frame : CGRect) {
        super.init(frame : frame)
        setup()
    }

    convenience init() {
        self.init(frame:CGRect.zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    func setup() {
        border.borderColor = self.borderColorField.cgColor
        border.borderWidth = borderWidthField
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidthField, width:  self.frame.size.width, height: self.frame.size.height)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 0)
    }
}
