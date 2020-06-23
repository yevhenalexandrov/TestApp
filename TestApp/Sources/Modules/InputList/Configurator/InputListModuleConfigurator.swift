
import Swinject
import UIKit


class InputListModuleConfigurator {

    private enum Constants {
        static let storyboardName = "InputList"
    }

    private let diContainer: Container
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }

    func moduleViewAndInput() -> (InputListViewController, InputListModuleInput) {
        let moduleView = moduleViewController()
        let moduleInput = moduleConfigured(for: moduleView)
        return (moduleView, moduleInput)
    }

    // MARK: - Private Methods
    
    private func moduleViewController() -> InputListViewController {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: Bundle.main)
        return storyboard.instantiate() as InputListViewController
    }
    
    private func moduleConfigured(for viewController: InputListViewController) -> InputListModuleInput {
        let router = InputListRouter()
        let presenter = InputListPresenter()
        let interactor = InputListInteractor(diContainer: diContainer)
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        return presenter
    }

}
