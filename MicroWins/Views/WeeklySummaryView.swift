import SwiftUI

struct WeeklySummaryView: View {
    @EnvironmentObject private var store: MicroWinsStore

    private var weeklyMessage: String {
        if store.thisWeekWins >= 5 {
            return "Amazing work this week. You stayed consistent and kept showing up for yourself."
        } else if store.thisWeekWins >= 1 {
            return "Nice progress this week. Every small step is helping you build momentum."
        } else {
            return "Your week is a fresh opportunity. Start with one small win and build from there."
        }
    }

    var body: some View {
        ZStack {
            // 🔥 DARK + PINK BACKGROUND (MATCHES APP)
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.08, green: 0.01, blue: 0.06),
                    Color(red: 0.18, green: 0.03, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {

                    topCard

                    // MARK: STATS
                    HStack(spacing: 14) {
                        statCard(
                            title: "Total Wins",
                            value: "\(store.totalWins)",
                            subtitle: "All recorded wins",
                            icon: "star.fill",
                            tint: .pink
                        )

                        statCard(
                            title: "This Week",
                            value: "\(store.thisWeekWins)",
                            subtitle: "Wins this week",
                            icon: "calendar",
                            tint: .white
                        )
                    }

                    HStack(spacing: 14) {
                        statCard(
                            title: "Mood Entries",
                            value: "\(store.totalMoodEntries)",
                            subtitle: "Check-ins saved",
                            icon: "heart.fill",
                            tint: .pink
                        )

                        statCard(
                            title: "Latest Mood",
                            value: store.latestMood,
                            subtitle: "Most recent feeling",
                            icon: "face.smiling.fill",
                            tint: .white
                        )
                    }

                    reflectionCard
                    progressCard

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    // MARK: TOP CARD
    private var topCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Weekly Summary 📈")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Track your growth and reflect on your progress.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 56, height: 56)

                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
            }

            ProgressView(value: min(Double(store.thisWeekWins), 7), total: 7)
                .tint(.pink)

            Text("Weekly goal: \(store.thisWeekWins) / 7 wins")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.75))
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
        .shadow(color: Color.pink.opacity(0.30), radius: 16, x: 0, y: 8)
    }

    // MARK: REFLECTION CARD
    private var reflectionCard: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "bolt.heart.fill")
                .foregroundStyle(.pink)

            VStack(alignment: .leading, spacing: 6) {
                Text("Weekly Reflection")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(weeklyMessage)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.pink.opacity(0.20), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    // MARK: PROGRESS CARD
    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Progress Snapshot")
                .font(.headline)
                .foregroundStyle(.white)

            progressRow(title: "Wins This Week", value: store.thisWeekWins, total: 7)
            progressRow(title: "Mood Check-Ins", value: store.totalMoodEntries, total: max(store.totalMoodEntries, 7))

            VStack(alignment: .leading, spacing: 6) {
                Text("Latest Mood")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)

                Text(store.latestMood)
                    .font(.title3.bold())
                    .foregroundStyle(.pink)
            }
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.pink.opacity(0.20), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    // MARK: STAT CARD
    private func statCard(
        title: String,
        value: String,
        subtitle: String,
        icon: String,
        tint: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(tint.opacity(0.2))
                    .frame(width: 44, height: 44)

                Image(systemName: icon)
                    .foregroundStyle(tint)
            }

            Text(value)
                .font(.title.bold())
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.06))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.pink.opacity(0.18), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: tint.opacity(0.20), radius: 10, x: 0, y: 5)
    }

    // MARK: PROGRESS ROW
    private func progressRow(title: String, value: Int, total: Int) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(value)")
                    .foregroundStyle(.white.opacity(0.6))
            }

            ProgressView(value: Double(value), total: Double(max(total, 1)))
                .tint(.pink)
        }
    }
}
