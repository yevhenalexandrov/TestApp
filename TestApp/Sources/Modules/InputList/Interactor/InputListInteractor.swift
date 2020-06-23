
import Swinject


protocol InputListInteractorInput {
    
    func obtaintInputList()
}

protocol InputListInteractorOutput: class {
    
    func didObtainInputList(items: [InputFieldModel])
}


class InputListInteractor {

    weak var output: InputListInteractorOutput!

    // MARK: - Private Properties
    
    private let inputFieldsRepository: InputFieldsRepositoryProtocol
    
    // MARK: - Lifecycle

    init(diContainer: Container) {
        self.inputFieldsRepository = diContainer.resolve(InputFieldsRepositoryProtocol.self)!
    }
}


// MARK: - InputListInteractorInput

extension InputListInteractor: InputListInteractorInput {
    
    func obtaintInputList() {
        inputFieldsRepository.obtainInputFieldList { [weak self] result in
            guard let `self` = self else { return }
            switch result {
             case .success(let items):
                self.output.didObtainInputList(items: items)
             case .failure(let error):
                 debugPrint(error.localizedDescription)
             }
        }
    }
}
