import SwiftUI

struct MoodCheckInView: View {
    @EnvironmentObject private var store: MicroWinsStore

    @State private var selectedMood = "Happy"
    @State private var note = ""
    @State private var showMessage = false

    private let moods = ["Happy", "Motivated", "Calm", "Tired", "Stressed"]

    private func moodEmoji(for mood: String) -> String {
        switch mood {
        case "Happy": return "😊"
        case "Motivated": return "🔥"
        case "Calm": return "😌"
        case "Tired": return "😴"
        case "Stressed": return "😣"
        default: return "🙂"
        }
    }

    private func moodColor(for mood: String) -> Color {
        switch mood {
        case "Happy": return Color.pink
        case "Motivated": return Color(red: 1.0, green: 0.35, blue: 0.65)
        case "Calm": return Color(red: 0.85, green: 0.45, blue: 0.70)
        case "Tired": return Color(red: 0.70, green: 0.25, blue: 0.50)
        case "Stressed": return Color(red: 1.0, green: 0.20, blue: 0.55)
        default: return .pink
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.10, green: 0.02, blue: 0.08),
                    Color(red: 0.18, green: 0.03, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    topCard
                    moodSelectorCard
                    noteCard

                    if showMessage {
                        successCard
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }

                    saveButton
                    recentMoodSection

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Mood Check-In")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .animation(.easeInOut(duration: 0.25), value: showMessage)
        .onChange(of: note) { _, _ in
            showMessage = false
        }
        .onChange(of: selectedMood) { _, _ in
            showMessage = false
        }
    }

    private var topCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Check in with yourself 💗")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Tracking your mood helps you understand your patterns and progress.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 56, height: 56)

                    Text(moodEmoji(for: selectedMood))
                        .font(.title)
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.20, blue: 0.55),
                    Color(red: 0.65, green: 0.10, blue: 0.35),
                    Color.black.opacity(0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.pink.opacity(0.35), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: Color.pink.opacity(0.25), radius: 16, x: 0, y: 8)
    }

    private var moodSelectorCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How are you feeling?")
                .font(.headline)
                .foregroundStyle(.white)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 95), spacing: 12)], spacing: 12) {
                ForEach(moods, id: \.self) { mood in
                    let isSelected = selectedMood == mood

                    Button {
                        selectedMood = mood
                    } label: {
                        VStack(spacing: 8) {
                            Text(moodEmoji(for: mood))
                                .font(.system(size: 28))

                            Text(mood)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 95)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    isSelected
                                    ? moodColor(for: mood).opacity(0.30)
                                    : Color.white.opacity(0.06)
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    isSelected ? moodColor(for: mood) : Color.white.opacity(0.10),
                                    lineWidth: isSelected ? 2 : 1
                                )
                        )
                        .shadow(
                            color: isSelected ? moodColor(for: mood).opacity(0.25) : .clear,
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.pink.opacity(0.20), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var noteCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Add a note")
                .font(.headline)
                .foregroundStyle(.white)

            TextField("What’s on your mind today?", text: $note, axis: .vertical)
                .foregroundStyle(.white)
                .textInputAutocapitalization(.sentences)
                .lineLimit(4...7)
                .padding()
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.pink.opacity(0.25), lineWidth: 1)
                )

            HStack(spacing: 10) {
                Image(systemName: "heart.text.square.fill")
                    .foregroundStyle(.pink)

                Text("Optional: add a quick thought about why you feel this way.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.70))
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.pink.opacity(0.20), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var successCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.pink.opacity(0.18))
                    .frame(width: 42, height: 42)

                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.pink)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Mood saved")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Your mood check-in was added successfully.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.72))
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.pink.opacity(0.22), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var saveButton: some View {
        Button {
            store.addMood(mood: selectedMood, note: note)
            note = ""
            showMessage = true
        } label: {
            HStack {
                Spacer()

                Label("Save Mood", systemImage: "heart.fill")
                    .font(.headline)

                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.20, blue: 0.55),
                        Color(red: 0.75, green: 0.10, blue: 0.40)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.pink.opacity(0.30), radius: 10, x: 0, y: 5)
        }
    }

    private var recentMoodSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Recent Check-Ins")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(min(store.moodEntries.count, 5)) shown")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.65))
            }

            if store.moodEntries.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "heart.slash")
                        .font(.largeTitle)
                        .foregroundStyle(.pink.opacity(0.8))

                    Text("No mood entries yet")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("Your recent mood check-ins will appear here.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.70))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
                .background(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.pink.opacity(0.20), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))
            } else {
                ForEach(store.moodEntries.prefix(5)) { entry in
                    HStack(alignment: .top, spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(moodColor(for: entry.mood).opacity(0.22))
                                .frame(width: 52, height: 52)

                            Text(moodEmoji(for: entry.mood))
                                .font(.title3)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(entry.mood)
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text(entry.note.isEmpty ? "No note added." : entry.note)
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.72))

                            Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.50))
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.white.opacity(0.06))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.pink.opacity(0.18), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                }
            }
        }
    }
}
