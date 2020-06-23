
import Foundation


struct InputFieldModel: Codable {
    
    let id: String
    let type: String
    let title: String?
    let text: String?
    let subtitle: String?
    let description: String
    let placeholder: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, type, title, text, subtitle, description, placeholder
    }
    
    // MARK: - Init Decoder

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        description = try container.decode(String.self, forKey: .description)
        placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder) ?? ""
    }
    
}


extension InputFieldModel {
    
    init(_ item: InputListViewModel) {
        self.id = item.id
        self.type = item.contentType.rawString
        self.title = item.title
        self.text = item.text
        self.subtitle = item.subtitle
        self.description = item.descriptionText
        self.placeholder = item.placeholder
    }
}

