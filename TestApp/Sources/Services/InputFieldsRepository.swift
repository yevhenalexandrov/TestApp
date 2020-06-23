
import Foundation


public typealias JSON = [String: Any]


enum InputFieldsRepositoryError: Error {
    case unableToFetchData
}


class InputFieldsRepository: InputFieldsRepositoryProtocol {
    
    private enum Defaults {
        static let mockDataFileName = "InputTestResponse"
    }
    
    func obtainInputFieldList(completionBlock: @escaping (Result<[InputFieldModel], InputFieldsRepositoryError>) -> Void) {
        let inputFields = fetchMockData()
        completionBlock(.success(inputFields))
    }
}


// MARK: - Private Methods

private extension InputFieldsRepository {
    
    func fetchMockData() -> [InputFieldModel] {
        guard let jsonObject = try! JSONSerialization.jsonObject(inBundle: Bundle.main,
                                                                 fromResource: Defaults.mockDataFileName,
                                                                 withExtension: "json") as? JSON
        else {
            return []
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let serverModel = try JSONDecoder().decode(InputFieldListModel.self, from: jsonData)
            return serverModel.fields
        } catch {
            debugPrint("Could not decode object, due to an error = \(error)")
        }
        
        return []
    }
}
