//
//  MicroWin.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

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
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.details = details.trimmingCharacters(in: .whitespacesAndNewlines)
        self.date = date
    }

    var hasDetails: Bool {
        !details.isEmpty
    }

    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}
