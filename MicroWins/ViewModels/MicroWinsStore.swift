//
//  MicroWinsStore.swift
//  MicroWins
//
//  Created by Blen Abebe on 2026-03-25.
//

import Foundation
import Combine

final class MicroWinsStore: ObservableObject {
    @Published var microWins: [MicroWin] = [] {
        didSet {
            saveMicroWins()
        }
    }

    @Published var moodEntries: [MoodEntry] = [] {
        didSet {
            saveMoodEntries()
        }
    }

    private let microWinsKey = "microWinsKey"
    private let moodEntriesKey = "moodEntriesKey"

    init() {
        loadData()

        if microWins.isEmpty {
            microWins = [
                MicroWin(
                    title: "Started the MicroWins app",
                    details: "Created the project structure and first screens."
                ),
                MicroWin(
                    title: "Stayed productive today",
                    details: "Worked step by step and kept making progress."
                )
            ]
        }

        if moodEntries.isEmpty {
            moodEntries = [
                MoodEntry(
                    mood: "Motivated",
                    note: "Feeling good about building the app."
                )
            ]
        }
    }

    func addMicroWin(title: String, details: String) {
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanDetails = details.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanTitle.isEmpty else { return }

        let newWin = MicroWin(
            title: cleanTitle,
            details: cleanDetails.isEmpty ? "No details added." : cleanDetails
        )

        microWins.insert(newWin, at: 0)
    }

    func deleteMicroWin(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            microWins.remove(at: index)
        }
    }

    func deleteMicroWin(_ win: MicroWin) {
        microWins.removeAll { $0.id == win.id }
    }

    func addMood(mood: String, note: String) {
        let cleanMood = mood.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanNote = note.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanMood.isEmpty else { return }

        let newMood = MoodEntry(
            mood: cleanMood,
            note: cleanNote.isEmpty ? "No note added." : cleanNote
        )

        moodEntries.insert(newMood, at: 0)
    }

    func deleteMood(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            moodEntries.remove(at: index)
        }
    }

    var totalWins: Int {
        microWins.count
    }

    var totalMoodEntries: Int {
        moodEntries.count
    }

    var thisWeekWins: Int {
        let calendar = Calendar.current
        return microWins.filter {
            calendar.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }.count
    }

    var latestMood: String {
        moodEntries.first?.mood ?? "No mood yet"
    }

    private func saveMicroWins() {
        if let encoded = try? JSONEncoder().encode(microWins) {
            UserDefaults.standard.set(encoded, forKey: microWinsKey)
        }
    }

    private func saveMoodEntries() {
        if let encoded = try? JSONEncoder().encode(moodEntries) {
            UserDefaults.standard.set(encoded, forKey: moodEntriesKey)
        }
    }

    private func loadData() {
        if let savedWins = UserDefaults.standard.data(forKey: microWinsKey),
           let decodedWins = try? JSONDecoder().decode([MicroWin].self, from: savedWins) {
            microWins = decodedWins
        }

        if let savedMoods = UserDefaults.standard.data(forKey: moodEntriesKey),
           let decodedMoods = try? JSONDecoder().decode([MoodEntry].self, from: savedMoods) {
            moodEntries = decodedMoods
        }
    }
}
