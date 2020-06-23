
import Foundation


class InputListViewModel {
    
    var id: String = ""
    var title: String = ""
    var text: String = ""
    var subtitle: String = ""
    var descriptionText: String = ""
    var placeholder: String = ""
    var contentType: InputListViewType = .text
    
    init(_ item: InputFieldModel) {
        self.id = item.id
        self.title = item.title ?? ""
        self.contentType = InputListViewType(rawString: item.type)
        self.text = item.text ?? ""
        self.subtitle = item.subtitle ?? ""
        self.descriptionText = item.description
        self.placeholder = item.placeholder ?? ""
    }
}


enum InputListViewType: Int {
    case input = 2, text = 3, unknown = -1
    
    init(rawString: String) {
        switch rawString {
        case "text": self = .text
        case "input": self = .input
        default: self = .unknown
        }
    }
    
    var rawString: String {
        switch self {
        case .input: return "input"
        case .text: return "input"
        default: return ""
        }
    }
}


