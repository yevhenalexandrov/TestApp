
import Foundation


protocol InputFieldsRepositoryProtocol: class {
    
    func obtainInputFieldList(completionBlock: @escaping (Result<[InputFieldModel], InputFieldsRepositoryError>) -> Void) 
}
