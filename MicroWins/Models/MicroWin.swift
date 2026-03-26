//Author: Blen Abebe
//Shalev Haimovitz
//Jonathan Ivanov
//Melica Alikhani-Marquet

import Foundation

struct MicroWin: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var details: String
    var date: Date

    init(
        id: UUID = UUID(),
        title: String,
        details: String,
        date: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.date = date
    }
}
