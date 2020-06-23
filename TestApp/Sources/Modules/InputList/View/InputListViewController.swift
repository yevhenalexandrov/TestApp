
import UIKit


protocol InputListViewInput: class {

    func setupInitialState()
    func setState(_ state: InputListViewController.State)
}


protocol InputListViewOutput {
    
    func viewIsReady()
    func didTapSendButton()
    func didTriggerRefreshItems()
    func field(_ fieldID: String, didChangeTextTo text: String)
}


class InputListViewController: BaseViewController,
    Instantiatable,
    InputListViewInput
{
    private enum Constants {
        static let commonInset: CGFloat = 20.0
        static let heightOfInternalView: CGFloat = 40.0
    }
    
    enum State {
        case empty
        case loaded([InputListViewModel])
        case failed
        
        func apply(on view: InputListViewController) {
            switch self {
            case .loaded(let items):
                view.refreshControl.endRefreshing()
                view.items = items
            case .empty:
                view.refreshControl.endRefreshing()
                view.showAlertEmptyList()
            case .failed:
                view.refreshControl.endRefreshing()
                break
            }
        }
    }
    
    // MARK: - Public properties

    var output: InputListViewOutput!

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var items: [InputListViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: - InputListViewInput
    
    func setupInitialState() {
        setNavigationItemTitle("Input Fields")
        setupCollectionView()
        setKeyboardDismissable()
    }
    
    func setState(_ state: State) {
        state.apply(on: self)
    }
    
    // MARK: Actions
    
    @IBAction func onSendButton(_ sender: Any) {
        output.didTapSendButton()
    }
    
    @objc private func pullToRefresh() {
        output.didTriggerRefreshItems()
    }
    
}


// MARK: - Private Methods

private extension InputListViewController {
    
    func setupCollectionView() {
        collectionView.register(cell: InputListViewCell.self)
        
        let contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = contentInset
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15.0
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.refreshControl = refreshControl
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func showAlertEmptyList() {
        presentAlertWithTitleAndMessage(title: "The input list is empty!",
                                        message: nil,
                                        options: "OK") { (view, option) in
            switch option {
            default:
                view.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func calculateSectionHeight(for indexPath: IndexPath) -> CGFloat {
        guard let item = items[safe: indexPath.row] else { return 0 }
        let containerHeight = ceil(CGFloat(item.contentType.rawValue) * Constants.heightOfInternalView)
        return containerHeight
    }
}


// MARK: - UICollectionViewDataSource

extension InputListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputListViewCell.defaultReuseIdentifier,
                                                            for: indexPath) as? InputListViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.delagate = self
        return cell
    }
}


// MARK: - UICollectionViewDelegate

extension InputListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? InputListViewCell, let item = items[safe: indexPath.row] else { return }
        cell.configure(with: item)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension InputListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let heightOfSection = calculateSectionHeight(for: indexPath)
        return CGSize(width: collectionView.bounds.width, height: heightOfSection)
    }
}


// MARK: - InputListViewCellDelegate

extension InputListViewController: InputListViewCellDelegate {
    
    func didChangeText(for textFieldID: String, changeTo text: String) {
        output.field(textFieldID, didChangeTextTo: text)
    }
}
