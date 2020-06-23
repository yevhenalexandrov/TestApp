
import Foundation
import SwiftyJSON


enum InputListViewInputField {
    
    case intro
    case name
    case surname
}


class InputListPresenter {

    weak var view: InputListViewInput!
    var interactor: InputListInteractorInput!
    var router: InputListRouterInput!
    
    // MARK: - Private Properties
    
    private var viewModels: [InputListViewModel] = []
}


// MARK: - InputListModuleInput

extension InputListPresenter: InputListModuleInput {}


// MARK: - InputListViewOutput

extension InputListPresenter: InputListViewOutput {
    
    func viewIsReady() {
    	view.setupInitialState()
        obtainInputList()
    }
    
    func field(_ fieldID: String, didChangeTextTo text: String) {
        if let model = viewModels.first(where: { $0.id == fieldID } ) {
            model.text = text
        }
    }
    
    func didTriggerRefreshItems() {
        obtainInputList()
    }
    
    func didTapSendButton() {
        printLogs()
    }
}


// MARK: - InputListInteractorOutput

extension InputListPresenter: InputListInteractorOutput {
    
    func didObtainInputList(items: [InputFieldModel]) {
        self.viewModels = items.map(InputListViewModel.init)
        let state: InputListViewController.State = viewModels.isEmpty ? .empty : .loaded(viewModels)
        view.setState(state)
    }
}


// MARK: - Private Methods

private extension InputListPresenter {
    
    func obtainInputList() {
        interactor.obtaintInputList()
    }
    
    func printLogs() {
        let fields = viewModels.compactMap(InputFieldModel.init)
        let wholeList = InputFieldListModel(fields)
        
        if let data = wholeList.toDataObject()  {
            let json = SwiftyJSON.JSON(data)
            print("\(json)")
        }
    }
}
