
import Foundation


public extension JSONSerialization {
    
    static func jsonObject(inBundle bundle: Bundle, fromResource resourceName: String, withExtension ext: String) throws -> Any {
        let jsonURL = bundle.url(forResource: resourceName, withExtension: ext)!
        let jsonData = try Data(contentsOf: jsonURL, options: [])
        return try JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    
}
