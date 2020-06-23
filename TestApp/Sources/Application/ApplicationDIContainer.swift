import Foundation
import Swinject


class ApplicationDIContainer {
    
    let container = Container()
    
    init() {
        registerRepositories()
    }
}


private extension ApplicationDIContainer {
    
    func registerRepositories() {
        container.register(InputFieldsRepositoryProtocol.self) { resolver in
            return InputFieldsRepository()
        }.inObjectScope(.container)
    }
    
}
