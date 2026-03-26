//Author: Blen Abebe
//Shalev Haimovitz
//Jonathan Ivanov
//Melica Alikhani-Marquet

import Foundation

struct MoodEntry: Identifiable, Codable, Hashable {
    let id: UUID
    var mood: String
    var note: String
    var date: Date

    init(
        id: UUID = UUID(),
        mood: String,
        note: String,
        date: Date = Date()
    ) {
        self.id = id
        self.mood = mood
        self.note = note
        self.date = date
    }
}
