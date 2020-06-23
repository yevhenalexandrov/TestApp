
import UIKit
import RxSwift
import RxCocoa


protocol InputListViewCellDelegate: class {
    
    func didChangeText(for textFieldID: String, changeTo text: String)
}


class InputListViewCell: UICollectionViewCell,
    Reusable,
    Configurable,
    NibLoadableView
{
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UnderlinedTextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet private var viewFields: [UILabel] = []
    
    // MARK: - Public Properties
    
    weak var delagate: InputListViewCellDelegate?
    
    // MARK: - Private Properties
    
    private var viewModel: InputListViewModel?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Overridden Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: Configurable Methods
    
    func configure(with viewModel: InputListViewModel) {
        self.viewModel = viewModel
        
        reduceViewsIfNeeded(for: viewModel.contentType)
        updateLabels(for: viewModel, contentType: viewModel.contentType)
    }
}


// MARK: - Private Methods

private extension InputListViewCell {
    
    func setupViews() {
        containerView.borderColor = UIColor(red: 225, green: 225, blue: 232, alpha: 1.0)
        containerView.borderWidth = 1.0
        containerView.roundCorners(
            corners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
            cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner],
            radius: 8.0
        )
        
        viewFields.forEach { $0.text = "" }
        inputTextField.borderWidthField = 1.0
        
        bindTextField()
    }
    
    func bindTextField() {
        inputTextField.rx.text
            .asDriver()
            .skip(1)
            .map { $0 ?? "" }
            .drive(onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.didChangeText(text: text)
            }).disposed(by: disposeBag)
    }
    
    func hideInternalView(with index: Int) {
        guard let arrangedView = stackView.arrangedSubviews[safe: index] else { return }
        arrangedView.isHidden = true
    }
    
    func showAllArrangedSubviews() {
        stackView.arrangedSubviews.forEach { $0.isHidden = false }
    }
    
    func reduceViewsIfNeeded(for contentType: InputListViewType) {
        showAllArrangedSubviews()
        
        switch contentType {
        case .input:
            hideInternalView(with: 0)
        default:
            break
        }
    }
    
    func updateLabels(for viewModel: InputListViewModel, contentType: InputListViewType) {
        switch contentType {
        case .input:
            self.titleLabel.text = viewModel.title
            self.inputTextField.text = viewModel.text
            self.inputTextField.placeholder = viewModel.placeholder
            self.inputTextField.isUserInteractionEnabled = true
            self.descriptionLabel.text = viewModel.descriptionText
            self.inputTextField.borderColorField = UIColor(red: 225, green: 225, blue: 232, alpha: 1.0)
        case .text:
            self.titleLabel.text = viewModel.title
            self.inputTextField.text = viewModel.subtitle
            self.inputTextField.isUserInteractionEnabled = false
            self.descriptionLabel.text = viewModel.descriptionText
            self.inputTextField.borderColorField = UIColor.white
        default:
            break
        }
    }
    
    func didChangeText(text: String) {
        guard let viewModel = viewModel else { return }
        self.delagate?.didChangeText(for: viewModel.id, changeTo: text)
    }
}
