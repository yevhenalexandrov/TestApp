import Foundation


struct InputFieldListModel: Decodable, Encodable {
    
    var fields: [InputFieldModel] =  []
    
    init(_ fields: [InputFieldModel]) {
        self.fields = fields
    }
    
    // MARK: - Init Decoder
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let items = try container.decode([InputFieldModel].self, forKey: .fields)

        self.init(items)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fields, forKey: .fields)
    }
}


extension InputFieldListModel {
    
    private enum CodingKeys: String, CodingKey {
        case fields
    }
    
}


extension InputFieldListModel {
    
    func toDataObject() -> Data? {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        return data
    }
}
