//
//  MoodEntry.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

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
        self.mood = mood.trimmingCharacters(in: .whitespacesAndNewlines)
        self.note = note.trimmingCharacters(in: .whitespacesAndNewlines)
        self.date = date
    }

    var hasNote: Bool {
        !note.isEmpty
    }

    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}
