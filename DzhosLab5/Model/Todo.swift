import SwiftData
import Foundation

@Model
final class Todo {
    var text: String
    var timestamp: Date
    let id: UUID
    
    init(text: String) {
        self.text = text
        self.timestamp = .now
        self.id = UUID()
    }
}
